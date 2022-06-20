---
title: 二叉树的算法
toc: true
authors:
  - EndlessPeak
date: 2022-02-10
hidden: false
draft: false
weight: 9
---

## 二叉树算法索引

1. 二叉树的建立

   设二叉树初始由数组存储，生成为二叉链表存储，编写递归建立算法和非递归建立算法

2. 二叉树的遍历

   编写先序、中序、后序遍历的递归和非递归算法，层序遍历算法

   求先序遍历序列中第n个结点的值

3. 二叉树的深宽

   计算二叉树指定结点的高度/深度

   计算二叉树的最大宽度

4. 二叉树的形态

   判断二叉树是否是完全二叉树

   判断二叉树是否是镜像对称的

   对二叉树镜像翻转，或将二叉树所有结点的左右子树相互交换

5. 二叉树的结点

   计算二叉树的叶子结点、非叶子结点个数

   查找特定值的结点，并打印其所有祖先结点的值

6. 二叉树的遍历与建立综合

   通过先序遍历序列和中序遍历序列建立二叉树

   通过中序遍历序列和后序遍历序列建立二叉树

   将满二叉树的先序遍历序列转为后序遍历序列

7. 二叉树与链表综合

   将二叉树中所有叶子结点链接为链表，并返回头指针

## 二叉树的建立

题目描述：设二叉树初始由数组存储，生成为二叉链表存储，编写递归建立算法和非递归建立算法。初始给定数组首地址指针和二叉树的深度。

二叉树链式存储数据结构如下：

```c++
typedef struct BitNode {
    int data;
    BitNode *left;
    BitNode *right;
}BitNode,*BiTree;
```

解答：

设虚结点在数组中用-1表示，递归建立算法如下：

```c++
int size=pow(2,depth)-1;
BiTree CreateBiTree(int *a,int index,int size){
	BiTNode *T=NULL;//初始化二叉树根结点
    if(size==0||a[index]==-1)
        return NULL;
    T=(BiTNode*)malloc(sizeof(BiTNode));
    T->data=a[index];
    T->lchild = CreateBiTree(a, 2 * index, size);
    T->rchild = CreateBiTree(a, 2 * index + 1, size);
    return T;
}
BiTree T = CreateBiTree(a, 1, size); //创建二叉树
```

非递归使用队列实现，类似层次遍历思想：

```c++
typedef struct TNode{
    BiTree bt;//二叉树结点指针
    int num;//指示当前结点在一维数组中的位序
}TNode;
TNode Q[MaxSize];//循环队列
BiTree CreateBiTree(int *a,int depth){
    int size=pow(2,depth)-1;
    BiTree p;//用于暂存出队的元素
    int i=0;//指示暂存的出队元素在数组中的位序
    TNode tn;//队列元素
    BiTree T=(BiTNode*)malloc(sizeof(BiTNode));//根结点
    T->data=a[1];
    tn.bt=T;
    tn.num=1;
    int front=rear=0;
    Q[rear++%MaxSize]=tn;
    while(front!=rear){
        tn=Q[front++%MaxSize];//出队
        p=tn.bt;
        i=tn.num;
        if(2*i>size||a[2*i]==-1)
            p->lchild=NULL;
        else{
            //左结点
            p->lchild=(BiTNode*)malloc(sizeof(BiTNode));
            p->lchild->data=a[2*i];
            //左结点入队
            tn.bt=p->lchild;
            tn.num=2*i;
            Q[rear++%MaxSize]=tn;
        }
        if(2*i+1>size||a[2*i+1]==-1)
            p->rchild=NULL;
        else{
            //右结点
            p->rchild=(BiTNode*)malloc(sizeof(BiTNode));
            p->rchild->data=a[2*i+1];
            //右结点入队
            tn.bt=p->rchild;
            tn.num=2*i+1;
            Q[rear++%MaxSize]=tn;
        }
    }
}
```

## 二叉树的遍历

先序、中序和后序遍历的非递归算法均使用栈实现。

### 先序遍历

递归算法

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

非递归算法

