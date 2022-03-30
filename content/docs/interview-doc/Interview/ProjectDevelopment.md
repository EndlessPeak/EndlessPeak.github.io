---
title: 项目经历
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-04
hidden: false
draft: false
weight: 1
---

你本科阶段有哪些项目经历？

做过三个项目，分别是一个使用Java Server Page的考务管理系统，一个使用MybatisPlus + Springboot的商城系统，还有一个是有关三种传统机器学习算法的实现，使用的是最大信息增益比率的决策树、序列最小最优化算法的支持向量机和前馈神经网络。

下面是Java Web项目可能涉及的问题。

## 综合问题

1. 使用的是什么技术，采用的是什么架构？

   使用的技术：

   1. 考务管理系统使用的是Java Server Page+Java Bean+Servlet；
   2. 商城项目使用的是Mybatis Plus + Spring Boot；

   采用的架构：

   1. 考务管理系统使用的是MVC模式；
   2. 商城项目使用的是Java三层架构；

2. 什么是MVC模式？

   1. M for Model，代表业务模型
   2. V for view，代表视图层
   3. C for controller，代表控制器
   4. 考务管理项目中，JavaBean是业务模型M，JSP是视图层V，Servlet是控制器C；

3. 什么是Java三层架构？

   1. 业务层（逻辑层、service层）

      采用事务脚本模式。将一个业务中所有的操作封装成一个方法，同时保证方法中所有的数据库更新操作同时成功或同时失败。避免部分成功部分失败引起的数据混乱操作。

   2. 表现层（MVC）

      M称为模型，也就是实体类，Bean。用于数据的封装和数据的传输。

      V为视图，也就是GUI组件，JSP，用于数据的展示。

      C为控制，也就是事件，Controller，用于流程的控制。

   3. 持久层（DAO）

      采用DAO模式，建立实体类和数据库表映射Mapper。也就是哪个类对应哪个表，哪个属性对应哪个列。

      DAO位于业务逻辑和持久化数据之间实现对持久化数据的访问。就是将数据库操作都封装起来。

4. 商城项目主要分为哪些部分？对应Java三层架构的哪一层？

   主要有 JSP→Web/Controller→Service→ServiceImpl→Dao/Mapper→Bean
   1. Bean是各个基础类，是业务模型，属于MVC层的Model层；

   2. Dao封装对持久化数据的访问操作，如何处理数据并调用数据库；

   3. Service提供相应的服务，分模块调用各个Dao；

   4. ServiceImpl是它们的具体实现；

   5. Controller是MVC的Controller层，

         实现相应的功能，分模块请求多个服务，还包含请求服务时的预处理；

   6. JSP是MVC的View层，负责展示具体的页面；

5. 服务器中404 502 503 504错误分别代表什么？

   404是

6. cookie、session、token分别是什么？

   1. cookie是存储在浏览器端的加密文本，保存了大量轨迹信息。它由服务器生成，发送给浏览器。

      下一次相同的请求时，浏览器将把cookie发送到服务端，服务器使用这些信息来识别用户，确认用户状态。cookie是有状态的；

   2. session对象是存储在服务器端的，它存储特定用户会话所需的属性和配置信息（仅在会话期间有效）。

      当会话结束时，session对象被销毁。而下次产生该会话时，将会重新生成session对象；

   3. token是一小段通用的字符串。

      token令牌的值是存储在服务器中的数据库中，生成的token令牌也会保存在客户端的cookie中或其他地方。每次用户向服务器发送网络请求时都会附带token令牌，token是无状态的。

7. XXX


### Java Servlet

1. 项目介绍

   1. 登录系统
   2. 考试信息一览表：展示所有考试的情况，对于考试，管理员可以安排监考（若未安排监考）或修改考试信息，普通老师也可以申请成为监考；
   3. 监考信息修改：与考试申请表相同，设置标志为修改；
   4. 监考安排与指派：列出所有老师的当前状态，以及是否安排为主监考或副监考；
   5. 监考信息一览表：展示所有老师的概要信息、监考次数、 当前状态等情况；
   6. 考试申请表：普通老师向管理员申请考试，并添加相应的内容并提交；
   7. 查看我的考试申请：普通老师查看自己申请的考试情况；
   8. 待审核考试表：向管理员展示所有申请的考试，等待管理员进行审核；

