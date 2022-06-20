---
title: Hello React
authors:
  - EndlessPeak
toc: true
date: 2021-08-12
hidden: false
draft: false
weight: 2
---

## 创建项目

用`create-next-app`快速创建项目。`create-next-app`是`Next.js`的脚手架工具，用于直接建立项目目录和基本结构。首次使用`create-next-app`,需要进行全局安装，安装命令如下。

```shell
$ npm install -g create-next-app
```

> 注1：`Arch Linux`滚动发行版中使用`npm`更新自身会与官方软件源更新`npm`产生冲突，因此避免使用`npm`更新自身，或者更新命令改为：
>
> ```shell
> $ pamac update
> ```
>
> 上述方法也不能避免产生的文件冲突，`pamac`会自动将冲突文件备份为`bak`。
>
> 注2：`npm`全局安装的组件位置为`/usr/lib/node_modules/`，为当前用户安装的目录为`./node_modules`

接下来创建一个项目总目录，博客项目分为三个大模块，所以需要一个顶层目录。 创建完成后，再进入目录。 安装完成后，进入你要建立项目的位置，使用`npx`来进行安装。

```shell
$ npx create-next-app blog
```

> `npx`可以调用项目内安装的模块而不需要切入到项目的node_modules目录下；同时也可以在避免全局安装模块的情况下运行它。当然本例中仍然全局安装了`create-next-app`。

输入后按回车，就会自动给我们进行安装项目需要的依赖，Next相关的命令也会添加好。完成后可以使用`yarn dev`来测试一下。在浏览器中输入`http://localhost:3000/`，网页顺利渲染说明项目创建成功。 

## 博客首页

### 首页初始化

用`create-next-app`建立好后，主页是默认的，删除默认的文件并把首页`index.js`改成下面的代码。

```js
import React from 'react'
import Head from 'next/head'
const Home = () => (
  <div>
    <Head>
      <title>Home</title>
    </Head>
 <div/>
)
export default Home
```

Next.js现已支持CSS文件，不需要额外增加`@zeit/next-css`包。

### 按需加载 Ant Design

接下来用`yarn`来安装`antd`，输入：

```shell
$ yarn add antd 
```

然后再安装一下`babel-plugin-import`，命令如下：

```shell
$ yarn add babel-plugin-import
```

安装完成后，在项目根目录建立`.babelrc`文件，然后写入如下配置文件。

```json
{
    "presets":["next/babel"],  //Next.js的总配置文件，相当于继承了它本身的所有配置
    "plugins":[     //增加新的插件，这个插件就是让antd可以按需引入，包括CSS
        [
            "import",
            {
                "libraryName":"antd"
            }
        ]
    ]
}
```

在`pages`目录下，重写`_app.js`文件，然后全局引入CSS 。

```js
import App from 'next/app'
import 'antd/dist/antd.css'
export default App
```

这样`Ant Design`就可以按需引入了。现在`index.js`加入一个按钮，看看是否可以正常使用,代码如下。 如果能正常使用，我们的基本环境就已经建立完成了。

```js
import React from 'react'
import Head from 'next/head'
import {Button} from 'antd'
const Home = () => (
  <div>
    <Head>
      <title>Home</title>
    </Head>
    <div><Button>我是按钮</Button></div>
 <div/>
)
export default Home
```

## 组件1:博客头部

**Ant Design的24格栅格化系统**

编写公用的头部遇到的第一个问题是如何让界面适配各种屏幕，直接使用`Ant Design`的轮子来制作。

Ant Design做好了栅格化系统，可以适配多种屏幕，简单理解成把页面的分成均等的24列，然后进行布局。

需要对适配几个属性熟悉一下：

- xs: `<576px`响应式栅格。
- sm：`≥576px`响应式栅格.
- md: `≥768px`响应式栅格.
- lg: `≥992px`响应式栅格.
- xl: `≥1200px`响应式栅格.
- xxl: `≥1600px`响应式栅格.