```c++
const int MaxSize=1000;
void PreOrder2(BiTree T)
{
    int top=-1;//top指向栈顶元素
    BiTNode* stack[MaxSize];
    BiTree p = T; //p是工作指针
    while (p || top!=-1)
    {
        if (p) //先访问根结点，然后一路向左
        {
            visit(p);
            stack[++top]=p;
            p = p->lchild;
        }
        else //出栈，后转向右子结点（出栈条件是当前结点为空）
        {
            p=stack[top--];
            p = p->rchild;
        }
    }
}
```

### 中序遍历

递归算法

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

非递归算法

```c++
const int MaxSize=1000;
void InOrder2(BiTree T)
{
    int top=-1;//top指向栈顶元素
    BiTNode* stack[MaxSize];
    BiTree p = T; //p是工作指针
    while (p || top!=-1)
    {
        if (p) //一路向左
        {
            stack[++top]=p;
            p = p->lchild;
        }
        else //出栈，访问根结点，后转向右子结点（出栈条件是当前结点为空）
        {
            p=stack[top--];
            visit(p);
            p = p->rchild;
        }
    }
}
```

### 后序遍历

递归算法

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

**※ 非递归算法：**

①先沿着根找所有的左孩子，依次入栈，直到左孩子为空；

②读栈顶元素，若该元素的右孩子不空且未被访问过，则将其右子树转①；否则栈顶元素出栈并对其进行访问。

上述第②步中，关键在于必须分清返回到当前结点时是通过左子树返回的还是右子树返回的。若是左子树，则当前结点需要一路向左，若是右子树，则访问当前结点。

为达到上述目的，代码实现中设辅助指针r指向最近访问过的结点。

```c++
const int MaxSize=1000;
void PostOrder2(BiTree T)
{
    int top=-1;//top指向栈顶元素
    BiTNode* stack[MaxSize];
    BiTree p = T, r = NULL; //p是工作指针,r指向上一个访问的结点
    //工作指针有结点，则说明需要向左走，工作指针指向空，说明需要向右
    while (p || top!=-1)
    {
        if (p) //一路向左
        {
            stack[++top]=p;
            p = p->lchild;
        }
        else //向右，元素出栈
        {
            p=stack[top];//读栈顶元素赋给p（并非出栈）
            if (p->rchild&&p->rchild!=r) //右子树且尚未被访问
            {
                p = p->rchild;
                stack[++top]=p;
                p = p->lchild; //继续向左走
            }
            else
            {
                p=stack[top--];//弹出结点
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
const int MaxSize=1000;
void LevelOrder(BiTree T)
{
    BiTree Queue[MaxSize];
    BiTree p;
    int rear=front=0;
    Queue[rear++%MaxSize]=T;
    while (front!=rear)
    {
        p=Queue[front++%MaxSize];
        visit(p);
        if (p->lchild != NULL)
            Queue[rear++%MaxSize]=p->lchild;
        if (p->rchild != NULL)
            Queue[rear++%MaxSize]=p->rchild;
    }
}
```

### 求先序遍历序列中第n个结点的值

假设二叉树共有$n$个结点，采用二叉链表存储结构，试设计算法求先序遍历序列中第$k(1\leq k \leq n)$的叶子结点的值。

```c++
ElemType PreOrder(BiTree T,int k,int &num){
	ElemType value=NULL;
    if(T==NULL)
        return value;
	if(num==k)
		return T->data;
	num+=1;
	//当num<k时
	if(T->lchild!=NULL){
		value=PreOrder(T->lchild,k,num);
		if(value!=NULL)
			return value;
    }
    if(T->rchild!=NULL){
        value=PreOrder(T->rchild,k,num);
        return value;
    }   
}
ElemType PreNode(BiTree T,int k){
    return PreOrder(T,k,0);
}
```

## 二叉树的深宽

题目描述：设二叉树初始由二叉链表存储，编写计算二叉树的深度和最大宽度的算法。初始给定二叉树根结点。

### 二叉树的深度

递归算法

注：无论是给二叉树的根还是给指定结点，计算深度均可采用下面的算法。

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

### 二叉树的宽度

算法思想：

