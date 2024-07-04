---
title: STM32 LED & KEY
date: 2024-01-21
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 4
description: 本文对STM32的LED和按键驱动进行了总结。
---

## GPIO {#gpio}

GPIO 是通用型输入输出，可以输入或输出高低电平。高电平是 3.3V，低电平是 0V。


### Output {#output}

输出控制器接两个 MOS 管，一个 PMOS 管，一个 NMOS 管。

| No | Q1 | Q2 | Status |
|----|----|----|--------|
| 1  | 打开 | 关闭 | 高电平 |
| 2  | 关闭 | 打开 | 低电平 |
| 3  | 打开 | 打开 | 短路/不可用 |
| 4  | 关闭 | 关闭 | 浮空/高阻态 |

三种可用的 MOS 管状态将输出分为了推挽输出和开漏输出。

其中，序号 1 和 2 组成了推挽输出，序号 2 和 4 组成了开漏输出。一般地，开漏输出需要搭配上拉电阻，以在高阻态时输出高电平，由于输出引脚并非直连电源电压，而是外部上拉电阻提供电压，因此开漏输出能够减小噪声对输出信号的影响。

使用推挽输出的场景较多，一般需要高低电平的场景都可以选择推挽输出，尤其是无上拉电阻的时候，建议选择推挽输出；在多个 IO 输出接到一个 IO 输入时（线与）需要选择开漏输出。

此外，对于接口电平转换，同供电电平选择推挽输出，不同供电电平选择开漏输出。


## LED {#led}


### Macro {#macro}

下面是定义 LED 的相关引脚代码

```cpp
#define LED1_Pin     GPIO_PIN_0
#define LED2_Pin     GPIO_PIN_1
#define LED1_GPIO_Port    GPIOB
#define LED2_GPIO_Port    GPIOB
```

下面是定义 LED 的相关逻辑代码

```cpp
#ifdef LED1_Pin
    #define LED1_ON() HAL_GPIO_WritePin(LED1_GPIO_Port,LED1_Pin,GPIO_PIN_RESET)
    #define LED1_OFF() HAL_GPIO_WritePin(LED1_GPIO_Port,LED1_Pin,GPIO_PIN_SET)
    #define LED1_Toggle() HAL_GPIO_TogglePin(LED1_GPIO_Port,LED1_Pin)
#endif

#ifdef LED2_Pin
    #define LED2_ON() HAL_GPIO_WritePin(LED2_GPIO_Port,LED2_Pin,GPIO_PIN_RESET)
    #define LED2_OFF() HAL_GPIO_WritePin(LED2_GPIO_Port,LED2_Pin,GPIO_PIN_SET)
    #define LED2_Toggle() HAL_GPIO_TogglePin(LED2_GPIO_Port,LED2_Pin)
#endif
```


## KEY {#key}


### Macro {#macro}

下面是定义 KEY 的相关代码

```cpp
#define KEY_UP_Pin          GPIO_PIN_0
#define KEY_RIGHT_Pin       GPIO_PIN_3  //实际上是KEY0
#define KEY_DOWN_Pin        GPIO_PIN_2  //实际上是KEY1
#define KEY_LEFT_Pin        GPIO_PIN_13 //实际上是KEY2
#define KEY_UP_GPIO_Port    GPIOA
#define KEY_RIGHT_GPIO_Port GPIOH
#define KEY_DOWN_GPIO_Port  GPIOH
#define KEY_LEFT_GPIO_Port  GPIOC
```


### Polling {#polling}

下面是一段轮询检测按键是否按下的代码，其中 `KEYS` 和 `key_wait_aways` 变量定义如下：

```cpp
typedef enum {
    KEY_NONE = 0,
    KEY_LEFT,
    KEY_RIGHT,
    KEY_UP,
    KEY_DOWN,
} KEYS;

const uint8_t key_wait_always = 0;
```

轮询检测代码如下，其中KEY_LEFT、KEY_RIGHT、KEY_DOWN都是低电平触发的。

