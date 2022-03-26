---
title: 项目经历
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-04
hidden: false
draft: false
weight: 9
---

你本科阶段有哪些项目经历？

做过三个项目，分别是一个使用Java Server Page的考务管理系统，一个使用MybatisPlus + Springboot的商城系统，还有一个是有关三种传统机器学习算法的实现，使用的是最大信息增益比率的决策树、序列最小最优化算法的支持向量机和前馈神经网络。

## Java Web

### 综合问题

1. 使用的是什么技术，采用的是什么架构？

   考务管理系统使用的是JSP+JavaBean+Servlet；

   商城项目使用的是MybatisPlus + Spring Boot；

   采用的是MVC模式，分别是：

   1. M for Model，代表业务模型
   2. V for view，代表视图层
   3. C for controller，代表控制器

   对于具体项目的对应关系，

   1. JSP项目中，JavaBean是业务模型M，JSP是视图层V，Servlet是控制器C；
   2. SpringBoot项目中，JSP→Web/Controller→Service→ServiceImpl→Dao/Mapper→Bean
            1. Bean是各个基础类，属于业务模型；
            2. Dao提供基础操作，调用数据库；
            3. Service提供相应的服务，分模块调用各个Dao；
            4. ServiceImpl是它们的具体实现；
            5. Controller实现相应的功能，分模块请求多个服务，还包含请求服务时的预处理；
            6. JSP是MVC的View层，负责展示具体的页面；

2. 服务器中404 502 503 504错误分别代表什么？

3. cookie、session、token分别是什么？

   1. cookie是存储在浏览器端的加密文本，由服务器生成，发送给浏览器，下一次相同的请求时，浏览器将把cookie发送到服务端以确认用户状态，cookie是有状态的；
   2. session对象是存储在服务器端的，它存储特定用户会话所需的属性和配置信息（仅会话期间）；
   3. token令牌的值是存储在服务器中的，生成的token令牌也会保存在客户端的cookie中或其他地方。每次发送网络请求时都会附带token令牌，token是无状态的。


### Java Servlet

1. Servlet中提供了两种请求方法，doGet和doPost方法，它们的联系和区别为何？

   它们都是HTTP协议中的两种请求发送的方法，都是TCP连接。

   1. get把参数包含在URL中，post通过request body传递参数；

   2. get请求只能url编码，post支持多种编码方式；

   3. get请求有长度限制，post请求则无此限制；

   4. get仅接受ASCII字符，post请求无此限制；

   5. get产生一个TCP数据包，post产生两个TCP数据包；

      get在传输层逻辑上只传输一次，服务器返回200 ok；

      post逻辑上传输两次，先传header，服务器返回100 contiune，再传data，服务器返回200 ok；

2. JSP中使用的代码复用技术

   在查询/删除时，结果可能存在一个或多个，一开始设计的是判断操作数量，然后分别调用功能函数。重构时，上层不关心具体的实现细节，也无需判断可能的操作数量。

   对于查询/删除函数，查询时统一使用Bean类型的对象的数组存储结果并返回，SQL语句仅一条，使用ResultSet提供的方法(**待完善**)进行遍历，避免在函数编写和调用时的复杂性；而删除时（**待完善**）

3. 前端接收数据格式

   前端Layui使用json字符串格式数据渲染表格，因此需要将object对象转化为json格式。使用的是fastjson包。

   定义转换函数：

   1. 将数据object附加上code，message，count等信息；
   2. 初始化jsonObject对象，使用jsonObject.put()方法依次加入code，message，count信息；
   3. 使用json.toJSONString(object)将object转换为JSONObject；
   4. 由于object可能有多个，将JSONObject装入JSONArray后再加入JSONObject；
   5. 最后将JSONObject转为JSONString格式；

4. XXX

### Spring Boot

1. Springboot中使用的代码复用技术

2. 什么是Map，为什么用Map

   Map是一个接口，它的每个元素包含一个key对象和一个value对象，key必须是唯一的且不能重复。

   Map的实现类包括HashMap、TreeMap、HashTable。

   1. TreeMap是有序的，HashMap和HashTable是无序的；
   2. Hashtable的方法是同步的（线程安全），HashMap的方法是异步的（非线程安全）；
   3. Hashtable不允许null值，HashMap允许null值（key和value都允许）

   Map的通用方法有：

   1. 返回map集合大小 `int size;`

   2. 判断map集合为空 `boolean isEmpty();`

   3. 根据key值获取value `Object get(Object key);`

   4. 添加元素\<key value> `Object put(Object key,Object value);`

   5. 获取元素的键和值的接口；

      ```java
       interface Entry<k,v>{
       	k getKey();
       	v getValue();
       }
      ```