采用层次遍历的方法，通过记录各层结点数最后得到最大结点数。

遍历中需要区分不同层，区分方法有很多种，一是用整数保存当前层元素的个数控制出队和入队；二是保存当前层最右侧结点。

法一，用整数保存当前层元素的个数控制出队和入队。

```c++
const int MaxSize=1000;
BiTree Q[MaxSize];//定义队列
int rear=front=0;
int BiTreeWidth(BiTree T){
    if(T==NULL)
        return 0;
    currentWidth=0;//本层结点个数
    Q[rear++%MaxSize]=T;//根结点入队
    lastWidth=1;//上一层（即当前队列中的元素个数）
    maxWidth=1;//根结点已入队，因此最大宽度从1开始计算
    while(rear!=front){
        while(lastWidth!=0){//当前队列中元素个数不为0，则持续出队
            BiTree p=Q[front++%MaxSize];
            if(p->lchild){
                Q[rear++%MaxSize]=p->lchild;
            	currentWidth+=1;
            }
            if(p->rchild){
                Q[rear++%MaxSize]=p->rchild;
                currentWidth+=1;
            }
            if(currentWidth>maxWidth)
                maxWidth=currentWidth;
            lastWidth-=1;
        }
        lastWidth=currentWidth;
        currentWidth=0;//清零当前层计数器，转下一层
    }
    return maxWidth;
}
```

法二，用整数保存当前层最右侧结点。

```c++
const int MaxSize=1000;
BiTree Q[MaxSize];//定义队列
int BiTreeWidth(BiTree T){
	if(T==NULL)
	   return 0;
    int font=0,rear=0;
    int last=0;//last指向当前层的最右结点
    int maxWidth=0,currentWidth=0;
    //maxWidth保存最大宽度，currentWidth保存本层宽度
    Q[rear++%MaxSize]=T；//根结点入队
    BiTree p;
    while(front%MaxSize<last%MaxSize){//在当前层循环
    	p=Q[front++%MaxSize];  
        currentWidth++;  
    	if(p->lchild)
    	   Q[rear++%MaxSize]=p->lchild;
 	    if(p->rchild)
 	       Q[rear++%MaxSize]=p->rchild;
        if(front>=last){//由于last=rear,rear指向下一个结点，因此这里相等也成立
		   if(maxWidth<currentWidth)
		      maxWidth=currentWidth;
		   last=rear;//将下一层的最后一个结点赋给last
		   currentWidth=0;//每一层宽度置空一次
		}
	}
	return maxWidth;
}
```

## 二叉树的形态

### 完全二叉树

使用队列进行层序遍历，如果某结点无左孩子，也必须无右孩子。

特别注意两点：

1. 不能通过证明左右子树是完全二叉树，则该树是完全二叉树，证法是错误的；
2. 不能在入队时只考虑左右孩子均有、有左无右、有右无左、都无这四种情况，因为可能存在左子树和右子树都只有左孩子无右孩子。

因此需要加设一个变量flag，指示当前结点的左兄弟的子树是否是满二叉树。

```c++
const int MaxSize=1000;
BiTree Queue[MaxSize];
bool judgeComplete(BiTree T){
    if(!T)
        return true;
    int flag=1;//判断当前层的左兄弟的子树是满二叉树(1)或无子树/仅有左子树(0)
    int front=rear=0;
    Queue[rear++%MaxSize]=T;
    while(front!=rear){
        BiTree p=Q[front++%MaxSize];
        if(p->lchild&&flag){
            Queue[rear++%MaxSize]=p->lchild;
        }
        else if(p->lchild)//有左孩子，但左兄弟不是满二叉树
            return false;
        else
            flag=0;
        if(p->rchild&&flag){
            Queue[rear++%MaxSize]=p->rchild;
        }
        else if(p->rchild)
            return false;
        else
            flag=0;
    }
    return true;
}
```

### 镜像对称

递归算法

两个结点是镜像对称的需要满足以下两个条件：

1. 结点上的值相等
2. 结点a的左孩子的值等于结点b的右孩子的值，结点a的右孩子的值等于结点b的左孩子的值。

