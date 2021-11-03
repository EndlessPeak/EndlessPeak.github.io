---
title: 栈基本操作
toc: true
authors:
  - EndlessPeak
date: 2021-11-03
hidden: false
draft: false
weight: 5
---

栈的基本操作如下：

```c++
bool InitStack(LinkStack &L);
bool IsEmpty(LinkStack L);
bool Push(LinkStack &L, ElemType x);
bool Pop(LinkStack &L, ElemType &x);
bool GetTop(LinkStack L, ElemType &x);
bool DestroyStstack(LinkStack &L);
```

## 顺序栈

栈的顺序存储类型：

```c++
#define MaxSize 50
typedef struct{
    ElemType data[MaxSize];
    int top;
}SqStack;
```

初始化：

```c++
bool InitStack(SqStack S){
	S.top=-1;
	return true;
}
```

判断栈空：

```c++
bool IsEmpty(SqStack S){
	if(S.top==-1)
		return true;
	else
		return false;
}
```

元素进栈：

```c++
bool Push(SqStack &S,ElemType x){
    if(S.top==MaxSize-1)
        return false;
    S.data[++S.top]=x;
    return true;
}
```

元素出栈：

```c++
bool Pop(SqStack &S,ElemType &x){
    if(S.top==-1)
        return false;
    x=S.data[S.top--];
    return true;
}
```

读栈顶元素：

```c++
bool GetTop(SqStack S,ElemType &x){
    if(S.top==-1)
        return false;
    x=S.data[top];
    return true;
}
```

## 链式栈

栈的链式存储结构为：

```c++
typedef struct LinkNode{
    ElemType data;
    struct LinkNode *next;
} LinkNode, *LinkStack;
```

注意，栈推荐不带头结点。

初始化：

```c++
bool InitStack(LinkStack &L){
    L = NULL;
    return true;
}
```

判断栈空：

```c++
bool IsEmpty(LinkStack L){
    return L == NULL;
}
```

元素进栈：

```c++
bool Push(LinkStack &L, ElemType x){
    LinkNode *s = (LinkNode *)malloc(sizeof(LinkNode));
    if (s == NULL)
        return false;
    s->next = L;
    s->data = x;
    L = s; //注意体会写法
    // 上两行代码对栈是否为空效果相同
    return true;
}
```

元素出栈：

```c++
bool Pop(LinkStack &L, ElemType &x){
    if (L == NULL)
        return false; //无结点可出
    LinkNode *s = L;
    x = s->data; //栈顶元素出栈
    L = L->next;
    free(s);
    return true;
}
```

读栈顶元素：

```c++
bool GetTop(LinkStack L, ElemType &x){
    if (L == NULL)
        return false;
    else
    {
        x = L->data;
        return true;
    }
}
```

销毁栈：

```c++
bool DestroyStstack(LinkStack &L)
{
    if (L == NULL)
        return true;
    LinkNode *p = L->next, *q = L;
    while (p != NULL)
    {
        free(q);
        q = p;
        p = p->next;
    }
    free(q); //此时q指向尾结点
    return true;
}
```