3. 注解@Override

   1. 作为注释使用；
   2. 代码规范，对父类方法的重写；
   3. 编译器验证父类中是否有此方法；

## 机器学习

### 综合问题

1. 入侵检测技术的原理如何？

   包括基于数据源划分和基于检测技术的划分。数据源就是数据如何产生，可基于主机或基于网络；检测技术则分为基于误用和基于异常。基于误用可以理解为模式匹配，基于异常是只要不合法就判断为非法。入侵检测技术可简化成一种二分类问题。

2. 如何选择研究方法？

   由于使用基于异常的检测技术，也就是对正常或者不正常的访问进行划分，数据集中包含了最终的分类标签，因此采用的是监督学习。

   在生成方法和判别方法中，生成方法是统计得到联合概率，计算后得到条件概率；判别方法则直接学习条件概率，因此判别方法可以**简化学习问题**。

   毕业课题中，第一，所有的变量理论上都可以观测到值，不存在隐变量；第二，实际应用中部署的是训练好的模型，生成模型学习收敛速度快这点并不占优势，最后是由于判别方法直接学习条件概率或决策函数，准确率较高。

3. 什么是损失函数，什么是经验风险，什么是期望风险，什么是结构风险？

   1. 损失函数：针对单个具体样本，表示模型预测值与真实样本值之间的差距。常见的损失函数有0-1损失函数、平方损失函数、绝对损失函数、对数损失函数（对数似然损失函数）。
   2. 经验风险：对所有训练样本的**损失函数的平均值**，或模型对**所有训练样本**的预测能力。
   3. 期望风险：对所有样本损失函数的平均值，或模型对未知样本和已知的训练样本的综合预测能力。
   4. 结构风险：是对经验风险和期望风险的折中，在经验风险函数后面加一个正则化项。

4. 为什么使用决策树、支持向量机、前馈神经网络算法实现入侵检测？

   选择决策树是因为它原理简单，可解释性高，可视性好，一开始使用迭代二分法决策树作为原型，后面改用最大信息增益比率决策树进行实现，原因是需要对连续值进行划分；选择支持向量机则是因为它是传统机器学习算法中表现最优异的一种，推导严谨，分类比较精确，具体实现上使用序列最小优化算法进行实现，后面借鉴了一下最小二乘法的实现；选择前馈神经网络，它结构简单，实现快，可用它与传统机器学习算法进行对照。
   
5. 没有免费午餐定理

   任何一个预测函数，如果在某些样本上表现好，那么在另一些样本上就表现不好。
   
   <u>如果不对数据在特征空间的先验分布有一定假设</u>，那么表现好与表现不好的情况一样多。
   
   定理价值：
   
   1. 必须假设：在特征空间上接近的样本属于同一类别的概率更高。
   2. 没有放之四海而皆准的最好算法，因为没有人知道特征空间先验分布的真正情况。
   
5. 评价标准

   样本共有4类，分别是：
   
   1. TP：实例是正例，且被判定为正例
   2. FP：实例是反例，但被判定为正例，误报
   3. TN：实例是反例，且被判定为反例
   4. FN：实例是反例，但被判定为正例，漏报
   
   正确率：$Accuracy=\frac{TP+TN}{TP+TN+FP+FN}$
   
   精确率：$Precision=\frac{TP}{TP+FP}$
   
   召回率：$Recall=\frac{TP}{TP+FN}$
   
   两者**通常**相互“制约”：追求精确率高，则召回率就低；追求召回率高，则通常会影响精确率。
   
5. 项目过程（项目是怎么实现的）

   项目主要分为数据处理、模型学习和模型预测三个步骤。具体过程见下：
   
   环境准备
   
   ```python
   import numpy as np
   import pandas as pd
   import matplotlib.pyplot as plt
   import math
   ```

### 数据处理

1. 你的数据集是怎样选取的，为什么要这样选择？

   我选择的数据集是CIC-IDS-2017，基于以下原因。（**待完善**）

2. 你对数据做了哪些预处理？有哪些改进的方法？

   主要包括：数据准备、删除缺失值、归一化和特征缩放。

   数据处理这块参考了一个使用CIC-IDS-2017数据集的入侵检测基线系统，它有一个删除低关联的特征的操作，但是基于异常的入侵检测本身需要更多维度的数据作为支撑，对于未知的入侵过程来说具体哪些特征属于低关联特征是不清楚的，因此这里没有选择删除低关联的特征。

