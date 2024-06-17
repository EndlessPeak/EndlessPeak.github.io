---
title: Lie Group and Lie Algebras 1
authors: 
    - EndlessPeak
toc: true
date: 2023-11-20
featuredImage: 
hidden: false
draft: false
weight: 4
description: 本文记录了李群和李代数的相关概念、性质。
---

## Raise {#raise}

在 SLAM 中，除表示位姿(旋转)外，还需要对其进行估计和优化。然而，旋转矩阵自身带有约束(正交矩阵且行列式为 1)，此时对其进行优化显得困难。通过一定的转换关系，可以把带约束的优化问题转为无约束的优化问题。我们将这种转换称为李群——李代数转换关系。

三维旋转矩阵构成了特殊正交群 SO(3)，三维欧氏变换矩阵构成了特殊欧氏群 SE(3)，三维相似变换矩阵构成了相似变换群 Sim(3)。

$$
\begin{aligned}
&\operatorname{SO}(3) = \left \{\mathbf{R} \in \mathbb{R}^3 | \mathbf{R}\mathbf{R}^T=\mathbf{I},det( R)=1 \right \} \\
&\operatorname{SE}(3) = \left\{ \mathbf{T} \in \mathbb{R}^{4 \times 4} \mid \mathbf{T} = \begin{bmatrix}
\mathbf{R} & \mathbf{t} \\
\mathbf{0}^\mathrm{T} & 1
\end{bmatrix}, \mathbf{R} \in \mathrm{SO}(3), \mathbf{t} \in \mathbb{R}^3 \right\} \\
&\operatorname{Sim}(3) = \left\{ \mathbf{S} \in \mathbb{R}^{4 \times 4} \mid \mathbf{S} = \begin{bmatrix}
s\mathbf{R} & \mathbf{t} \\
\mathbf{0}^\mathrm{T} & 1
\end{bmatrix}, \mathbf{R} \in \mathrm{SO}(3), \mathbf{t} \in \mathbb{R}^3 \right\}
\end{aligned}
$$

注意到旋转矩阵和变换矩阵对加法不封闭，仅对乘法封闭。


## Group {#group}


### Defination {#defination}

群是一种集合加一种运算的代数结构，集合记作\(A\)，运算记作\(\cdot\)，则群记为\(G=(A,\cdot)\)，群满足 4 个条件：

1.  封闭性

    \\(\forall a\_1,a\_2\in A, a\_1\cdot a\_2\in A\\)

2.  结合律

    \\(\forall a\_1,a\_2,a\_3\in A,(a\_1\cdot a\_2)\cdot a\_3=a\_1\cdot(a\_2\cdot a\_3)\\)

3.  幺元

    \\(\exists a\_0\in A,\mathrm{s.t.}\forall a\in A, a\_0\cdot a=a\cdot a\_0=a\\)

4.  逆

    \\(\forall a\in A,\exists a^{-1}\in A, s.t. a\cdot a^{-1}=a\_{0}\\)

常见的群有：整数的加法，去掉 0 以后有理数的乘法，由 \\(n \times n\\) 的可逆矩阵构成的一般线性群等。

接下来验证 SO(3)、SE(3)和 Sim(3)关于乘法成群。


### SO(3) {#so--3}

首先验证 SO(3):

\begin{equation}
\operatorname{SO}(3)=\\{\mathbf{R} \in \mathbb{R}^3 | \mathbf{R}\mathbf{R}^T=\mathbf{I},det( R)=1\\}
\end{equation}

首先验证封闭性

\begin{gather}
\mathbf{R}\_1\mathbf{R}\_2 \in \mathbb{R}^{3 \times 3} \\\\
(\mathbf{R}\_1\mathbf{R}\_2)(\mathbf{R}\_1\mathbf{R}\_2)^T=\mathbf{R}\_1\mathbf{R}\_2\mathbf{R}\_2^\mathrm{T}\mathbf{R}\_1^\mathrm{T}=\boldsymbol{I} \\\\
\det(\mathbf{R}\_1\mathbf{R}\_2)=\det(\mathbf{R}\_1)\det(\mathbf{R}\_2)=1
\end{gather}

其次验证结合律