2. JSP 过滤器是什么？

   过滤器可以动态地拦截请求和响应，以变换或使用包含在请求或响应中的信息。

   过滤器是可用于 Servlet 编程的 Java 类，可以实现以下目的：

   1. 在客户端的请求访问后端资源之前，拦截这些请求。
   2. 在服务器的响应发送回客户端之前，处理这些响应。

3. JSP和Servlet的区别？

   1. Servlet是位于Web服务器内部的服务器端的Java应用程序，与传统的从命令行启动的Java应用程序不同，Servlet由Web服务器进行加载，该Web服务器必须包含支持Servlet的Java虚拟机。

      Servlet具有独立于平台和协议的特性，可以生成动态的Web页面。它担当客户请求（Web浏览器或其他HTTP客户程序）与服务器响应（HTTP服务器上的数据库或应用程序）的中间层。

   2. JSP全名为Java Server Pages，中文名叫java服务器页面，是一种动态页面技术，它的主要目的是将表示逻辑从Servlet中分离出来。其根本是一个简化的Servlet设计。

      JSP技术使用Java编程语言编写类XML的tags和scriptlets，来封装产生动态网页的处理逻辑。网页还能通过tags和scriptlets访问存在于服务端的资源的应用逻辑。

      JSP将网页逻辑与网页设计的显示分离，支持可重用的基于组件的设计，使基于Web的应用程序的开发变得迅速和容易。

4. Servlet中提供了两种请求方法，doGet和doPost方法，它们的联系和区别为何？

   它们都是HTTP协议中的两种请求发送的方法，都是TCP连接。

   1. get把参数包含在URL中，post通过request body传递参数；

   2. get请求只能url编码，post支持多种编码方式；

   3. get请求有长度限制，post请求则无此限制；

   4. get仅接受ASCII字符，post请求无此限制；

   5. get产生一个TCP数据包，post产生两个TCP数据包；

      get在传输层逻辑上只传输一次，服务器返回200 ok；

      post逻辑上传输两次，先传header，服务器返回100 contiune，再传data，服务器返回200 ok；

5. 代码复用技术

   1. 条件查询，参数是条件语句，返回对象数组；
   2. 因为结果可能存在一个或多个，返回数组使上层不关心具体的实现细节，使用ResultSet提供的方法()进行遍历，避免在函数编写和调用时的复杂性，上层也无需判断可能的操作数量；
   3. 其他的查询，例如查询所有考试、根据考试编号查询考试、根据考试状态查询考试等查询方法，可直接调用该条件查询，只需修改对应的条件语句参数即可；

6. 前端接收数据格式

   前端Layui使用json字符串格式数据渲染表格，因此需要将object对象转化为json格式。使用的是fastjson包。

   定义转换函数：（待完善）

   1. 传入参数为object，code，message，count等信息；
   2. 初始化jsonObject对象，并使用jsonObject.put()方法依次加入code，message，count信息到JSONObject中；
   3. 使用json.toJSONString(object)将object转换为JSONObject；
   4. 由于object可能有多个，将JSONObject装入JSONArray后再加入JSONObject；
   5. 最后将JSONObject转为JSON字符串格式；

7. 登录系统

   请求 `AccountServlet` 进行登录并向其传参；

   使用 `request.getParameter()` 获得登录页面传来的参数；

   实例 `AccountBean` 类的对象并调用其 `login` 方法；

   在 `AccountBean` 类中创建`dataBaseBean`类对象，并运行`sql`语句，返回到`ResultSet`类的对象中。

   `ResultSet.beforeFirst()`跳转到开头；

   `ResultSet.next()`依次遍历

   `ResultSet.getString(XX).equals(YY)`验证用户名与密码是否正确。

   正确的话获取`AccountBean`类的用户名，类型和职工号。

   `request.getSession().setAttribute(XXX, YYY);`登录成功将account对象写入session

   改进思路：使用`string.concat()`连接字符串，使用`string.format()`形成格式化字符串。

