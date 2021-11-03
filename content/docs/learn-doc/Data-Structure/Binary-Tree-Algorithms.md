---
title: 二叉树算法题解
toc: true
authors:
  - EndlessPeak
date: 2021-11-02
hidden: false
draft: false
weight: 9
---

二叉链表数据结构如下：

```c++
typedef struct BitNode {
    ElemType data;
    struct BitNode *left;
    struct BitNode *right;
}BitNode,*BiTree;
```

## 题1 判断二叉树是否镜像对称

### 递归算法

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
bool MirrorTree(BiTree T){
    if(T==NULL)	return true;
    else return isMirror(T1,T2);
}
```

### 迭代算法

利用二叉树的层次遍历获得二叉树每一层的数据，通过判断每一次的数据是否镜像对称。

特别地，在将每一层的信息存入二维向量时，将NULL也存入，读取数据时，若为NULL，则对应的数据转换为一个特殊标识（例如-1），以区分出两棵含有空结点的不同的树。

```c++
bool isMirror(BiTree T) {
	vector<vector<int>> ans;
	queue<BiTree> q;

    BiTree p = T;
    if (p == NULL)
        return true;
    else
        q.push(p);
	//使用队列进行层次遍历
    //特别地，遇到空结点也需要入队；使用size控制入队个数，防止null的null入队
    while (!q.empty())
    {
        vector<int> tmp;
        int size = q.size();
        for (int i = 0; i < size; i++)
        {
            p = q.front();
            q.pop();
            if (p != NULL)
                tmp.push_back(p->data);
            else
                tmp.push_back(-1);
            if (p != NULL)
            {
                if (p->left != NULL)
                    q.push(p->left);
                else
                    q.push(NULL);
                if (p->right != NULL)
                    q.push(p->right);
                else
                    q.push(NULL);
            }

        }
        ans.push_back(tmp);
    }
	//使用二维向量存储信息结点
    for (int i = 0; i < ans.size(); i++)
    {
        for (int j = 0; j < ans[i].size() / 2; j++)
        {
            if (ans[i][j] != ans[i][ans[i].size() - j-1])
                return false;
        }
    }
    return true;
}
```
## 题2 镜像翻转二叉树

### 递归算法

思想：递归交换左右子树。

```c++
BiTree Mirror(BiTree T) {
    	if(T == null) {
    		return T;
    	}
    	BiTree temp = T->left;
    	T->left = T->right;
    	T->right = temp;
    	Mirror(T->left);
    	Mirror(T->right);
}
```

或者不使用三变量交换法，先递归得到左右子树，然后直接交叉赋值。

```C++
BiTree invertTree(BiTree T)
{
    if (!T)
        return NULL;
    BiTree left = invertTree(T->lchild);
    BiTree right = invertTree(T->rchild);
    T->lchild = right;
    T->rchild = left;
    return T;
}
```

### 迭代算法

思想：

采用层次遍历，依次遍历结点并入队，出队时交换结点的左右孩子，并将左右孩子分别入队，循环直到队列为空。

```c++
BiTree Mirror(BiTree T) {
    std::queue<BiTree> q;
    BiTree temp,current;
    if(T==NULL)
        return T;
    q.push(T);
    while(!q.empty()) {
        current=queue.pop();
        temp=current->left;
        current->left=current->right;
        current->right=temp;
        if(current->left!=NULL)
            queue.push(current->left);
        if(current->right!=NULL)
            queue.push(current->right);
    }
    return T;
}
```

## 题3 求某层叶子结点个数

假设二叉树采用二叉链表存储结构，设计算法求指定某一层k(k>1)的叶子结点个数。

解法1：

采用层序遍历，设变量记录当前层次，记录当前层最后一个结点和下一层最后一个结点。

当没有达到目标层时，把该层结点的孩子结点均入队；

当到达目标层时，不再让各结点孩子入队，而是各个结点出队，统计它们之中叶子结点的个数。

```c++
int CountNode(BiTree T,int k){
    int level=0,count=0;
    std::queue<BiTNode*> Q;
    BiTNode *lastNode=NULL,*nextlastNode=NULL;
    Q.push(T);
    while(!Q.empty){
        BiTnode *p=NULL;
        if(level==k){
            while(!Q.empty){
                p=Q.pop();
            	if(p->lchild==NULL&&p->rchild==NULL)
                    count+=1;
            }
            break;
        }
        else{
            p=Q.pop();
            if(p->lchild!=NULL){
                Q.push(p->lchild);
                newlastNode=p->lchild;
            }
            if(p->rchild!=NULL){
                Q.push(p->rchild);
                newlastNode=p->rchild;
            }
            if(p==lastNode){
                lastNode=newLastNode;
                level+=1;
            }
        }
    }
    return count;
}
```

解法2：

采用先序遍历的方式，递归得到该层的叶子结点。

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

## 题4 求先序遍历序列中第n个结点的值

假设二叉树共有$n$个结点，采用二叉链表存储结构，设计算法求先序遍历序列中第$k(1\leq k \leq n)$的叶子结点的值。

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

## 题5 求在二叉树中值为x的结点的所有祖先

算法思想：采用非递归后序遍历，最后访问根结点。当访问到值为x的结点时，栈中所有元素都是该结点的祖先。

```c++
void PostNode(BiTree T, int x)
{
    stack<BiTNode *> S;
    BiTree p = T, r = NULL; //p是工作指针,r指向上一个访问的结点
    //工作指针有结点，则说明需要向左走，工作指针指向空，说明需要向右
    while (p || !S.empty())
    {
        if (p) //一路向左
        {
            S.push(p);
            p = p->lchild;
        }
        else //元素出栈，并在此过程中向右
        {
            p = S.top(); //读栈顶元素赋给p（并非出栈）
            if (p->data == x)
            {
                S.pop(); //当前结点删除
                cout << "结点的祖先为：" << endl;
                while (!S.empty())
                {
                    p = S.top();
                    S.pop();
                    cout << p->data << endl;
                }
                return;
            }
            if (p->rchild && p->rchild != r) //右子树且尚未被访问
            {
                p = p->rchild;
                S.push(p);
                p = p->lchild; //继续向左走
            }
            else
            {
                p = S.top();
                S.pop(); //弹出结点
                //visit(p);
                r = p;
                p = NULL; //重置p指针
            }
        }
    }
}
```