\begin{equation}
(\mathbf{R}\_1\mathbf{R}\_2)\mathbf{R}\_3=\mathbf{R}\_1(\mathbf{R}\_2)\mathbf{R}\_3)
\end{equation}

再次验证幺元

\begin{equation}
\exists \boldsymbol{E}\_{3\times 3}, s.t. \boldsymbol{R}\boldsymbol{E}=\boldsymbol{R}
\end{equation}

需要注意 3 维单位矩阵是旋转矩阵。

最后验证逆

\begin{align}
\forall \boldsymbol{R}, \boldsymbol{R}\_1^{-1}(\boldsymbol{R}\_1^{-1})^{\mathrm{T}}=\boldsymbol{R}\_1^{-1}(\boldsymbol{R}\_1^{\mathrm{T}})^{-1}=\boldsymbol{R}\_1^{-1}\boldsymbol{R}=\boldsymbol{I} \\\\
\det(\mathbf{R}\_1^{-1})=\det(\mathbf{R}\_1^{\mathrm{T}})=\det(\mathbf{R})=1
\end{align}

因此证明得 SO(3)关于乘法成群。


### SE(3) {#se--3}

接下来验证 SE(3):

$$
\operatorname{SE}(3) = \left\{ \mathbf{T} \in \mathbb{R}^{4 \times 4} \mid \mathbf{T} = 
\begin{bmatrix}
\mathbf{R} & \mathbf{t} \\
\mathbf{0}^\mathrm{T} & 1
\end{bmatrix}, \mathbf{R} \in \mathrm{SO}(3), \mathbf{t} \in \mathbb{R}^3 \right\}
$$

首先验证封闭性

\begin{equation}
T\_{1}T\_{2} =\begin{bmatrix}\mathbf{R}\_{1}&\mathbf{t}\_{1}\\\\mathbf{0}^{\mathrm{T}}&1\end{bmatrix}\begin{bmatrix}\mathbf{R}\_{2}&\mathbf{t}\_{2}\\\\mathbf{0}^{\mathrm{T}}&1\end{bmatrix}=\begin{bmatrix}\mathbf{R}\_{1}\mathbf{R}\_{2}&\mathbf{R}\_{1}\mathbf{t}\_{2}+\mathbf{t}\_{1}\\\\mathbf{0}^{\mathrm{T}}&1\end{bmatrix}
\end{equation}

由上面 SO(3)的证明过程得到

\begin{equation}
\mathbf{R}\_1\mathbf{R}\_2 \in \operatorname{SO}(3)
\end{equation}

且有

\begin{equation}
\mathbf{R}\_1\mathbf{t}\_2+\mathbf{t}\_1 \in \mathbb{R}^3
\end{equation}

其次验证结合律

\begin{equation}
(\mathbf{T}\_1\mathbf{T}\_2)\mathbf{T}\_3=\mathbf{T}\_1(\mathbf{T}\_2\mathbf{T}\_3)
\end{equation}

再次验证幺元

\begin{equation}
\exists \boldsymbol{E}\_{4\times 4}, s.t. \boldsymbol{T}\boldsymbol{E}=\boldsymbol{T}
\end{equation}

需要注意 4 维单位矩阵是旋转矩阵。

最后验证逆

\begin{gather}
\forall \boldsymbol{T}=\begin{bmatrix} \mathbf{R} & \mathbf{t}\\\ \mathbf{0^{\mathrm{T}}} & 1 \end{bmatrix},
\exists \mathbf{T}^{-1}=\begin{bmatrix} \mathbf{R}^{-1} & -\mathbf{R}^{-1}\mathbf{t}\\\ \mathbf{0^{\mathrm{T}}} & 1 \end{bmatrix},
s.t. \mathbf{T}^{-1} \mathbf{T} = \mathbf{E} \\\\
\det{T}=\det{T}^{-1}=1
\end{gather}

因此验证得 SE(3)关于乘法成群。


### Sim(3) {#sim--3}

接下来证明 Sim(3):

\begin{equation}
\operatorname{Sim}(3) = \left\\{ S \in \begin{bmatrix} s\mathbf{R} & \boldsymbol{t} \\\ \boldsymbol{0}^{\mathrm{T}} & 1 \end{bmatrix} \in \mathbb{R}^{4\times4} \right\\}
\end{equation}