8. 主页面

   `AccountBean account=session.getAttribute`获得当前登录的用户名和用户类型；

   根据用户类型获得用户对应的导航栏界面；

9. 表格页面

   使用`layui`中的`soulTable`组件。

   数据接口为`ExamQueryServlet`，数据格式为json格式，包括`code,msg,count,data`等。

   监听行工具事件，`layui`提供了方法获得当前行的数据，将数据作为参数赋给跳转页面。

10. 监考申请

    添加班级时，可以选择的班级由嵌入的`java`代码连接`dataBaseBean`，获得返回的内容并加入到选项中。

    添加班级使用内容模板，使用`layui`提供的`JavaScript`代码，获得父节点对象，克隆目标，修改ID，添加属性，加入到原来的表单中，更新渲染。

    `request.getRequestDispatcher(request.getHeader("Referer")).forward(request, response);`其中`Referer`代表请求的来源，`forward`代表请求转发。

    `window.location.href()`重定向到页面。

11. 请求转发和重定向的区别

    1. 请求转发是一个请求一次响应，而重定向是两次请求两次响应。
    2. 请求转发地址不变化，而重定向会显示后一个请求的地址。
       1. 请求转发是服务器的行为，是由容器控制的转向，整个过程处于同一个请求中，因此客户端浏览器不会显示转向后的地址；
       2. 重定向是客户端的行为，重新发送了请求，整个过程不在同一个请求中，因此客户端浏览器会显示跳转后的地址。
    3. 请求转发只能转发到本项目其它Servlet，而重定向不只能重定向到本项目的其它Servlet，还能定向到其它项目。
    4. 请求转发是服务端行为，只需给出转发的Servlet路径，而重定向需要给出requestURI，既包含项目名。

### Spring Boot

1. 项目简介

   1. 登录
   2. 商品信息管理
      1. 商品展示页面 前端 前台
      2. 商品管理页面 前端 后台
      3. 商品增删改查 后端
   3. 物流信息管理
      1. 物流管理页面 前端 后台
      2. 物流增删改查 后端
   4. 订单信息管理
      1. 订单管理页面 前端 后台
      2. 订单增删改查 后端
   5. 客户信息管理
      1. 客户管理页面 前端 后台
      2. 客户增删改查 后端
   6. 购物信息管理
      1. 购物管理页面 前端 前台
      2. 购物增删改查 后端

2. 前端后端，前台后台的区别

   1. 前端
   2. 后端
   3. 前台
   4. 后台

3. 容器

   容器是一种为某种特定组件的运行提供必要支持的一个软件环境。

   Spring的核心就是提供了一个IoC容器，它可以管理所有轻量级的JavaBean组件，提供的底层服务包括组件的生命周期管理、配置和组装服务、AOP支持，以及建立在AOP基础上的声明式事务服务等。

4. Spring的DI依赖注入

   依赖关系的管理交给spring的IOC容器维护，在当前类需要用到其他类的对象，由spring为我们提供，只需在配置文件中说明维护关系即可；

   这样做的目的是降低程序之间的耦合（依赖关系）。

5. 依赖注入的内容和方式

   依赖注入的内容包括：

   1. 基本类型和string
   2. 其他bean类型（在配置文件中或者注解配置过的bean）
   3. 复杂集合类型

   依赖注入的方式：

   1. 使用构造函数
   2. 使用set注入完成复杂集合类型数据
   3. 注解方式

6. Spring的控制反转

   1. 控制反转是一种设计思想，即你设计好的对象交给IOC容器控制，而不是传统的在你的对象内部直接控制。依赖注入是控制反转的一种典型实现方式。
   2. 由IoC容器控制了对象；控制外部资源获取。
   3. 控制权发生了反转，即从应用程序转移到了IOC容器。所有组件不再由应用程序自己创建和配置，而是由IoC容器负责。

7. Spring AOP 面向切面编程

   1. AOP把系统分解为不同的关注点，或者称之为切面（Aspect）；
   2. 模块化常用方法或常用步骤，对其进行动态代理；
   3. AOP对于解决参数固定的特定问题非常有效，但对经常需要变动的步骤则不容易实现；

