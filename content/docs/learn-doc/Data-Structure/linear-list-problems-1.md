---
title: 线性表算法题
toc: true
authors:
  - EndlessPeak
date: 2021-08-07
hidden: false
draft: false
weight: 3
---

本节尝试对具有代表性的线性表编程题及经典算法进行实现。

## 题1

递归算法实现删除不带头结点的单链表L中所有值为x的结点

```c++
void RecurseDel(LinkList &L,ElemType x){
    if(L==NULL)	return;
    if(L->data!=x)
        RecurseDel(L->next,x);
    LNode *p;
    p=L;
    L=L->next;
    free(p);
    RecurseDel(L,x);
}
```

本算法的难点在于有观点认为该实现过程会造成线性表断链，分析如下。

每次调用算法均只会对当前链的首结点进行删除或不删除操作；而断链仅在前一个结点未被删除，中间结点被删除，后一个结点未被删除时可能发生；因此仅在上一层函数不删除当前链首结点并递归调用，本层函数删除当前链首结点的时候可能出现断链。注意到函数参数表使用的是**引用调用**，设上层线性表为`L(up)`，它进入函数后调用`RecurseDel(L->next,x)`，因此对本层来说，本层的单链表`L(current)=&(L(up)->next)`，而后本层函数赋值`L(current)=L(current)->next`，即最终有下式成立：`&(L(up)->next)=L(current)->next`，即上层的next指针最终指向了本层被删除结点的下一个结点。因此不会断链。

> 当调用函数时，有三种向函数传递参数的方式，分别是传值调用，指针调用和引用调用。其中后两种调用时修改形式参数会影响实际参数。

## 题3

对带头结点L的单链表，从尾到头反向输出结点的值

思想1：采用递归，每次返回后一个结点的反向输出值，再返回当前结点的值。

```c++
void RecursePrint(LinkList L){
    if(L->next!=NULL)
        RecursePrint(L->next);
    if(L!=NULL)
        printf("%d",L->data);
}
```

思想2：采用头插法对原单链表进行逆置

实现法1：生成新单链表，然后遍历输出新单链表。

```c++
void HeadInsertPrint(LinkList L){
    LinkList L1=(LinkList)malloc(sizeof(LNode));
    L1->next=NULL;
    LNode *p=L->next,*q;//p是工作指针，指向当前需要进行头插的结点；不断新生成q插入新链表
    while(p!=NULL){
        q=(LNode*)malloc(sizeof(LNode));
        q->data=p->data;
        q->next=L->next;
        L->next=q;
        p=p->next;
    }//头插法结束
    p=L1;//将逆置链表头结点赋给p
    while(p->next!=NULL){
        p=p->next;
        printf("%d",p->data);
    }
}
```

实现法2：就地逆置，遍历输出

```c++
void HeadInsertPrint(LinkList L){
    LNode *p,*q;
    p=L->next;
    L->next=NULL;
    while(p!=NULL){
        q=p->next;//暂存工作指针的后继，防止断链
        p->next=L->next;
        L->next=p;
        p=q;
    }//头插法结束
    p=L;//将逆置链表头结点赋给p
    while(p->next!=NULL){
        p=p->next;
        printf("%d",p->data);
    }
}
```

