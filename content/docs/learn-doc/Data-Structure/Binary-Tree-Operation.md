---
title: 二叉树的基本操作
toc: true
authors:
  - EndlessPeak
date: 2021-11-02
hidden: false
draft: false
weight: 8
---

## 二叉树存储结构

二叉树链式存储数据结构如下：

```c++
typedef struct BitNode {
    int data;
    BitNode *left;
    BitNode *right;
}BitNode,*BiTree;
```

## 二叉树遍历

设根结点为N，左结点L，右结点R。常见遍历有先序、中序、后序、层序遍历。

### 递归算法

先序遍历

```c++
void PreOrder(BiTree T)
{
    if (T != NULL)
    {
        visit(T);
        PreOrder(T->lchild);
        PreOrder(T->rchild);
    }
}
```

中序遍历

```c++
void InOrder(BiTree T)
{
    if (T != NULL)
    {

        InOrder(T->lchild);
        visit(T);
        InOrder(T->rchild);
    }
}
```

后序遍历

```c++
void PostOrder(BiTree T)
{
    if (T != NULL)
    {

        PostOrder(T->lchild);
        PostOrder(T->rchild);
        visit(T);
    }
}
```

### 栈迭代算法

思想：使用栈模拟递归中的调用过程。

先序遍历

```c++
void PreOrder2(BiTree T)
{
    LinkStack S;
    InitStack(S);
    BiTree p = T; //p是工作指针
    while (p || !IsEmpty(S))
    {
        if (p) //先访问根结点，然后一路向左
        {
            visit(p);
            Push(S, p);
            p = p->lchild;
        }
        else //出栈，后转向右子结点（出栈条件是当前结点为空）
        {
            Pop(S, p);
            p = p->rchild;
        }
    }
}
```

中序遍历

```c++
void InOrder2(BiTree T)
{
    LinkStack S;
    InitStack(S);
    BiTree p = T; //p是工作指针
    while (p || !IsEmpty(S))
    {
        if (p) //一路向左
        {
            Push(S, p);
            p = p->lchild;
        }
        else //出栈，访问根结点，后转向右子结点（出栈条件是当前结点为空）
        {
            Pop(S, p);
            visit(p);
            p = p->rchild;
        }
    }
}
```

※ 后序遍历

思想：

①先沿着根找所有的左孩子，依次入栈，直到左孩子为；

②读栈顶元素，若该元素的右孩子不空且未被访问过，则将其右子树转①；否则栈顶元素出栈并对其进行访问。

关键在于分清返回到当前结点时是通过左子树返回的还是右子树返回的。代码实现中设辅助指针r指向最近访问过的结点。

```c++
void PostOrder2(BiTree T)
{
    LinkStack S;
    InitStack(S);
    BiTree p = T, r = NULL; //p是工作指针,r指向上一个访问的结点
    //工作指针有结点，则说明需要向左走，工作指针指向空，说明需要向右
    while (p || !IsEmpty(S))
    {
        if (p) //一路向左
        {
            Push(S, p);
            p = p->lchild;
        }
        else //向右，元素出栈
        {
            GetTop(S, p);                    //读栈顶元素赋给p（并非出栈）
            if (p->rchild && p->rchild != r) //右子树且尚未被访问
            {
                p = p->rchild;
                Push(S, p);
                p = p->lchild; //继续向左走
            }
            else
            {
                Pop(S, p);//弹出结点
                visit(p);
                r = p;
                p = NULL; //重置p指针
            }
        }
    }
}
```

层序遍历

思想：使用队列实现

```c++
void LevelOrder(BiTree T)
{
    LinkQueue Q;
    InitQueue(Q);
    BiTree p;
    EnQueue(Q, T);
    while (!IsEmpty(Q))
    {
        DeQueue(Q, p);
        visit(p);
        if (p->lchild != NULL)
            EnQueue(Q, p->lchild);
        if (p->rchild != NULL)
            EnQueue(Q, p->rchild);
    }
}
```

## 计算树深度

```c++
int treeDepth(BiTree T)
{
    if (T == NULL)
        return 0;
    else
    {
        int l = treeDepth(T->lchild);
        int r = treeDepth(T->rchild);
        return l > r ? l + 1 : r + 1;
    }
}
```