首先验证封闭性：

\begin{equation}
S\_{1}S\_{2} = \begin{bmatrix} s\_{1}\mathbf{R\_1} & \mathbf{t\_1} \\\ \mathbf{0}^{\mathrm{T}} & 1 \end{bmatrix} \begin{bmatrix} s\_{2}\mathbf{R\_2} & t\_{2} \\\ \mathbf{0}^{\mathrm{T}} & 1 \end{bmatrix} = \begin{bmatrix} s\_{1}s\_{2}\mathbf{R\_1R\_2} & s\_{1}\mathbf{R\_1t\_2}+\mathbf{t\_1} \\\ \mathbf{0}^{\mathrm{T}} & 1 \end{bmatrix} \in \mathbb{R}^{4\times4}
\end{equation}

其次验证结合律

\begin{equation}
(\mathbf{S}\_1\mathbf{S}\_2)\mathbf{S}\_3=\mathbf{S}\_1(\mathbf{S}\_2\mathbf{S}\_3)
\end{equation}

再次验证幺元

\begin{equation}
\exists \boldsymbol{E}\_{4\times 4}, s.t. \boldsymbol{S}\boldsymbol{E}=\boldsymbol{S}
\end{equation}

需要注意 4 维单位矩阵是特殊的相似变换矩阵。

最后验证逆

\begin{equation}
\forall \mathbf{S}=\begin{bmatrix} s\mathbf{R} & \boldsymbol{t} \\\ \boldsymbol{0}^{\mathrm{T}} & 1 \end{bmatrix},
\exists \mathbf{S}^{-1}=\begin{bmatrix} \frac{1}{s}\mathbf{R}^{-1} & -\frac{1}{s} \mathbf{R}^{-1}\mathbf{t} \\\ \boldsymbol{0}^{\mathrm{T}} & 1 \end{bmatrix}, s.t.
\mathbf{S}^{-1}\mathbf{S} = \mathbf{E}
\end{equation}

因此证得 Sim(3)关于乘法成群。


## Lie Algebras Raise {#lie-algebras-raise}

李群是具有连续光滑性质的群。

1.  直观上看，刚体能够连续地在空间中运动，所以 SO(3)和 SE(3)都是李群
2.  可以说 SO(3)和 SE(3)在实数空间上是连续的

考虑旋转矩阵 \\(\mathbf{R}\\)

\begin{equation}
\mathbf{R}\mathbf{R}^\mathrm{T}=I
\end{equation}

将旋转看作过程，即扩展到随时间变化的函数 \\(\mathbf{R}(t)\\)

\begin{equation}
\mathbf{R}(t)\mathbf{R}^\mathrm{T}(t)=I
\end{equation}

同时求导得到:

\begin{equation}
\dot{\mathbf{R}}(t)\mathbf{R}(t)^\mathrm{T}+\mathbf{R}(t)\dot{\mathbf{R}}(t)^\mathrm{T}=0
\end{equation}

整理得:

\begin{equation}
\dot{\mathbf{R}}(t)\mathbf{R}(t)^\mathrm{T}=-\left(\dot{\mathbf{R}}(t)\mathbf{R}(t)^\mathrm{T}\right)^\mathrm{T}
\end{equation}

于是$\dot{\mathbf{R}}(t)\mathbf{R}(t)^\mathrm{T}$是一个反对称矩阵。对每个向量，都可以反对称化为一个反对称矩阵；反之也成立。

$$
a^{\wedge}=A=
\left[\begin{array}{ccc}
0 & -a_3 & a_2 \\
a_3 & 0 & -a_1 \\
-a_2 & a_1 & 0
\end{array}\right],\quad A^{\vee}=a
$$

设三维向量 \\(\phi(t) \in \mathbb{R}^3\\) 满足：

\begin{equation}
\dot{\mathbf{R}}(t)\mathbf{R}(t)^\mathrm{T}=\phi(t)^{\wedge}
\end{equation}

同时右乘 \\(\mathbf{R}(t)\\)，由于正交阵具有\\(\mathbf{R}^\mathrm{T}\mathbf{R}=I\\)

