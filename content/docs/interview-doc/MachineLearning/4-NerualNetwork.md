---
markup: pandoc
title: 前馈神经网络问题
authors:
  - EndlessPeak
toc: false
featuredImage: 
date: 2022-03-25
hidden: false
draft: false
weight: 4
---

## 原理

1. 简要描述一下前馈神经网络算法的实现原理

   1. 确定每层隐藏层的层数、激活函数，根据净输入计算输出和活性值，然后传递给下一层，直到最终的输出层；
   2. 通过输出层的内容与分类结果比对，记录误差；
   3. 通过后一层的误差计算前一层的误差；计算该层的权重梯度和偏置梯度，然后更新参数，直到最前一层隐藏层。

2. 什么是激活函数？为什么需要激活函数？有哪些激活函数？

   1. 神经网络中每个神经节点接受上一层的输出作为本层的输入，并将输出传给下一层。上层节点的输出和下层节点的输入之间具有一个函数关系，这个函数称为激活函数（又称激励函数）。

   2. 激活函数的性质：连续并可导或少数点不可导的非线性函数，激活函数及其导数要尽可能简单；激活函数的导函数的值域要在一个合适的区间内；

   3. 激活函数的作用相当于支持向量机中的核技巧，使用非线性函数激活函数可以令神经网络具有逼近任意函数的能力，而不仅仅只是输入的线性组合。

   4. 激活函数例如Sigmoid型（包括Logistic函数和Tanh函数）又如ReLU型。

      $$
      \begin{align}
      &sigmoid(x)=\frac{1}{1+e^{-x}}\\
      &tanh(x)=\frac{e^x-e^{-x}}{e^x+e^{-x}}\\
      &tanh(x)=2\sigma(2x)-1\\
      &ReLU(x)=max(0,x)=
      \begin{cases}
      	\ x,x>0\\
      	\ 0,x<0
      \end{cases}
      \end{align}
      $$
      
   4. **激活函数的性质**
      
      1. Logistic 函数是“挤压”函数，值域$(0,1)$
      
            对一些输入产生兴奋，对另一些输入产生抑制
      
      2. Tanh 函数，值域$(-1,1)$
      
            零中心化（关于原点对称）。
      
            特别地，非零中心化会使后一层神经元的输入发生偏置偏移，并使梯度下降收敛速度变慢。
      
      3. ReLU 函数，值域$(0,+\infty)$
      
            非零中心化。另外在训练时比较容易“死亡“，即某一次更新后ReLU神经元对所有数据都是0，且在以后的训练过程中永远不能被激活。

3. 什么是通用近似定理？

   神经网络的隐藏层在满足一定条件时，可以以任意精度近似任何一个在实数空间内的有界闭集函数。

   条件如下：

   1. 具有线性输出层和至少一个使用“挤压”性质（把无穷区间映射到有穷区间）的激活函数；
   2. 隐藏层内神经元数量足够多；

4. 神经网络的前馈传播如何进行？

   设输入$\alpha_i=[\alpha_{i1},...,\alpha_{im}]^T$，第l层第i个神经元的输入是$m\times 1$的向量。

   设第l层权重矩阵的行向量$W_i^{(l)}=[W_{i1}^{(l)},...,W_{im}^{(l)}]$，第l层的第i个神经元的权重向量是$1\times m$向量。

   设第i层有n个神经元（n的数量可以自由设置）。

   1. 第l层的净输入$z^l$：
      $$
      z^{(l)}=W^{(l)}\alpha^{(l-1)}+b^{(l)}
      $$
      其中$W^{(l)}$是$n\times m$矩阵，$\alpha^{(l-1)}$是$m\times 1$向量。

   2. 第l层的净输出$\alpha^l$：
      $$
      \alpha^{(l)}=f_l(z^{(l)})
      $$
      其中$\alpha^{(l)}$是$n\times 1$向量。

   3. 特别地，样本向量x作为第0层的净输出；最后一层的净输出作为整个函数的输出。

5. 神经网络中的参数的学习方式是什么？

   损失函数为交叉熵损失函数，**样本**的损失函数为：
   $$
   \mathcal{L}(y,\hat{y})=-ylog\hat{y}
   $$
   训练集在数据集上的结构化风险函数为：
   $$
   R(W,b)=\frac{1}{N}\sum\limits_{n=1}^{N}\mathcal{L}(y^{(n)},\hat{y}^{(n)})+\frac{1}{2}\lambda\Vert W\Vert_F^2
   $$
   正则化项是Frobenius范数的平方，也就是所有参数平方的和。

   参数更新采用梯度下降法。具体过程如下：

   新参数等于旧参数减去学习率乘以偏导数（偏置参数）或偏导数加上$\lambda W^{l}$（权重参数）；
   $$
   W^l_{new}=W^l_{old}-\alpha(\frac{\partial \mathcal{L}(y^{(n)},\hat{y}^{(n)})}{\partial W^{l}}+\lambda W^{l})
   $$

   $$
   b^l_{new}=b^l_{old}-\alpha(\frac{\partial \mathcal{L}(y^{(n)},\hat{y}^{(n)})}{\partial b^{l}})
   $$

   

