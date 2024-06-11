---
title: Thread
date: 2024-06-11
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 1
description: 本文记录C++STL编程的相关知识。
---

# Basic Thread
## C Thread Impl
C中实现多线程编程需要使用如下的函数原型：
```cpp
int pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine) (void *), void *arg);
```

其中：
1. `*pthread_t thread` 用于存储创建的线程标识符；
2. `*const pthread_attr_t attr` 用于设置线程属性；
3. `void *(*start_routine)(void *)` 是指向函数的指针，该函数将在线程创建后执行，其必须接受并返回一个 `void *` 类型的指针。
4. `*void arg` 是传递给 `start_routine` 函数的参数。

以下是C进行多线程编程的示例：
```cpp
#include <pthread.h>
#include <stdio.h>

// 线程函数必须符合 void * (*start_routine) (void *) 的签名
void* print_message_function(void* ptr) {
    char* message = (char*) ptr;
    printf("%s \n", message);
    return NULL;
}

int main() {
    // 定义线程标识符
    pthread_t thread1, thread2;
    const char* message1 = "Thread 1";
    const char* message2 = "Thread 2";

    // 创建线程
    pthread_create(&thread1, NULL, print_message_function, (void*) message1);
    pthread_create(&thread2, NULL, print_message_function, (void*) message2);

    // 等待线程结束
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    return 0;
}
```

## CPP Thread Impl
以下是C++进行多线程编程的示例：
```cpp
  #include <iostream>
  #include <thread>

  void print_message_function(const std::string& message) {
      std::cout << message << std::endl;
  }

  int main() {
      std::string message1 = "Thread 1";
      std::string message2 = "Thread 2";

      // 创建线程
      std::thread thread1(print_message_function, message1);
      std::thread thread2(print_message_function, message2);

      // 等待线程结束
      thread1.join();
      thread2.join();

      return 0;
  }
```


## C Plus Plus
1. Eigen 是行优先还是列优先 
2. 说一下 Mat 是如何析构的
3. 说一下智能指针，shared_ptr 与 unique_ptr
4. 说一下什么是虚函数
5. 普通指针如何实现一块内存只能有一个指针指向这种功能
6. C++ RTTI 是什么东西？
7. C++是如何实现多态的？
8. vector 的 iterator 什么时候失效？
9.  写 CmakeLists.txt，写 gcc 指令