\begin{equation}
\left.\dot{\mathbf{R}}(t)=\phi(t)^{\wedge}\mathbf{R}(t)=\left[\begin{array}{ccc}0&-\phi\_3&\phi\_2\\\ \phi\_3 & 0 & -\phi\_1 \\\ -\phi\_2 & \phi\_1 & 0 \end{array}\right.\right]\mathbf{R}(t)
\end{equation}

即每次对旋转矩阵求一次导数，相当于左乘 \\(\phi^{\wedge}(t)\\) 。

考虑简单情况，假设 \\(t\_0=0\\) 时刻，旋转矩阵\\(\mathbf{R}(0)=I\\)，则

\begin{equation}
\begin{aligned}
\mathbf{R}\left(t\right) &\approx \mathbf{R}\left(t\_{0}\right) + \dot{\mathbf{R}}\left(t\_{0}\right)\left(t-t\_{0}\right) \\\\
&= \mathbf{R}\left(t\_{0}\right) + \phi\left(t\_0\right)^{\wedge}\mathbf{R}(t\_0)\left(t-t\_{0}\right) \\\\
&= I + \phi\left(t\_{0}\right)^{\wedge}\left(t\right)
\end{aligned}
\end{equation}

函数 \\(\phi\\) 反映了 \\(\mathbf{R}\\) 的导数性质，它在 SO(3)原点附近的正切空间上，同时在单位元 \\(t\_0\\) 附近，称其为单位元是因为 \\(R(t\_0)=I\\) 。

设 \\(\phi\\) 保持为常数 \\(\phi(t\_0)=\phi\_0\\)，则

\begin{equation}
\dot{\mathbf{R}}(t)=\phi(t\_0)^{\wedge}\mathbf{R}(t)=\phi\_0^{\wedge}\mathbf{R}(t)
\end{equation}

对上述微分方程，存在初始值 \\(\mathbf{R}(0)=I\\)，因此其特解为：

\begin{equation}
\mathbf{R}(t)=exp(\phi\_0^{\wedge}t)
\end{equation}

综上所述，

1.  给定某时刻 \\(\mathbf{R}\\) 即能够求出 \\(\phi\\) ，它描述了 \\(\mathbf{R}\\) 在局部的导数关系，且 \\(\phi\\) 正是对应到 SO(3)上的李代数\\(\mathfrak{so}(3)\\)
2.  给定 \\(\phi\\) 时，可以根据 \\(exp(\phi^{\wedge})\\) 计算李群，反之亦然，这正是李群与李代数之间的指数和对数映射。


## Lie Algebras Definations {#lie-algebras-definations}

每个李群都有对应的李代数。

1.  注意到 SO(3)和 SE(3)只有定义良好的乘法，没有定义良好的加法，因此难以进行取极限和求导的操作
2.  李代数对应单位元附近的正切空间，描述了李群的局部性质(导数)


### Definations {#definations}

李代数由集合 \\(\mathbb{V}\\) ，数域 \\(\mathbb{F}\\) 和一个二元运算 \\([,]\\) 组成。称李代数为\\((\mathbb{V},\mathbb{F},[,])\\)，记为 \\(\mathfrak{g}\\)

1.  封闭性

    \\(\forall X,Y\in\mathbb{V},[X,Y]\in\mathbb{V}\\)

2.  双线性

    \\(\forall X,Y,Z\in\mathbb{V},a,b\in\mathbb{F}\\),有：

    \\[
       [aX+bY,Z]=a[X,Z]+b[Y,Z],\quad[Z,aX+bY]=a[Z,X]+b[Z,Y].
       \\]

3.  自反性

    \\(\forall X\in\mathbb{V},[X, X] = 0\\)

4.  雅可比等价
    \\[
       \forall X,Y,Z\in\mathbb{V},[X,[Y,Z]]+[Z,[X,Y]]+[Y,[Z,X]]=0
       \\]

满足上述性质的 \\((\mathbb{V},\mathbb{F},[,])\\) 称为李代数，二元运算称为李括号。


### Example and Provement {#example-and-provement}

下面以三维向量叉积为例，证明 \\(\mathfrak{g}=(\mathbb{R}^3,\mathbb{R},\times)\\) 构成李代数。

首先验证封闭性

\begin{equation}
\forall X,Y\in\mathbb{R}^3 X\times Y\in\mathbb{R}^3
\end{equation}