```cpp
KEYS ScanPressedKey(uint32_t timeout){
    uint32_t tickstart = HAL_GetTick();
    const uint8_t btn_delay = 20;
    while(1){
#ifdef KEY_UP_Pin
        if(HAL_GPIO_ReadPin(KEY_UP_GPIO_Port,KEY_UP_Pin)==GPIO_PIN_SET){
            HAL_Delay(btn_pre_delay);
            if(HAL_GPIO_ReadPin(KEY_UP_GPIO_Port,KEY_UP_Pin)==GPIO_PIN_SET){
              return KEY_UP;
            }
        }
#endif
#ifdef KEY_LEFT_Pin
        if(HAL_GPIO_ReadPin(KEY_LEFT_GPIO_Port,KEY_LEFT_Pin)==GPIO_PIN_RESET){
            HAL_Delay(btn_pre_delay);
            if(HAL_GPIO_ReadPin(KEY_LEFT_GPIO_Port,KEY_LEFT_Pin)==GPIO_PIN_RESET){
              return KEY_LEFT;
            }
        }
#endif
#ifdef KEY_RIGHT_Pin
        if(HAL_GPIO_ReadPin(KEY_RIGHT_GPIO_Port,KEY_RIGHT_Pin)==GPIO_PIN_RESET){
            HAL_Delay(btn_pre_delay);
            if(HAL_GPIO_ReadPin(KEY_RIGHT_GPIO_Port,KEY_RIGHT_Pin)==GPIO_PIN_RESET){
              return KEY_RIGHT;
            }
        }
#endif
#ifdef KEY_DOWN_Pin
        if(HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port,KEY_DOWN_Pin)==GPIO_PIN_RESET){
            HAL_Delay(btn_pre_delay);
            if(HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port,KEY_DOWN_Pin)==GPIO_PIN_RESET){
              return KEY_DOWN;
            }
        }
#endif
        if(timeout!=key_wait_always){
            if((HAL_GetTick()-tickstart)>timeout)
                break;
        }
    }
}
```

主函数中代码如下：

```cpp
KEYS cur_key = ScanPressedKey(100);
const uint8_t btn_post_delay = 200;
switch (cur_key) {
case KEY_UP:
    LED1_ON();
    LED2_ON();
    printf("KEY_UP input.\n");
    break;
case KEY_LEFT:
    LED1_Toggle();
    printf("KEY_LEFT input.\n");
    break;
case KEY_RIGHT:
    LED2_Toggle();
    printf("KEY_RIGHT input.\n");
    break;
case KEY_DOWN:
    LED1_OFF();
    LED2_OFF();
    printf("KEY_DOWN input.\n");
    break;
default:
    printf("No input keys.\n");
    break;
}
HAL_Delay(btn_post_delay);
```


## Reuse code {#reuse-code}


### Main Function call {#main-function-call}

首先使用函数调用的方式优化代码，将主函数中冗长的switch语句变为新函数，然后手动调用该函数。

1.  `-Og -g` 下大小增加了32B
2.  `-Ofast -g` 下大小不变


### Macro Extend {#macro-extend}

宏展开的方法

```cpp
#define IS_KEY_UP_PRESSED()     (HAL_GPIO_ReadPin(KEY_UP_GPIO_Port, KEY_UP_Pin) == GPIO_PIN_SET)
#define IS_KEY_RIGHT_PRESSED()  (HAL_GPIO_ReadPin(KEY_RIGHT_GPIO_Port, KEY_RIGHT_Pin) == GPIO_PIN_RESET)
#define IS_KEY_DOWN_PRESSED()   (HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port, KEY_DOWN_Pin) == GPIO_PIN_RESET)
#define IS_KEY_LEFT_PRESSED()   (HAL_GPIO_ReadPin(KEY_LEFT_GPIO_Port, KEY_LEFT_Pin) == GPIO_PIN_RESET)
```