```c++
bool isMirror(BiTree T1,BiTree T2) {
    if(T1==NULL&&T2==NULL)
        return true;
    else if(T1==NULL&&T2!=NULL)
        return false;
    else if(T1!=NULL&&T2==NULL)
        return false;
    else
        return (T1->val==T2->val) && isMirror(T1->left,T2->right) && isMirror(T1->right,T2->left);
}
bool isMirrorTree(BiTree T){
    if(T==NULL)	return true;
    else return isMirror(T1,T2);
}
```

非递归算法

直接由递归算法修改而来，并不尽如人意。

```c++
const int MaxSize=1000;
BiTree stack1[MaxSize];
BiTree stack2[MaxSize];//定义两个栈
Bool isMirror(BiTree T1,BiTree T2) {
    int top=-1;
    BiTree p1,p2;
    stack1[++top]=T1;
    stack2[++top]=T2;//同时入栈
    while(top!=-1){
        p1=stack[top--];
        p2=stack[top--];
        //值判断
        if(p1->data!=p2->data)
            return false;
        //结构判断
        else if(!(p1->lchild&&p2->rchild))
            return false;
        else if(!(p1->rchild&&p2->lchild))
            return false;
        else{
            if(p1->lchild)
                stack1[++top]=p1->lchild;
        	if(p1->rchild)
                stack1[++top]=p1->rchild;
            if(p2->lchild)
                stack2[++top]=p2->lchild;
            if(p2->rchild)
                stack2[++top]=p2->rchild;
        }
    }
    return true;
}
```

### 镜像翻转

递归算法思想：

递归地对每层，使用三变量交换法交换左右子树。

```c++
BiTree invertTree(BiTree T) {
    if(T == null)
        return T;
    BiTree temp = T->left;
    T->left = T->right;
    T->right = temp;
    invertTree(T->left);
    invertTree(T->right);
}
```

或者不使用三变量交换法，先递归得到左右子树，然后直接交叉赋值。

```C++
BiTree invertTree(BiTree T){
    if (!T)
        return NULL;
    BiTree left = invertTree(T->lchild);
    BiTree right = invertTree(T->rchild);
    T->lchild = right;
    T->rchild = left;
    return T;
}
```

迭代算法思想：

采用层次遍历，依次遍历结点并入队，出队时交换结点的左右孩子，并将左右孩子分别入队，循环直到队列为空。

```c++
const int MaxSize=1000;
BiTree Q[MaxSize];//定义队列
BiTree Mirror(BiTree T) {
    int rear=front=0;
    BiTree temp,current;
    if(T==NULL)
        return T;
    Q[rear++%MaxSize]=T;
    while(front!=rear) {
        current=Q[front++%MaxSize];
        temp=current->left;
        current->left=current->right;
        current->right=temp;
        if(current->left!=NULL)
            Q[rear++%MaxSize]=current->left;
        if(current->right!=NULL)
            Q[rear++%MaxSize]=current->right;
    }
    return T;
}
```

### 二叉树的子结构

给定两棵二叉树，要求判断树B是否是树A的子结构。

```C++
//依次查找树T1的根、左子树、右子树
bool HasSubtree(BiTree T1,BiTree T2){
    if(T1 == NULL || T2 == NULL) 
        return false;
    else
        return (isSubtree(T1,T2))||HasSubtree(T1->left, T2)||HasSubtree(T1->right, T2);
}
//判断树T2（根结点）是否是树T1（根结点）的子结构
bool isSubtree(BiTree T1,BiTree T2){
    if(T2 == NULL)  return true;
    if(T1 == NULL)  return false;//r2非空，r1为空
    if(T1->data!=T2->data)
        return false;
    return isSubtree(T1->left, T2->left) && isSubtree(T1->right, T2->right);
}
```



## 二叉树的结点

### 计算二叉树叶子结点数与非叶子结点数

本节分别叙述二叉树以数组、二叉链表的存储方式存储时计算叶子结点和非叶子结点。

数组形式，给定数组和二叉树深度：

