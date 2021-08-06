---
title: 线性表
toc: true
authors:
  - EndlessPeak
date: 2021-08-06
hidden: false
draft: false
weight: 2
---

线性表的基本操作如下：

```c++
void InitList(&L);//初始化表，构造一个空的线性表
int Length(L);//求表长
ElemType LocateElem(L,e);//按值查找
ElemType GetElem(L,e);//按位查找
bool ListInsert(&L,i,e);//插入操作
bool ListDelete(&L,i,&e);//删除操作
void PrintList(L);//输出操作
bool Empty(L);//判空操作
bool DestroyList(&L);//销毁操作
```

## 顺序表

### 定义

#### 静态分配

```c++
static const int MaxSize=50;
typedef int ElemType;
typedef struct{
    ElemType data[MaxSize];//定义即开辟了存储空间
    int length;
}SqList;
```

#### 动态分配

```c++
static const int MaxSize=50;
typedef int ElemType;
typedef struct{
    ElemType *data;
    int MaxSize,length;//此处需要声明最大存储空间
}SqList;
```

### 初始化

#### 静态分配

```c++
void InitList(SqList &L){
    for(int i=0;i<MaxSize;i++)
        L.data[i]=0;
    L.length=0;
}
```

#### 动态分配

```c++
void InitList(SqList &L){
    //以下两种初始化内存空间方式分别对应C与C++
    L.data=(ElemType*)malloc(sizeof(ElemType)*MaxSize);
    L.data=new ElemType[InitSize];
    for(int i=0;i<MaxSize;i++)
        L.data[i]=0;
    L.length=0;
}
```

### 插入

其中`i`是位序。

```c++
bool ListInsert(SqList &L,int i,ElemType e){
	if(i<1||i>L.length+1)	
        return false;
    if(L.length==MaxSize){//可以直接返回错误，理由是存储空间已满；或分配内存空间
        MaxSize++;
        ElemType *new;
        new=(ElemType*)realloc(L.data,sizeof(ElemType)*(MaxSize+1));
        L.data=new;
    	if(!L.data)  return false;
    }
    if(L.length>=MaxSize)	return false;
    for(int j=L.length;j>=i;j--)
        L.data[j]=L.data[j-1];//从最后开始，一直到i-1位，将所有元素依次往移动一位
    L.data[i-1]=e;
    L.length++;
    return true;
}
```

### 删除

```c++
bool ListDelete(SqList &L,int i,ElemType e){
    if(i<1||i>L.length+1)
        return false;
    e=L.data[i-1];
    for(int j=i;j<L.length;j++)
        L.data[j-1]=L.data[j];
    L.length--;
    return true;
}
```

### 查找

#### 按值查找

```C++
ElemType LocateElem(SqList L,ElemType e){
    int i;
    for(i=0;i<L.length;i++)
        if(L.data[i]==e)
            return i+1;
    return 0;
}
```

#### 按位查找

```C++
ElemType LocateElem(SqList L,int i){
    if(i<1||i>L.length)
        return NULL;
    return L.data[i-1];
}
```

## 链表

如无特殊说明，均指带头结点的单链表。

### 定义

```C++
typedef struct LNode{
    ElemType data;
    struct LNode *next;
}LNode,*LinkList;
```

### 初始化

#### 不带头结点

```c++
bool InitList(LinkList &L){
    L=NULL;//防止内存中的脏数据进入单链表
    return true;
}
```

#### 带头结点

```c++
bool InitList(LinkList &L){
    L=（LNode*)malloc(sizeof(LNode));
    if(L==NULL)	return false;
    L->next=NULL;
    return true;
}
```

### 判空

```C++
bool Empty(LinkList L){
    return (L==NULL);//不带头结点
    return (L->next==NULL);//带头结点
}
```

### 查找

#### 按位查找

带头结点的按位查找如下

```c++
LNode *GetElem(LinkList L,int i){
    int j=0;//从0开始查找
    LNode *p=L;
    /*或改写成
    int j=1;
    LNode *p=L->next;
    */
    if(i==0)	return L;
    if(i<1)	return NULL;
    while(p&&j<i){
        p=p->next;
        j++;
    }
    return p;//返回第i个结点的指针，若大于表长，返回的则是NULL
}
```

#### 按值查找