```cpp
if (IS_KEY_UP_PRESSED()) {
    HAL_Delay(btn_pre_delay);
    if (IS_KEY_UP_PRESSED()) {
        return KEY_UP;
    }
}
if (IS_KEY_LEFT_PRESSED()) {
    HAL_Delay(btn_pre_delay);
    if (IS_KEY_UP_PRESSED()) {
        return KEY_LEFT;
    }
}
if (IS_KEY_RIGHT_PRESSED()) {
    HAL_Delay(btn_pre_delay);
    if (IS_KEY_RIGHT_PRESSED()) {
        return KEY_RIGHT;
    }
}
if (IS_KEY_DOWN_PRESSED()) {
    HAL_Delay(btn_pre_delay);
    if (IS_KEY_DOWN_PRESSED()) {
        return KEY_DOWN;
    }
}
```

1.  `-Og -g` 下大小增加了144B
2.  `-Ofast -g` 下大小减少了4B


### Mutiple Funtion Call {#mutiple-funtion-call}

多次函数调用

```cpp
uint8_t is_key_pull_down_pressed(GPIO_TypeDef* gpio_port, uint16_t gpio_pin) {
    return (HAL_GPIO_ReadPin(gpio_port, gpio_pin) == GPIO_PIN_SET);
}
uint8_t is_key_pull_up_pressed(GPIO_TypeDef* gpio_port, uint16_t gpio_pin){
    return (HAL_GPIO_ReadPin(gpio_port,gpio_pin) == GPIO_PIN_RESET);
}

//省略函数形参
if(is_key_pull_down_pressed(KEY_UP_GPIO_Port,KEY_UP_Pin)){
    HAL_Delay(btn_pre_delay);
    if(is_key_pull_down_pressed(KEY_UP_GPIO_Port,KEY_UP_Pin)){
        return KEY_UP;
    }
}
if(is_key_pressed(KEY_LEFT_GPIO_Port,KEY_LEFT_Pin)){
    HAL_Delay(btn_pre_delay);
    if(is_key_pull_up_pressed(KEY_LEFT_GPIO_Port,KEY_LEFT_Pin)){
        return KEY_LEFT;
    }
}
if(is_key_pull_up_pressed(KEY_LEFT_GPIO_Port,KEY_LEFT_Pin)){
    HAL_Delay(btn_pre_delay);
    if(is_key_pull_up_pressed(KEY_LEFT_GPIO_Port,KEY_LEFT_Pin)){
        return KEY_LEFT;
    }
}
if(is_key_pull_up_pressed(KEY_RIGHT_GPIO_Port,KEY_RIGHT_Pin)){
    HAL_Delay(btn_pre_delay);
    if(is_key_pull_up_pressed(KEY_RIGHT_GPIO_Port,KEY_RIGHT_Pin)){
        return KEY_RIGHT;
    }
}
```


### Inline Function Call {#inline-function-call}

内联函数调用

```cpp
static inline uint8_t is_key_pressed(void) {
    return (HAL_GPIO_ReadPin(KEY_UP_GPIO_Port, KEY_UP_Pin) == GPIO_PIN_SET);
}

if (is_key_pressed()) {
    HAL_Delay(btn_pre_delay);  // 等待按键稳定
    if (is_key_pressed()) {
        return KEY_UP;
    }
}
```


### Combined Function Call {#combined-function-call}

合并函数调用

```cpp
bool is_key_pressed(uint16_t gpio_pin_set_status,GPIO_TypeDef* gpio_port,uint16_t gpio_pin){
    if(HAL_GPIO_ReadPin(gpio_port,gpio_pin) == gpio_pin_set_status){
        HAL_Delay(btn_pre_delay);
        if(HAL_GPIO_ReadPin(gpio_port,gpio_pin) == gpio_pin_set_status)
            return true;
    }
}
```


### Template {#template}

C++函数模板调用

```cpp
template<typename GPIO_Port, typename GPIO_Pin>
bool is_key_pressed() {
    return (HAL_GPIO_ReadPin(GPIO_Port, GPIO_Pin) == GPIO_PIN_SET);
}

if (is_key_pressed<KEY0_GPIO_Port, KEY0_Pin>()) {
    HAL_Delay(20);  // 等待按键稳定
    if (is_key_pressed<KEY0_GPIO_Port, KEY0_Pin>()) {
        return KEY_0;
    }
}
```