```c++
int leafCount=nodeCount=0;
void leaves(int *a,int depth,int &leafCount,int &nodeCount){
    int size=pow(2,depth)-1;
    for(int i=1;i<=size;i++){
        if(a[i]!=-1){//即不是虚结点
            nodeCount++;//总结点数加1
            if(i*2>size)
                leafCount++;//叶结点数加1
            else if(a[2*i]==-1&&2*i+1<=size&&a[2*i+1]==-1)
                leafCount++;
        }
    }
}
int nonLeafCount=nodeCount-leafCount;
```

二叉链表形式，给定根结点：

```c++
int leafCount=nodeCount=0;
void Count(BiTree T,int &leafCount,int &nodeCount){
    if(T){
        nodeCount++;
        if(!T->lchild&&!T->rchild)
            leafCount++;
    }
	else
        return;
    Count(T->lchild,leafCount,nodeCount);
    Count(T->rchild,leafCount,nodeCount);
}
int nonLeafCount=nodeCount-leafCount;
```

二叉链表形式

### 计算二叉树某层的叶子结点数与非叶子结点数

题目描述：二叉树采用二叉链表存储结构，设计算法求指定某一层k(k>1)的叶子结点个数。

递归算法

算法思想：采用先序遍历，递归得到该层的叶子结点

```c++
int level=1;
int CountNode(BiTree T,int k){
  	level=0;
    PreOrder(T,0,k);
    return level;
}
void PreOrder(BiTree T,int depth,int k){
    if(depth<k){
        if(T->lchild!=NULL)
            PreOrder(T->lchild,depth+1,k);
        if(T->rchild!=NULL)
            PreOrder(T->rchild,depth+1,k);
    }
    else{
        if(depth==k&&T->lchild==NULL&&T->rchild==NULL)
            level+=1;
    }
} 
```

非递归算法

算法思想：采用层序遍历，设置整数记录当前层最后一个结点

```c++
const int MaxSize=1000;
BiTree Q[MaxSize];//定义队列
int BiTreeWidth(BiTree T,int k){
	int level=1,count=0;
    int font=0,rear=0;
    int last=0;//last指向当前层的最右结点
    Q[rear++%MaxSize]=T；//根结点入队
    BiTree p;
    while(front%MaxSize<=last%MaxSize){//在层内循环
        if(level==k){//已到指定层，队列中元素即为本层所有元素，依次出队
            while(front!=rear){
                p=Q[front++%MaxSize];
                if(p->lchild==NULL&&p->rchild==NULL)
                    count+=1;
            }
            return count;
        }
    	else{
            p=Q[front++%MaxSize];
            if(p->lchild)
                Q[rear++%MaxSize]=p->lchild;
            if(p->rchild)
 	       		Q[rear++%MaxSize]=p->rchild;
            if(front>=last){//该层结束，注意体会等号
		  		last=rear;//记录下层最右结点
                level+=1;//跳到下层
            }
        }
	}
}
```

### 查找指定值结点及其祖先

题目描述：在二叉树中查找值为x的结点，设该结点不会多于1个，获得该结点的所有祖先。

算法思想：后续遍历二叉树，当访问到该结点时，栈中所有值均为该结点的祖先。

```c++
const int MaxSize=1000;
void PostOrder2(BiTree T)
{
    int top=-1;//top指向栈顶元素
    BiTNode* stack[MaxSize];
    BiTree p = T, r = NULL; //p是工作指针,r指向上一个访问的结点
    //工作指针有结点，则说明需要向左走，工作指针指向空，说明需要向右
    while (p || top!=-1)
    {
        if (p) //一路向左
        {
            stack[++top]=p;
            p = p->lchild;
        }
        else //向右，元素出栈
        {
            p=stack[top];//读栈顶元素赋给p（并非出栈）
            if(p->data==x){
                top--; //当前结点删除
                cout << "当前结点的所有祖先为：" << endl;
                while (top!=-1)
                {
                    p=stack[top--];
                    cout << p->data << endl;
                }
                return;
            }
            if (p->rchild&&p->rchild!=r) //右子树且尚未被访问
            {
                p = p->rchild;
                stack[++top]=p;
                p = p->lchild; //继续向左走
            }
            else
            {
                p=stack[top--];//弹出结点
                visit(p);
                r = p;
                p = NULL; //重置p指针
            }
        }
    }
}
```