```c++
LNode *LocateElem(LinkList L,ElemType e){
    LNode *p=L->next;
    while(p!=NULL&&p->data!=e)
        p=p->next;
    return p;//要么返回指针，要么返回NULL
}
```

### 插入

对于给定的结点，向其前后插入。

#### 向后插入

```c++
bool ListInsertNextNode(LNode *p,ElemType e){
    if(p==NULL)	return false;
    LNode *s=(LNode*)malloc(sizeof(LNode));
    if(s==NULL)	return false;
    s->data=e;
    s->next=p->next;
    p->next=s;//注意上述三语句的顺序，此句和前句顺序不能颠倒
    return true;
}
```

#### 向前插入

方法有两种，一是传入头指针，找到第`i-1`个结点；二是转换为后插操作。

如果给定的是待插入的值，则

```C++
bool ListInsertPriorNode(LNode *p,ElemType e){
    if(p==NULL)	return false;
    LNode *s=(LNode*)malloc(sizeof(LNode));
    if(s==NULL)	return false;
    s->next=p->next;
    p->next=s;
    s->data=p->data;
    p->data=e;
    return true;
}
```

如果给定的是待插入的结点，则

```C++
bool ListInsertPriorNode(LNode *p,LNode *s){
    if(p==NULL)	return false;
    LNode *s=(LNode*)malloc(sizeof(LNode));
    if(s==NULL)	return false;
    s->next=p->next;
    p->next=s;
    ElemType temp;
    temp=p->data;
    p->data=s->data;
    s->data=temp;
    return true;
}
```

对于给定的位序，向其前后插入如下。

#### 向后按位序插入

带头结点

```C++
bool ListInsertNext(LinkList &L,int i,ElemType e){
    p=GetElem(L,i);
    return ListInsertNextNode(p,e);
}
```

不带头结点

```C++
bool ListInsertNext(LinkList &L,int i,ElemType e){
    p=GetElem(L,i);
    if(i!=1)	return ListInsertNextNode(p,e);
    if(i==1){
        LNode *s=(LNode*)malloc(sizeof(LNode));
        s->data=e;
        s->next=L;
        L=s;//注意体会此处的书写
        return true;
    }
}
```


#### 向前按位序插入

```C++
bool ListInsertPrior(LinkList &L,int i,ElemType e){
    p=GetElem(L,i);
    return ListInsertPriorNode(p,e);
}
```

### 建表

#### 尾插法

```c++
LinkList List_TailInsert(LinkList &L){
    int x;
    L=(LinkList)malloc(sizeof(LNode));
    LNode *s,*r=L;//r是表尾指针
    scanf("%d",&x);
    while(x!=9999){//输入9999表示结束
        s=(LNode*)malloc(sizeof(LNode));
        s->data=x;
        r->next=s;
        r=s;
        scanf("%d",&x);
    }
    r->next=NULL;
    return L;
}
```

#### 头插法

带头结点

```C++
LinkList List_HeadInsert(LinkList &L){
    int x;
    L=(LinkList)malloc(sizeof(LNode));
    LNode *s;
    L->next=NULL;//不带头结点则 L=NULL;
    scanf("%d",&x);
    while(x!=9999){//输入9999表示结束
        s=(LNode*)malloc(sizeof(LNode));
        s->data=x;
        s->next=L->next;//不带头结点则 s->next=L;
        L->next=s;//不带头结点则 L=s;
        scanf("%d",&x);
    }
    return L;
}
```

### 删除

#### 按位序删除

```c++
bool ListDelete(LinkList &L,int i,ElemType &e){
    LNode *p=GetElem(L,i-1);//寻找被删除结点的前驱结点
    LNode *q=p->next;//q指向被删除的结点
    p->next=q->next;
    free(q);
}
```

#### 按结点删除

```c++
bool ListDeleteNode(LNode *p){
    if(p==NULL)	return false;
    LNode *q=p->next;
    p->data=p->next->data;//被删除结点和后继结点交换数据域
    p->next=q->next;//断链
    free(q);
    return true;
}
```

### 求表长

```c++
int Length(LinkList L){
    int len=0;
    LNode *p=L;
    /*不带头结点
    if(L==NULL)	return len;
    */
    while(p->next!=NULL){
        p=p->next;
        len++;
    }
    return len;
}
```