8. 什么是Map，为什么用Map

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

9. 用到了哪些注解？

   1. @Override

      作为注释使用；代码规范，对父类方法的重写；编译器验证父类中是否有此方法；

   2. @ApiModel

      表示对model属性的说明或者数据操作更改，返回给swagger。

   3. @TableId

      用于主键的注解。

   4. @Mapper

      Mybatis框架中定义的一个描述数据层接口的注解。

   5. @Autowired

      注入一个定义好的bean类。

10. 声明式事务

   事务管理是为了当出现异常情况时，用它保证数据的一致性。

   1. 使用`PlatformTransactionManager`来表示事务管理器，所有的事务都由它负责管理。
   2. 使用`TransactionStatus`表示事务；

   **声明式事务**是建立在AOP之上的。其本质是对方法前后进行拦截。

   1. 添加`@EnableTransactionManagement`注解就可以启用声明式事务；
   2. 添加`@Transactional`注解为方法提供事务支持；

11. MyBatis的原理

    1. 读取 MyBatis 配置文件
    2. 通过配置文件加载映射 生成Configuration对象
    3. 构造会话工厂 创建SqlSessionFactory对象
    4. 创建会话对象 根据工厂创建SqlSession对象
    5. 输入参数映射
    6. 执行SQL语句 
    7. 输出结果映射

12. MyBatis使用的设计模式

    工厂模式使对象的创建过程延迟到子类进行，父类操作的是抽象产品，不关心子类的具体实例。

    工厂模式定义创建对象的接口，让子类自行决定实例化哪一个工厂类。

13. 安全框架 `shiro`

    1. 数据层 `Realm`

       `shiroRealm`负责用户的认证和权限的处理

    2. 管理层 `ShiroSecurityManager`

       1. `SecurityManager`权限管理类，组合了登录、登出、权限和session的处理

    3. 用户层 `Subject`

       `ShiroFilterFactoryBean`用于生成`shiroFilter`，指示哪些页面被保护，一般是除了登录页面和首页以外的全部页面。

       登录过程中，令牌token作参数；

    4. 登录过程

       1. Controller获得登录时传入的字符串
       2. 将字符串封装成自定义token类对象
       3. 根据token对象调用subject中的登录方法，放在try中，捕获各类匹配错误
       4. subject登录方法调用service中的登录方法，进而映射到Mapper中的SQL语句进行匹配
       5. 无错误，根据SecurityUtils中的`getSubject().getSession().getAttribute()`实例化用户对象

14. 数据库范式

    1. 1NF 是指数据库表的每一列都是不可分割的基本数据项；

    2. 2NF 是指实体的属性完全依赖于主关键字，而不能只依赖一部分属性；

    3. 3NF 是指属性不依赖于其它非主属性；

       例如存在部门信息表，每个部门除了部门号还有部门名称等；员工信息表中列出部门编号后不能再列出部门名称等，防止信息冗余。

    4. BCNF 是指在3NF基础上，消除主属性对码/键的部分依赖、传递依赖，则称它符合BCNF；

       即每一个决定因素都包含码。

15. 数据源或连接池

    1. 数据源的目的是提高程序性能，具体原理是：
       1. 事先实例化数据源，初始化部分连接资源
       2. 使用连接资源时可以从数据源获取
       3. 使用完毕后将连接资源归还给数据源
    2. 常见的数据源有哪些？
       1. C3P0连接池
       2. Druid连接池
    3. 我使用的是spring-boot-starter-jdbc连接池

16. SQL注入问题

    应用程序使用拼接SQL的技术而被黑客利用，攻击后台。

    使用mybatis编写sql语句时，`#{ }`和`${ }`两种方式 进行模糊查询。

    1. `${ }`表示拼接字符串，将接收到的参数内容不进行任何处理，会出现SQL注入问题。
    2. `#{ }`会先对sql语句进行预处理，不会出现SQL注入问题。

17. 分页查询

18. 下拉菜单或数据表的行操作