然后验证双线性

\\(\forall X,Y,Z\in\mathbb{R}^3,a,b\in\mathbb{R}\\), 由叉乘的分配率可知

\begin{equation}
\begin{aligned}
(aX+bY)\times Z=a(X\times Z)+b(Y\times Z)
Z\times(aX+bY)=a(Z\times X)+b(Z\times Y)
\end{aligned}
\end{equation}

其次验证自反性

\\(\forall X\in\mathbb{R}^3\\)，由叉乘定义可知 \\(X\times X=0\\)

最后验证雅可比等价

\\(\forall X,Y,Z\in\mathbb{R}^3\\)，由叉乘的定义，展开计算可以得到

\begin{equation}
X\times(Y\times Z)=(X\cdot Z)\cdot Y-(X\cdot Y)\cdot Z
\end{equation}

因此有

\begin{equation}
X\times(Y\times Z)+Z\times(X\times Y)+Y\times(Z\times X)=\mathbf{0}
\end{equation}

该式类似球对称的性质。


## Two Lie Algebras {#two-lie-algebras}

下面讨论 SO(3)和 SE(3)上的李代数。


### SO(3) {#so--3}

记 SO(3)对应的李代数为 \\(\phi\\)，它是定义在 \\(\mathbb{R}^3\\) 上的向量。

定义 \\(\mathbf{\Phi}\\) 满足

\begin{equation}
\mathbf{\Phi}=\phi^{\wedge}=\left[\begin{array}{ccc}0&-\phi\_3&\phi\_2\\\ \phi\_3 & 0 & -\phi\_1 \\\ -\phi\_2 & \phi\_1 & 0 \end{array}\right]\in\mathbb{R}^{3 \times 3}
\end{equation}

则两个向量 \\(\phi\_1,\phi\_2\\) 的李括号为

\begin{equation}
[\phi\_1,\phi\_2]=(\mathbf{\Phi}\_1\mathbf{\Phi}\_2-\mathbf{\Phi}\_2\mathbf{\Phi}\_1)^\vee
\end{equation}

下面证明该李代数满足上述性质。

\begin{equation}
\mathfrak{so}(3)=\\{\phi\in\mathbb{R}^{3},\Phi=\phi^{\wedge}\in\mathbb{R}^{3\times3}\\}
\end{equation}

对于 \\(\mathfrak{so}(3)\\) 的封闭性

\begin{equation}
\forall\phi\_{1},\phi\_{2}\in\mathbb{R}^{3},[\phi\_{1},\phi\_{2}]=(\Phi\_{1}\Phi\_{2}-\Phi\_{2}\Phi\_{1})^{\vee}\in\mathbb{R}^{3}
\end{equation}

对于 \\(\mathfrak{so}(3)\\) 的双线性

\begin{equation}
\begin{aligned}
&\forall\phi\_1,\phi\_2,\phi\_3\in\mathbb{R}^3,a,b\in\mathbb{R} \\\\
\left[a\phi\_{1}+b\phi\_{2},\phi\_{3}\right] &=[(a\Phi\_{1}+b\Phi\_{2})\Phi\_{3}-\Phi\_{3}(a\Phi\_{1}+b\Phi\_{2})]^{\vee} \\\\
&=[a(\Phi\_{1}\Phi\_{3}-\Phi\_{3}\Phi\_{1})+b(\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})]^{\vee} \\\\
&=a(\Phi\_{1}\Phi\_{3}-\Phi\_{3}\Phi\_{1})^{\vee}+b(\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})^{\vee} \\\\
&=a[\phi\_{1},\phi\_{3}]+b[\phi\_{2},\phi\_{3}]
\end{aligned}
\end{equation}

同理可得

\begin{equation}
[\phi\_{3},a\phi\_{1}+b\phi\_{2}]=a[\phi\_{3},\phi\_{1}]+b[\phi\_{3},\phi\_{2}]
\end{equation}

对于 \\(\mathfrak{so}(3)\\) 的自反性

\begin{equation}
\forall\phi\in\mathbb{R}^3,[\phi,\phi]=(\Phi\Phi-\Phi\Phi)^\vee=\mathbf{0}
\end{equation}