6. 反向传播算法

   先计算损失函数对**每个元素**的偏导数，然后合并到矩阵；根据链式法则：
   $$
   \frac{\partial\mathcal{L}(y,\hat{y})}{\partial\omega_{ij}^{(l)}}=\frac{\partial\mathcal{L}(y,\hat{y})}{\partial z^{(l)}}\cdot\frac{\partial z^{(l)}}{\partial\omega_{ij}^{(l)}}
   $$

   $$
   \frac{\partial\mathcal{L}(y,\hat{y})}{\partial b^{(l)}}=\frac{\partial\mathcal{L}(y,\hat{y})}{\partial z^{(l)}}\cdot\frac{\partial z^{(l)}}{\partial b^{(l)} }
   $$

   

   由上式知需要计算三个偏导数：

   1. 第l层的损失函数对第l层的净输入的偏导

      表示第l层神经元对最终损失函数的影响，也称其为误差项；

      $$
      \begin{aligned}
      \delta^{(l)}&=\frac{\partial\mathcal{L}(y,\hat{y})}{\partial z^{(l)}}\\
      &=\frac{\partial\alpha^{(l)}}{\partial z^{(l)}}\frac{\partial z^{(l+1)}}{\partial \alpha^{(l)}}\frac{\partial\mathcal{L}(y,\hat{y})}{\partial z^{(l+1)}}\\
      &=f'_l(z^{(l)})\odot\left((W^{(l+1)})\delta^{(l+1)})\right)\\
      \end{aligned}
      $$

      **第l层的神经元误差项**：是所有与该神经元相连的第l+1层的神经元的误差项的权重和再乘以该神经元激活函数的梯度。

   2. 第l层的净输入对第l层的权重向量的偏导

      矩阵微分采用**分母布局**，一个列向量关于标量的偏导数为行向量。

      $$
      \begin{aligned}
      \frac{\partial z^{(l)}}{\partial\omega_{ij}^{(l)}}&=\left[
      \frac{\partial z_1^{(l)}}{\partial\omega_{ij}^{(l)}},...,\frac{\partial z_i^{(l)}}{\partial\omega_{ij}^{(l)}},...,\frac{\partial z_{M_l}^{(l)}}{\partial\omega_{ij}^{(l)}},
      \right]\\
      &=\left[
      0,...,\frac{\partial (W_i^{(l)}\alpha^{(l-1)}+b_i^{(l)})}{\partial\omega_{ij}^{(l)}},...,0
      \right]
      \end{aligned}
      $$

      设结果为第i个元素为$a_j^{(l-1)}$，其余为0的行向量；
      $W_i^{(l)}$为权重矩阵$W^{(l)}$的第i行，即第i个神经元的权重向量。

   3. 第l层的净输入对第l层的偏置的偏导（单位矩阵）；最终得到下面的公式：

   $$
   \begin{align}
   & \frac{\partial \mathcal{L}(y^{(n)},\hat{y}^{(n)})}{\partial W^{l}}=\delta^{(l)}(\alpha^{(l-1)})^T\\
   & \frac{\partial \mathcal{L}(y^{(n)},\hat{y}^{(n)})}{\partial b^{l}}=\delta^{(l)}
   \end{align}
   $$

   4. 层与层之间参数更新的方式是矩阵乘法。

7. softmax函数

   假设我们有一个数组V，Vi表示V中的第i个元素，那么这个元素的Softmax值为
   $$
   S_i=\frac{e^{V_i}}{\sum\limits_je^{V_j}}
   $$
   该元素的softmax值就是该元素的指数与所有元素指数和的比值。

   定义交叉熵损失函数：
   $$
   Loss=-\sum\limits_i t_ilny_i
   $$
   其中$t_i$表示真实值，$y_i$​表示求出的softmax值。其中目标类的$t_i=1$，其他均为0。

   当预测到第i个时，可以认为$t_i=1$，损失函数变成：
   $$
   Loss_i=-lny_i
   $$
   定义选到$y_i$的概率为
   $$
   P_{f_{y_i}}=\frac{e^{f_{y_i}}}{\sum\limits_je^{f_{y_i}}}
   $$
   把数值映射到0-1之间，和为1，则有
   $$
   f_{y_i}=\frac{e^{f_{y_i}}}{\sum\limits_je^{f_{y_j}}}=1-\frac{\sum\limits_{j \neq i}e^{f_{y_j}}}{\sum\limits_je^{f_{y_j}}}
   $$
   对损失函数求导
   $$
   \begin{aligned}
   \frac{\partial Loss_i}{\partial f_{y_j}}&=\frac{\partial (-lny_i)}{\partial f_{y_j}}\\
   &=\frac{\partial (-ln\frac{e^{f_{y_i}}}{\sum\limits_je^{f_{y_j}}})}{\partial f_{y_j}}\\
   &=-\frac{1}{\frac{e^{f_{y_i}}}{\sum\limits_je^{f_{y_j}}}}\cdot \frac{\partial \frac{e^{f_{y_i}}}{\sum\limits_je^{f_{y_j}}}}{\partial f_{y_i}}\\
   &=-\frac{\sum\limits_je^{f_{y_j}}}{e^{y_i}}\cdot \frac{\partial(1-\frac{\sum\limits_{j \neq i}e^{f_{y_j}}}{\sum\limits_je^{f_{y_j}}})}{\partial f_{y_i}}\\
   &=-\frac{\sum\limits_je^{f_{y_j}}}{e^{y_i}}\cdot (-\sum\limits_{j \neq i}e^{y_j})\cdot \frac{\partial(\frac{1}{\sum\limits_j e^{y_j}})}{\partial f_{y_i}}\\
   &=\frac{\sum\limits_j e^{f_{y_j}}\cdot \sum\limits_{j \neq i}e^{y_j}}{e^{y_i}}\cdot \frac{-e^{y_i}}{(\sum\limits_{j}e^{y_j})^2}\\
   &=-\frac{\sum\limits_{j \neq i}e^{f_{y_j}}}{\sum\limits_je^{f_{y_j}}}\\
   &=-(1-\frac{e^{f_{y_i}}}{\sum\limits_je^{f_{y_j}}})\\
   &=P_{f_{y_i}}-1
   \end{aligned}
   $$
   