3. 数据准备如何实现？

   解压缩数据：

   ```python
   !unzip XXXX.zip -d ./data/
   ```

   项目使用pandas导入数据集，导入后格式为dataframe：

   ```python
   wednesday=pd.read_csv('XXX.csv',low_memory = False) #low_memory参数可以省略
   ```

   若使用numpy导入数据集，导入后格式是元组：

   ```python
   p = r'XXXX.csv'
   with open(p,encoding = 'utf-8') as f:
       data = np.loadtxt(f,str,delimiter = ",")
       print(data[:5])
   ```

   注释：

   1. numpy导入数据使用的方法是`numpy.loadtxt()`，默认是float格式，通过加入str参数可使其识别字符串类型数据，避免导入出错；
   2. `with open() as f`是读入文件方法，r代表以只读方式打开文件；
   3. `[:5]`代表的是从第1行一直到第5行。

   对数据列名进行规范：

   ```python
   wednesday = wednesday.rename(str.lstrip, axis='columns')
   ```

   注释：

   1. `dataframe.rename()`方法用于更改数据的行列名。通过axis参数指定行列。
   2. `str.lstrip()`方法用于去除字符串起始部分的选定字符，默认为空格。

   查看标签情况：

   ```python
   df = wednesday
   print(df['Label'].unique())
   ```

   注释：

   1. `dataframe.unique()`方法以数组形式返回列的唯一值（去除重复值），用于获知有哪些标签。
   2. `dataframe.nunique()`方法返回的是列的唯一值的个数。

   获得数据列名：

   ```python
   #法一，等价于法二
   lables=[column for column in df] 
   #法二
   lables=[]
   for column in df:
       labels.append(column)
   lables.remove('Label')
   print(lables)
   print(len(lables))
   ```

   注释：

   1. `c for b in a`指的是对a中每一个迭代对象b，都进行c操作。此处将语句放在元组里等于对迭代对象使用`list.append()`方法。
   2. `list.remove()`方法用于移除元组中的某个元素。
   3. `list.len(list)`方法用于获得元组中的元素个数。

4. 缺失值删除是如何实现的？

   将inf替换为NaN，然后删除缺失值

   ```python
   df=df.replace(np.inf,np.nan)
   df=df.dropna(axis=0)
   ```

   注释：

   1. `dataframe.replace()`方法用于将数据中的某个元素统一替换为另一个元素；
   2. `dataframe.dropna()`方法用于将数据中的缺失值删除
   3. axis=0或'index'表示删除包含缺失值的行；axis=1或'columns'表示删除包含缺失值的列

5. 标签与特征分离

   ```python
   X = df.loc[:,df.columns != "Label"]
   y = df.loc[:,df.columns == "Label"]
   ```

   注释：

   1. `dataframe.loc()`方法用于切片，提供参数为行索引名称或条件 , 列索引名称，切片结果是闭区间；
   2. `dataframe.iloc()`方法亦用于切片，提供参数为行索引位置和列索引位置，切片结果是开区间。

6. **归一化**和**特征缩放**是如何实现的？

   1. 对于标签数据，使用`sklearn.LabelEncoder()`来转化

      ```python
      encoder = LabelEncoder()
      y = encoder.fit_transform(y)
      ```

      注释：

      1. `LabelEncoder` 来转化 dummy variable（虚拟数据）非常简便，encoder 可以将数据集中的文本转化成0或1的数值，从而解决二分类问题。
      2. `fit_transform()`方法对数据进行统一处理，包括将数据缩放(映射)到某个固定区间，归一化，正则化等标准化等。特别地，得到的类型为numpy。

   2. 对于非标签数据，使用`sklearn.RobustScaler()来转化`

      ```python
      scaler=RobustScaler()
      X = scaler.fit_transform(X)
      ```

      注释：

      归一化分为`StandardScaler`，`MinMaxScaler`，`RobustScaler`等；

      1. 标准化缩放方法通过减去均值然后除以方差（或标准差）；

      2. 最大最小值缩放方法将特征缩放到给定的最小值和最大值之间；

      3. 鲁棒缩放方法使用中位数和四分位矩，不容易受到异常值影响。

         原理：

         1. 四分位数，把所有数值从小到大分为四等份，处于三个分割点位置的数值是四分位数；

         2. 第一四分位数和第三四分位数的差称为四分位距；

         3. 计算方法为：
         	
         	$$
            v_i^{'}=\frac{v_i-median}{IQR}
            $$

            其中median是中位数，IQR是样本的四分位距。

   3. 另外，`dataframe.values()`方法用于将pandas转为numpy类型
   
7. 训练集与验证集划分

   使用`sklearn.train_test_split()`方法。

   ```python
   x_train, x_test, y_train, y_test = train_test_split(X, y, test_size=0.30, shuffle=True, random_state=123, stratify=y)
   ```



### 具体实现

问：Python的四大数据类型是哪些？

答：元组、列表、字典、字符串

### 改进方向

决策树：CART树

支持向量机：最小二乘法、加权、稀疏核机

神经网络：循环神经网络