对于 \\(\mathfrak{so}(3)\\) 的雅可比等价

\begin{equation}
\begin{aligned}
&\forall\phi\_1,\phi\_2,\phi\_3\in\mathbb{R}^{3} \\\\
\left[\phi\_{1},[\phi\_{2},\phi\_{3}]\right]&=[\phi\_{1},(\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})^{\vee}] \\\\
&=(\Phi\_{1}(\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})-(\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})\Phi\_{1})^{\vee}
\end{aligned}
\end{equation}

> 关于上式的详细说明：
>
> 对于给定的三个旋转向量 \\(\phi\_1, \phi\_2, \phi\_3 \in \mathbb{R}^3\\) ，考虑李代数 \\(\mathfrak{so}(3)\\) 中的雅可比等式。
>
> \begin{equation}
> \left[\phi\_{1},[\phi\_{2},\phi\_{3}]\right] = [\phi\_{1}, (\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})^{\vee}]
> \end{equation}
>
> 这里，\\([\phi\_{1},[\phi\_{2},\phi\_{3}]]\\) 表示两次李括号运算，\\((\Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2})^{\vee}\\) 表示将矩阵形式转换为向量形式（即反对称矩阵到旋转向量）。
>
> 根据李括号的定义，有
>
> \begin{equation}
> [\phi\_{1},[\phi\_{2},\phi\_{3}]] = [\phi\_{1}, \Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2}]
> \end{equation}
>
> 现在展开右侧的李括号运算，得到
>
> \begin{equation}
> [\phi\_{1}, \Phi\_{2}\Phi\_{3}-\Phi\_{3}\Phi\_{2}] = (\Phi\_1 (\Phi\_2 \Phi\_3 - \Phi\_3 \Phi\_2) - (\Phi\_2 \Phi\_3 - \Phi\_3 \Phi\_2) \Phi\_1)^{\vee}
> \end{equation}
>
> 因此上式成立

同理

\begin{equation}
\begin{aligned}
\left[\phi\_{3},[\phi\_{1},\phi\_{2}]\right]=(\Phi\_{3}(\Phi\_{1}\Phi\_{2}-\Phi\_{2}\Phi\_{1})-(\Phi\_{1}\Phi\_{2}-\Phi\_{2}\Phi\_{1})\Phi\_{3})^{\vee} \\\\
\left[\phi\_{2},[\phi\_{3},\phi\_{1}]\right]=(\Phi\_{2}(\Phi\_{3}\Phi\_{1}-\Phi\_{1}\Phi\_{3})-(\Phi\_{3}\Phi\_{1}-\Phi\_{1}\Phi\_{3})\Phi\_{2})^{\vee}
\end{aligned}
\end{equation}

相加可得

\begin{equation}
\left[\phi\_{1},[\phi\_{2},\phi\_{3}]\right]+\left[\phi\_{3},[\phi\_{1},\phi\_{2}]\right]+\left[\phi\_{2},[\phi\_{3},\phi\_{1}]\right]=0
\end{equation}

综上所述，\\(\mathfrak{so}(3)\\) 满足李代数的性质，该李代数形式为:

\begin{equation}
\mathfrak{so}(3) = \left\\{ \phi \in \mathbb{R}^3 , \Phi=\phi^{\wedge} \in \mathbb{R}^{3 \times 3}\right\\}
\end{equation}

该李代数是一个由三维向量组成的集合，每个向量对应到一个反对称矩阵，它与特殊正交群 SO(3)的关系为指数映射

\begin{equation}
\mathbf{R}(t)=exp(\phi^{\wedge})
\end{equation}


### SE(3) {#se--3}

与 \\(\mathfrak{so}(3)\\) 相似，\\(\mathfrak{se}(3)\\) 位于 \\(\mathbb{R}^6\\) 空间中

\begin{equation}
\mathfrak{se}(3)=\left\\{\xi=\left[\begin{array}{c}\boldsymbol{\rho}\\\\phi\end{array}\right]\in\mathbb{R}^6,\boldsymbol{\rho}\in\mathbb{R}^3,\phi\in\mathfrak{so}\left(3\right),\xi^{\wedge}=\left[\begin{array}{cc}\phi^{\wedge}&\boldsymbol{\rho}\\\\mathbf{0}^{\mathrm{T}}&0\end{array}\right]\in\mathbb{R}^{4\times4}\right\\}
\end{equation}