8. 什么是随机梯度下降？为什么要随机梯度下降？

   1. 为了使结构化风险函数最小，需要优化其中的参数。

   2. 每次采集一个样本，计算这个样本的结构化风险函数的梯度并沿负方向更新参数。

      沿负方向的目的是使结构化风险函数最小化。

   3. 其中结构化风险是经验风险加上一个参数的正则化项；

      经验风险是对所有**训练样本**的损失函数的平均值。

   4. 批量梯度下降的开销太大，每次只计算一个样本可以简化计算，通过梯度下降找到局部最优或鞍点，通过随机噪声跳出局部最优。降低开销，提高收敛速度。

9. 随机梯度下降的反向传播算法实现

   1. 随机初始化权重矩阵、偏置
   2. 当模型的错误率还在下降时，循环
      1. 对训练样本集中的样本随机重排序
      2. 对每个样本，循环
         1. 选取样本
         2. 前馈计算
         3. 反向传播

##  实现思路

1. sigmoid函数实现

   计算公式为：
   $$
   sigmoid(x)=\frac{1}{2}tanh(\frac{x}{2})
   $$
   实现代码为：

   ```python
   def sigmoid(x):
       return 0.5*(1+np.tanh(0.5*x))
   ```

   该函数实际未用，实际使用的是`numpy.tanh(x)`，因为它能传入矩阵。

2. numpy拆分数组和合并数组

   1. 合并数组`dataSet=np.concatenate((x_train, y_train), axis=1)`
   2. 拆分数组`x_train,y_train=np.split(dataSet,(76,),axis=1)`

3. numpy排序

   `numpy.sort(a,axis,kind,order)`

4. numpy产生随机权重矩阵

   1. `numpy.random.rand(76,50)`
   2. `numpy.random.randn(76,50)/np.sqrt(76)`

5. 正向传播

   ```python
   z1 = a0.dot(W1) + b1
   a1 = np.tanh(z1)
   z2 = a1.dot(W2) + b2
   a2 = np.tanh(z2)
   z3 = a2.dot(W3) + b3
   a3 = np.tanh(z3)
   z4 = a3.dot(W4) + b4
   # 最后一层使用softmax函数作为输出层激活函数
   exp_scores=np.exp(z4)
   # 归一化概率
   probs=exp_scores/np.sum(exp_scores,axis=1,keepdims=True)
   ```

6. 反向传播

   $\delta^{(l)}$的更新公式见上。输出层为softmax函数。
   $$
   \delta^{(l)}_k=p_k-1
   $$
   （该公式推导见上面。）

   ```python
   delta4 = probs
   delta4[range(num_examples), y] -= 1
   dW4 = (a3.T).dot(delta4)
   db4 = np.sum(delta4, axis=0, keepdims=True)
   delta3 = delta4.dot(W4.T) * (1 - np.power(a3, 2))
   # tanh(x)的导数是1-tanh^2(x)
   dW3 = (a2.T).dot(delta3)
   db3 = np.sum(delta3, axis=0, keepdims=True)
   delta2 = delta3.dot(W3.T) * (1 - np.power(a2, 2))
   dW2 = (a1.T).dot(delta2)
   db2 = np.sum(delta2, axis=0, keepdims=True)
   delta1 = delta2.dot(W2.T) * (1 - np.power(a1, 2))
   dW1 = np.dot(a0.T, delta1)
   db1 = np.sum(delta1, axis=0)
   ```

7. 预测

   正向传播一次，用softmax激活函数作输出层的激活函数，并归一化。

   使用`numpy.argmax`输出最大值索引（分类正确结果是0或1，两个概率哪个高选择哪个）