## 二叉树的遍历与建立综合

### 先序遍历和中序遍历序列建立二叉树

```c++
BiTree PrePostCreate(int *pre,int *in,int l1,int h1,int l2,int h2){
    //pre和in是二叉树的先序和中序遍历序列
    //l1,h1是先序序列第一和最后一个结点的下标
    //l2,h2是中序序列第一和最后一个结点的下标
    BiTree T=(BiTree)malloc(sizeof(BiTNode));
    T->data=pre[l1];
    for(int i=l2;i<=h2;i++)//获取根结点在中序遍历序列中的位置i,第i个记为根
        if(pre[l1]==in[i])
            break;
    if(i==l2)
        T->lchild=NULL;
    else
        //左子树在中序遍历的位置为前半部分，共i-(l2+1)+1=i-l2个，因此范围从l1到l1+i-l2
        T->lchild=PrePostCreate(pre,in,l1+1,l1+i-l2,l2,i-1);
    if(i==h2)
        T->rchild=NULL;
    else
        //右子树在中序遍历的位置为后半部分，因此范围从l1+i-l2+1到h1,第i个是根
        T->rchild=PrePostCreate(pre,in,l1+i-l2+1,h1,i+1,h2);
}
```

### 中序遍历和后序遍历序列建立二叉树

```c++
BiTree InPostCreate(int *in,int *post,int l1,int h1,int l2,int h2){
    //in和post是二叉树的中序和后序遍历序列
    //l1,h1是中序序列第一和最后一个结点的下标
    //l2,h2是后序序列第一和最后一个结点的下标
    BiTree T=(BiTree)malloc(sizeof(BiTNode));
    T->data=post[h2];//后序遍历的最后一个结点是根结点
    for(i=l1;i<=h1;i++)//获取根结点在中序遍历序列中的位置i,第i个记为根
        if(in[i]==post[h2])
            break;
    if(i==l1)//处理左子树
        T->lchild=NULL;
    else
        //左子树在后序遍历的位置为前半部分，共i-l1+1个，因此范围从l2到l2+(i-l1+1)
        T->lchild=InPostCreate(in,post,l1,i-1,l2,l2-l1+i-1);
    if(i==h1)
        T->rchild=NULL;
    else
        //右子树在后序遍历的位置为后半部分，范围从l2+(i-l1)到h2-1,最后一个是根
        T->rchild=InPostCreate(in,post,i+1,h1,l2+i-l1,h2-1);
    return T;
}
```

### 满二叉树先序遍历转为后序遍历序列

```c++
void PreToPost(int *pre,int *post,int l1,int h1,int l2,int h2){
    //pre和post是二叉树的先序和后序遍历序列
    //l1,h1是先序序列第一和最后一个结点的下标
    //l2,h2是后序序列第一和最后一个结点的下标
    if(h1>=l1){
        post[h2]=pre[l1];
        half=(h1-l1)/2;//half是左子树的结点数（或右子树的结点数）
        PreToPost(pre,post,l1+1,l1+half,l2,l2+half-1);
        //将左子树先序转为后序
        PreToPost(pre,post,l1+half+1,h1,l2+half,h2-1);
        //将右子树先序转为后序
    }
}
```

## 二叉树与链表综合

### 将二叉树中所有叶子结点链接为双链表

```c++
BiTree CreateLeafList(BiTree T){
    BiTree head=NULL,pre;
    if(T){
        CreateLeafList(T->lchild);
        if(T->lchild==NULL&&T->rchild==NULL){
            if(head==NULL){
                head=(BiTree)malloc(sizeof(BiTree));
                head->lchild=NULL;
                head->rchild=T;
                T->lchild=head;
                pre=T;
            }
            else{
                pre->rchild=T;
                T->lchild=pre;
                pre=T;
            }
    	}
        CreateLeafList(T->rchild);
        pre->rchild=NULL;//最后一个叶子结点为空
    }
    return head;//返回头指针
}
```