把每个 \\(\mathfrak{se}(3)\\) 元素记作 \\(\epsilon\\) ，它是一个六维向量，

1.  前三维为平移(不是变换矩阵中的平移)，记为 \\(\boldsymbol{\rho}\\)，
2.  后三维为旋转，记作 \\(\phi\\)，实质上是 \\(\mathfrak{so}(3)\\) 元素

此处 \\(\wedge\\) 不再表示反对称，而是满足

\begin{equation}
\xi^{\wedge}=\left[\begin{array}{cc}\phi^{\wedge}&\boldsymbol{\rho}\\\ \mathbf{0}^{\mathrm{T}}&0\end{array}\right]\in\mathbb{R}^{4\times4}
\end{equation}

形式上仍然保留 \\(\wedge\\) 和 \\(\vee\\) 来指代从“向量到矩阵”和“从矩阵到向量”的关系，李代数 \\(\mathfrak{se}(3)\\) 可以简单理解成一个平移加一个 \\(\mathfrak{so}(3)\\) 构成的向量(此平移不直接是平移)

李代数 \\(\mathfrak{se}(3)\\) 具有李括号:

\begin{equation}
\left[\xi\_1,\xi\_2\right]=(\xi\_1^{\wedge}\xi\_2^{\wedge}-\xi\_2^{\wedge}\xi\_1^{\wedge})^\vee
\end{equation}

下面证明 \\(\mathfrak{se}(3)\\)  满足李代数的性质

对于 \\(\mathfrak{se}(3)\\) 封闭性，

\begin{equation}
\begin{aligned}
&\forall \xi\_1,\xi\_2 \in \mathbb{R}^6 \\\\
[\xi\_{1},\xi\_{2}]& =(\xi\_{1}^{\wedge}\xi\_{2}^{\wedge}-\xi\_{2}^{\wedge}\xi\_{1}^{\wedge})^{\vee}  \\\\
&\left.=\left(\begin{bmatrix}\phi\_1^{\wedge}&\boldsymbol{\rho}\_1\\\\mathbf{0}^{\mathrm{T}}&0\end{bmatrix}\right.\begin{bmatrix}\phi\_2^{\wedge}&\boldsymbol{\rho}\_2\\\\mathbf{0}^{\mathrm{T}}&0\end{bmatrix}-\begin{bmatrix}\phi\_2^{\wedge}&\boldsymbol{\rho}\_2\\\\mathbf{0}^{\mathrm{T}}&0\end{bmatrix}\begin{bmatrix}\phi\_1^{\wedge}&\boldsymbol{\rho}\_1\\\\mathbf{0}^{\mathrm{T}}&0\end{bmatrix}\right)^{\vee} \\\\
&\left.=\left(\begin{bmatrix}\phi\_1^{\wedge}\phi\_2^{\wedge}&\phi\_1^{\wedge}\boldsymbol{\rho}\_2\\\\mathbf{0}^\mathrm{T}&0\end{bmatrix}\right.-\begin{bmatrix}\phi\_2^{\wedge}\phi\_1^{\wedge}&\phi\_2^{\wedge}\boldsymbol{\rho}\_1\\\\mathbf{0}^\mathrm{T}&0\end{bmatrix}\right)^{\vee} \\\\
&=\begin{bmatrix}\phi\_{1}^{\wedge}\phi\_{2}^{\wedge}-\phi\_{2}^{\wedge}\phi\_{1}^{\wedge}&\phi\_{1}^{\wedge}\boldsymbol{\rho\_{2}}-\phi\_{2}^{\wedge}\boldsymbol{\rho\_{1}}\\\\mathbf{0}^{\mathrm{T}}&0\end{bmatrix}^{\vee}
\end{aligned}
\end{equation}

由于 \\(\mathfrak{so}(3)\\) 的封闭性可知

\begin{equation}
(\phi\_{1}^{\wedge}\phi\_{2}^{\wedge}-\phi\_{2}^{\wedge}\phi\_{1}^{\wedge})^{\vee}\in\mathfrak{so}(3)
\end{equation}

