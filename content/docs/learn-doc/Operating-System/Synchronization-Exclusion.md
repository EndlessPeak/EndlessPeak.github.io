---
title: 经典同步问题
toc: true
authors:
  - EndlessPeak
date: 2021-11-03
hidden: false
draft: false
weight: 4
---

## 生产者与消费者问题

一组生产者和一组消费者交替使用缓冲区。

设缓冲区是临界资源，它只允许一个生产者放入内容或一个消费者取出内容。

代码描述如下：

```c++
semaphore mutex=1;
semaphore empty=n;
semaphore full=0;
producer(){
    while(1){
        produce items;
        P(empty);
        P(mutex);
        add items to buffer;
        V(mutex);
        V(full);
    }
}
consumer(){
    while(1){
        P(full);
        P(mutex);
        remove items from buffer;
        V(mutex);
        V(empty);
        consume the items;
    }
}
```

考虑下面较为复杂的生产消费问题：

设桌上有一个盘子，每次只能放入一个水果，爸爸专放苹果，妈妈专放橘子，女儿专吃苹果，儿子专吃橘子。

仅当盘子为空时爸爸或妈妈才可放入，仅当盘子为满时女儿或儿子才能吃。

代码描述如下：

```c++
semaphore orange=0;
semaphore apple=0;
semaphore plate=1;
dad(){
    while(1){
        P(plate);
        produce apple;
        V(apple);
    }
}
mom(){
    while(1){
        P(plate);
        produce orange;
        V(orange);
    }
}
daughter(){
    while(1){
        P(apple);
        eat apple;
        V(plate);
    }
}
son(){
    while(1){
        P(orange);
        eat orange;
        V(plate);
    }
}
```

注：为什么可以不设置`mutex`？因为缓冲区大小为1，任意时刻`apple`，`orange`，`plate`三个同步信号量中最多只有一个是1，因此任何时刻最多只有一个进程进行P操作，而不会被阻塞。若缓冲区大小为2，则需要设置`mutex`, 且必须在同步信号量的P操作之后，以防死锁。

## 读者与写者问题

读写公平算法：

当读进程访问时，写进程到达，则禁止后续到达的读进程的请求；

当写进程访问时，读进程和写进程先后到达，则按到达的先后次序进行访问。

## 哲学家进餐问题

暂未更新。

## 吸烟者问题

暂未更新。