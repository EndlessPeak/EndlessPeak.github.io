---
title: STM32 Clion Develop
date: 2023-11-02
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 3
description: 本文主要记录使用Clion开发STM32的相关经验。
---

## ToolChain {#toolchain}


### Embedded Toolchain {#embedded-toolchain}

需要配置嵌入式编译工具链，它应该包括：

1.  arm-none-eabi-gcc
2.  arm-none-eabi-g++
3.  arm-none-eabi-ar
4.  arm-none-eabi-ld (bfd 链接方式)
5.  arm-none-eabi-gdb
6.  arm-none-eabi-nm
7.  arm-none-eabi-objcopy
8.  arm-none-eabi-objdump

在 NixOS 上配置工具链需要如下软件包：

```nix
packages = with pkgs; [
  gcc-arm-embedded
];
```

在 Arch Linux 上需要安装如下软件包：

```shell
pacman -S arm-none-eabi-bintils arm-none-eabi-gcc arm-none-eabi-gdb arm-none-eabi-newlib
```

其中， `arm-none-eabi-newlib` 是用于编译程序的库文件，脱离库文件无法正确生成可执行的文件。


### OpenOCD {#openocd}

需要安装烧录和在线调试工具 OpenOCD(Open On-Chip Debugger) 以及连接工具 ST-Link(也可以是其他工具)

OpenOCD 的烧录需要配置相关的参数，以 cfg 格式记录在文件中。

```cfg
source [find interface/stlink.cfg]
transport select hla_swd
source [find target/stm32f7x.cfg]
reset_config none
adapter speed 10000 # 配置速率是必须的，否则无法正常完成下载
```


## CLion {#clion}


### Transfer {#transfer}

对之前以 `stm32cubeide` 或 `stm32cubemx` 开发的项目，可以方便地转化为 Clion 项目，转化的必要条件是:

1.  项目包含 `.cproject` 等必要的项目描述文件
2.  项目包含 `STM32F767IGTX_FLASH.ld` 等内存描述文件

转化的过程是：

1.  直接用 `clion` 打开 `stm32cubeide` 项目
2.  配置相关的 `CMakeLists.txt` 文件，主要是相关的编译工具链
    1.  方法一：将工具链目录加入 PATH
    2.  方法二：为工具链编写绝对路径
3.  重启 Clion，依次选择 Tools → CMake → Reset Cache and Reload Project


### CMakeLists {#cmakelists}

下面提供一份可用的 CMakeLists.txt 文件

```cmake
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
cmake_minimum_required(VERSION 3.24)

# specify cross-compilers and tools
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER  arm-none-eabi-gcc)
set(CMAKE_AR arm-none-eabi-ar)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# project settings
project(<PROJECT_NAME> C CXX ASM) # Write your project name here
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

#Uncomment for hardware floating point
#add_compile_definitions(ARM_MATH_CM4;ARM_MATH_MATRIX_CHECK;ARM_MATH_ROUNDING)
add_compile_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)
add_link_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)
# set FPU(Floating Point Unit) type to VFPv4
# with support for single-precision and double-precision floating-point operations
# along with 16 VFP registers.
# you can set -mfpu=fpu-dp instead,I have not tried yet.

#Uncomment for software floating point
#add_compile_options(-mfloat-abi=soft)

add_compile_options(-mcpu=cortex-m7 -mthumb -mthumb-interwork)
add_compile_options(-ffunction-sections -fdata-sections -fno-common -fmessage-length=0)

# uncomment to mitigate c++17 absolute addresses warnings
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-register")

# Enable assembler files preprocessing
add_compile_options($<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>)
# if the current compiled language is assembly,add compile options -x assembler-with-cpp

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    message(STATUS "Maximum optimization for speed")
    add_compile_options(-Ofast)
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    message(STATUS "Maximum optimization for speed, debug info included")
    add_compile_options(-Ofast -g)
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "MinSizeRel")
    message(STATUS "Maximum optimization for size")
    add_compile_options(-Os)
else ()
    message(STATUS "Minimal optimization, debug info included")
    add_compile_options(-Og -g)
endif ()

include_directories(
  Core/Inc
  Drivers/STM32F7xx_HAL_Driver/Inc
  Drivers/STM32F7xx_HAL_Driver/Inc/Legacy
  Drivers/CMSIS/Include
  Drivers/CMSIS/Device/ST/STM32F7xx/Include
  Drivers/CMSIS/DSP/Include
  BSP/Inc
)

add_definitions(-DARM_MATH_CM7 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F767xx)

link_directories(Drivers/CMSIS/Lib/GCC)
# the following link libraries depend on you
# link_libraries(arm_cortexM7lfdp_math)

file(GLOB_RECURSE SOURCES "Core/*.*" "Drivers/*.*" "BSP/*.*")
# file(GLOB ...) is a command to add all source files in project

# set link memory map
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32F767IGTX_FLASH.ld)

add_link_options(-Wl,-gc-sections,--print-memory-usage,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map)
add_link_options(-mcpu=cortex-m7 -mthumb -mthumb-interwork -u _printf_float)
add_link_options(-T ${LINKER_SCRIPT})

add_executable(${PROJECT_NAME}.elf ${SOURCES} ${LINKER_SCRIPT})

set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} Building ${BIN_FILE}")

```


### Test {#test}


#### ToolChain {#toolchain}

1.  依次选择 Settings → Build,Execution,Deployment → ToolChains
2.  依次设置各个工具(如不在 PATH 中则需要配置路径)


#### Download &amp; Run {#download-and-run}

1.  在配置部分新增 "OpenOCD Download and Run" 配置
2.  GDB Port 处默认是 3333
3.  Board Config file 部分增加对应的 "stlink.cfg"


#### Debug {#debug}

1.  在配置部分新增 "Embedded GDB Server" 配置
2.  Debugger 处写 `arm-none-eabi-gdb` 的可执行路径
3.  Target Remote 处写 OpenOCD 对应 GDB 的端口，默认是 `localhost:3333`
4.  GDB Server 处写 `OpenOCD` 的可执行路径
5.  GDB Server args 处写 stlink.cfg 的内容，用 `-f` 参数分隔，如 `-f interface/stlink.cfg -f target/stm32f7x.cfg`
6.  在代码中加入断点，开始调试， **并按下开发板的复位按钮**

如果遇到端口被占用(如之前 openocd 启动了但没有正确退出等情况)，可用命令查看占用详情，并对对应的程序作终止处理。

```shell
netstat -ltnp | grep 6666 # openocd 默认会占用6666端口
ss -ltnp | grep 6666 # Arch Linux已弃用net-tools，改用iproute2
kill -9 <pid>
```


#### SVD {#svd}

1.  在意法半导体官网下载对应芯片的 SVD 文件
2.  在 Clion 调试中加载 SVD 文件
3.  调试时可以显示对应外设的状态和相关的值