由于 \\(\phi\_i^{\wedge}\\) 为 \\(3 \times 3\\) 反对称矩阵，且 \\(\mathbf{\rho}\_i\\) 是三维向量，因此容易得到

\begin{equation}
\phi\_1^\wedge\boldsymbol{\rho}\_2-\phi\_2^\wedge\boldsymbol{\rho}\_1\in\mathbb{R}^6
\end{equation}

对于 \\(\mathfrak{se}(3)\\) 的双线性

\begin{equation}
\begin{aligned}
&\forall\xi\_{1},\xi\_{2},\xi\_{3}\in\mathbb{R}^{6},a,b\in\mathbb{R} \\\\
[a\xi\_{1}+b\xi\_{2},\xi\_{3}]& =[(a\xi\_{1}^{\wedge}+b\xi\_{2}^{\wedge})\xi\_{3}^{\wedge}-\xi\_{3}^{\wedge}(a\xi\_{1}^{\wedge}+b\xi\_{2}^{\wedge})]^{\vee}  \\\\
&=[a(\xi\_{1}^{\wedge}\xi\_{3}^{\wedge}-\xi\_{3}^{\wedge}\xi\_{1}^{\wedge})+b(\xi\_{2}^{\wedge}\xi\_{3}^{\wedge}-\xi\_{3}^{\wedge}\xi\_{2}^{\wedge})]^{\vee} \\\\
&=a[\xi\_{1},\xi\_{3}]+b[\xi\_{2},\xi\_{3}]
\end{aligned}
\end{equation}

对于 \\(\mathfrak{se}(3)\\) 的自反性

\begin{equation}
\forall\xi\in\mathbb{R}^6,[\xi,\xi]=(\xi^\wedge\xi^\wedge-\xi^\wedge\xi^\wedge)^\vee=\mathbf{0}
\end{equation}

对于 \\(\mathfrak{se}(3)\\) 的雅可比等价性

\begin{equation}
\begin{aligned}
&\forall\xi\_{1},\xi\_{2},\xi\_{3}\in\mathbb{R}^{6},a,b\in\mathbb{R} \\\\
\left[\xi\_{1},[\xi\_{2},\xi\_{3}]\right]& =[\xi\_{1},(\xi\_{2}^{\wedge}\xi\_{3}^{\wedge}-\xi\_{3}^{\wedge}\xi\_{2}^{\wedge})^{\vee}]  \\\\
&=[\xi\_{1}^{\wedge}(\xi\_{2}^{\wedge}\xi\_{3}^{\wedge}-\xi\_{3}^{\wedge}\xi\_{2}^{\wedge})-(\xi\_{2}^{\wedge}\xi\_{3}^{\wedge}-\xi\_{3}^{\wedge}\xi\_{2}^{\wedge})\xi\_{1}^{\wedge}]^{\vee}
\end{aligned}
\end{equation}

同理可得

\begin{equation}
\begin{aligned}
\left[\xi\_{3},[\xi\_{1},\xi\_{2}]\right]=[\xi\_{3}^{\wedge}(\xi\_{1}^{\wedge}\xi\_{2}^{\wedge}-\xi\_{2}^{\wedge}\xi\_{1}^{\wedge})-(\xi\_{1}^{\wedge}\xi\_{2}^{\wedge}-\xi\_{2}^{\wedge}\xi\_{1}^{\wedge})\xi\_{3}^{\wedge}]^{\vee} \\\\
\left[\xi\_{2},[\xi\_{3},\xi\_{1}]\right]=[\xi\_{2}^{\wedge}(\xi\_{3}^{\wedge}\xi\_{1}^{\wedge}-\xi\_{1}^{\wedge}\xi\_{3}^{\wedge})-(\xi\_{3}^{\wedge}\xi\_{1}^{\wedge}-\xi\_{1}^{\wedge}\xi\_{3}^{\wedge})\xi\_{2}^{\wedge}]^{\vee}
\end{aligned}
\end{equation}

三个式子相加即得

\begin{equation}
\left[\xi\_{1},[\xi\_{2},\xi\_{3}]\right]+\left[\xi\_{3},[\xi\_{1},\xi\_{2}]\right]+\left[\xi\_{2},[\xi\_{3},\xi\_{1}]\right]=0
\end{equation}
