---
title: Hugo及其Eureka主题
date: 2021-04-08 12:00:00
toc: true
featuredImage: images/Eureka.jpg
authors:
  - EndlessPeak
tags:
  - Hugo
  - Blog
categories: 
  - 杂谈
draft: false
---

Hugo 是 Go 编写的静态网站生成器，速度快，易用，可配置。Hugo 具有基于各种主题生成的内容和模板目录，以把markdown文件（包括org文件）渲染到完全静态的 HTML 网站。

Eureka是一个功能丰富且可高度定制化的Hugo主题，使用Eureka可以轻松快捷地定制并部署网站。

<!--more-->

## SSG

最原始的 Blog 应该就是纯静态的HTML页面，后来 Blog 开始火的时候，各种线上平台一统天下，而对于有点折腾能力的人来说，WordPress 、VuePress等不失为一种选择。后来，GitHub 当道，由 GitHub Pages 及其原生支持的工具链 Jekyll/Octopress 吸引了足够的眼球和人气，再后来便演变成 static site generator（本文简称为 SSG）的回归。

从技术上来讲，传统的 blog 就是一个简化的CMS系统。相较于 CMS，blog 更多的是个人开放给外界的一个展示窗口，并不需要太多的交互和额外的用户注册管理系统（如各种 bbs/forum/group 等），其主要技术特性是：

- 面向个人用户
- 页面排版简单
- 内容管理单一，基本上以 post 为主
- 需求模块较少，基本上就是 Comments, Categories, Tags, Archives

在这方面，SSG 所遵循的 fast, lightweight, easy-deployment 是很有优势的。最简单的 blog 完全可以只是一个 post list 页面。但是纯静态的 blog 又太简陋了，因此需要通过一些 hack 的手段，在 static 的页面上加入一些 dynamic 的东西，这个 hack 的手段，就是各种 SSG 中所谓的 compile 步骤。

compile 步骤是所有 SSG 的核心，它的设计好坏决定了一个 SSG 的品质。大体上讲，SSG 的工作方式如下：

1. **格式转换：** 扫描所有 post，进行初步 compile（这步 compile 主要作用是进行格式转换，比如 markdown/textile -> html）。
2. **汇总 metadata：** 汇总所有 post 的 metadata（比如 tag/category 可以用来做反向映射，datetime 可以用来给 post 进行排序），这些 metadata 信息可以在 template 渲染的时候访问。
3. **渲染模板：** 根据相应的 layout 规则，将 compile 后的 content 以及已有的 metadata 信息渲染成相应的页面（比如每篇 post 都需要有 navbar 和 footbar，这可以设定一下基础的页面 layout，包含公用的页面元素，然后通过模板继承或组合的方式，将 post 的内容以及相应的 metadata 信息渲染到这个 layout 中合适的位置，这就形成了最终看到的 static page）。

撰写 Blog 的群体对于 SSG 框架往往还有一些特别的需求：

- 代码高亮
- 数学公式
- 版本控制
- 编译部署

## Hugo

所以为什么要选择Hugo作为SSG平台，又为什么选择Eureka主题？

### org-mode

这里不得不提到 Emacs 中 org-mode 这样一个神奇的模式。我在4月份开始接触Emacs，大概花费了5天时间入门了这款古老而又现代的，完全符合GNU精神的编辑器，在我看来，它能延续至今且依然活力满满的原因有二，一是插件生态，二就是org-mode。

org-mode 是一个用文本方式来快速高效地做笔记、维持待办事项和做项目计划的模式。它是一个高校的GTD系统，同时也是一个创作发布系统。可能平白说这样两句并不能让人明白 org-mode 究竟是什么，但是如果你用过幕布的话，你就会发现，幕布等大纲模式的软件其原型便来自org-mode。当然，org-mode 的功能并不仅仅只是大纲这样简单，我会另写一系列文章详细描述 [org-mode]()

### hugo's feature

本文讲 org-mode 是为了说明，Hugo 的特点就是支持 markdown 与 org-mode 文件并存渲染（仅部分主题）下面是 Hugo 和基于它的主题 Eureka 的优点：

Hugo 是 Go 编写的静态网站生成器，快速，易用，可配置。

- 易用：Hugo 有一个内容和模板目录，把他们渲染到完全的 HTML 网站。用户可以从任意的目录中运行 Hugo，支持共享主机和其他系统。Hugo 当前提供 Windows，Linux，FreeBSD，NetBSD 和 OS X (Darwin) 的 x64, i386 和 ARM 架构的二进制预构建包。

- 快速：Hugo 只需要几分之一秒就可以渲染一个经典的中型网站，最好网站的每个部分渲染只需 1 毫秒。

- 可配置：Hugo 的源代码可以通过 Go 编译器工具链编译到任意地方运行，各主题源代码开放，方便进行个性化修改。

### quick start

在 Arch Linux及其衍生发行版上运行hugo简单且快速，执行下面的代码：

```bash
$ sudo pacman -S hugo
$ hugo new site hugosite #生成一个叫hugosite的文件夹，即站点根目录
```

只需不到5秒的时间，你的电脑就就成功安装了hugo并且创建了一个demo站点。

## Eureka

回忆一下刚才所提到的撰写 Blog 的群体对于 SSG 框架的特别的需求，包括代码高亮、数学公式、版本控制、编译部署等，其中编译部署可以简单地写一个独立可执行的shell文件，因此这里略过，介绍 Eureka 对其他特性的高度支持。末尾会说明如何安装该主题。

### Markdown Syntax

Eureka 具有良好的 Markdown 高亮支持。这里介绍引用块、表格、代码块、列表和其他元素。

#### Blockquotes

#### Blockquote without attribution

> 这是不带属性的引用块。
>
> **注意**你可以在引用块中使用 Markdown 高亮支持。

#### Blockquote with attribution

> 下面是一段带属性的引用块示例。
>
> Don't communicate by sharing memory, share memory by communicating.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: The above quote is excerpted from Rob Pike's [talk](https://www.youtube.com/watch?v=PAAkCSZUG1c) during Gopherfest, November 18, 2015.

#### Tables

表格并不是 Markdown 核心的一部分，但是对于 Hugo 来说，Hugo 支持它们开箱即用。

| Name  | Age  |
| ----- | ---- |
| Bob   | 27   |
| Alice | 23   |

##### Inline Markdown within tables

| Italics   | Bold     | Code   |
| --------- | -------- | ------ |
| *italics* | **bold** | `code` |

#### Code Blocks

Markdown 提供了对代码块的支持。即使你但 

##### Code block with backticks

普通代码块标注。

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Example HTML5 Document</title>
</head>
<body>
  <p>Test</p>
</body>
</html>
```

##### Code block indented with four spaces

仅仅只是对代码块做四个空格这样简单的处理。

    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Example HTML5 Document</title>
    </head>
    <body>
      <p>Test</p>
    </body>
    </html>

##### Code block with Hugo's internal highlight shortcode

Hugo 具有支持内联代码块显示的特性，使用双括号包裹高亮 HTML 的声明标签开头，最后以双括号包裹结束高亮声明的标签结尾，具体见本文源码。

{{< highlight html >}}

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Example HTML5 Document</title>
</head>
<body>
  <p>Test</p>
</body>
</html>
{{< /highlight >}}


#### List Types

下面是 Hugo 对 Markdown 列表的支持效果。

##### Ordered List

1. First item
2. Second item
3. Third item

##### Unordered List

* List item
* Another item
* And another item

##### Nested list

* Fruit
  * Apple
  * Orange
  * Banana
* Dairy
  * Milk
  * Cheese

#### Other Elements 

Eureka 还提供对其他 HTML 元素的原生支持，包括 abbr、sub、sup、kbd、mark 等属性。

<abbr title="Graphics Interchange Format">GIF</abbr> is a bitmap image format.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Press <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> to end the session.

Most <mark>salamanders</mark> are nocturnal, and hunt for insects, worms, and other small creatures.

### FeaturedImage

为每一篇文章赋特征图像，见于文章列表或文章详情页起始点，本文即为例。

### Emoji Support

Emoji 能够在 Hugo 项目中以多种方式启用。以下是原文档说明。

The [`emojify`](https://gohugo.io/functions/emojify/) function can be called directly in templates or [Inline Shortcodes](https://gohugo.io/templates/shortcode-templates/#inline-shortcodes). 

To enable emoji globally, set `enableEmoji` to `true` in your site's [configuration](https://gohugo.io/getting-started/configuration/) and then you can type emoji shorthand codes directly in content files; e.g.

<p><span class="nowrap"><span class="emojify">🙈</span> <code>:see_no_evil:</code></span>  <span class="nowrap"><span class="emojify">🙉</span> <code>:hear_no_evil:</code></span>  <span class="nowrap"><span class="emojify">🙊</span> <code>:speak_no_evil:</code></span></p>

<br>

The [Emoji cheat sheet](http://www.emoji-cheat-sheet.com/) is a useful reference for emoji shorthand codes.

**N.B.** The above steps enable Unicode Standard emoji characters and sequences in Hugo, however the rendering of these glyphs depends on the browser and the platform. To style the emoji you can either use a third party emoji font or a font stack; e.g.

{{< highlight html >}}
.emoji {
  font-family: Apple Color Emoji, Segoe UI Emoji, NotoColorEmoji, Segoe UI Symbol, Android Emoji, EmojiSymbols;
}
{{< /highlight >}}

{{< css.inline >}}

<style>
.emojify {
	font-family: Apple Color Emoji, Segoe UI Emoji, NotoColorEmoji, Segoe UI Symbol, Android Emoji, EmojiSymbols;
	font-size: 2rem;
	vertical-align: middle;
}
@media screen and (max-width:650px) {
  .nowrap {
    display: block;
    margin: 25px 0;
  }
}
</style>

{{< /css.inline >}}

### Diagram Support

Eureka 支持以 Mermaid 方式渲染 Markdown 的简图。以下是原文档的说明。

Please include the Mermaid diagram as below. Every mermaid chart/graph/diagram definition, has to have separate `<div>` tags.

In order to render the HTML code in the Markdown file correctly, please make sure that `markup.goldmark.renderer.unsafe` in `config.yaml` is true.

Here is one mermaid diagram:

<div class="mermaid">
  graph TD
  A[Client] --> B[Load Balancer]
  B --> C[Server1]
  B --> D[Server2]
</div>


And here is another:

<div class="mermaid">
  graph TD
  A[Client] -->|tcp_123| B(Load Balancer)
  B -->|tcp_456| C[Server1]
  B -->|tcp_456| D[Server2]
</div>

### Math Support

Eureka 默认支持以 KaTex 插件来渲染数学公式，下面是一些测试。

You can type inline equation like $E=mc^2$.

And also displayed equation like:

<div>
\[ \int u \frac{dv}{dx}\, dx=uv-\int \frac{du}{dx}v\,dx \]
</div>

Matrix:

<div>
\[ \begin{pmatrix} a&b\\c&d \end{pmatrix} \quad
\begin{bmatrix} a&b\\c&d \end{bmatrix} \quad
\begin{Bmatrix} a&b\\c&d \end{Bmatrix} \quad
\begin{vmatrix} a&b\\c&d \end{vmatrix} \]
</div>


Aligned equation:

<div>
\[\begin{aligned}
x ={}& a+b+c+{} \\
&d+e+f+g
\end{aligned}\]
</div>


And many other kinds of formulas.

### Installation Guide

安装 Eureka 不需要安装额外的第三方插件或 npm 库。

法一：可在下面两种克隆方式中任选其一。

```bash
$ git clone https://gitee.com/wangchucheng/hugo-eureka.git hugosite/themes/eureka
$ git clone https://github.com/wangchucheng/hugo-eureka.git hugosite/themes/eureka
```
法二：如果需要对主题提供长期支持，同时又不需要对主题作修改，可考虑以子模块注册（以根目录是站点，同时已经初始化仓库的情况下）。

```shell
$ git submodule add <上面的url地址> hugosite/themes/eureka
```
Eureka 使用单独的配置文件夹而不是独立的 `config.toml` 文件，因此需要使用该主题，需要进行如下操作：

```bash
$ cd hugosite
$ mv config.toml config.toml.bak # 备份原生hugo的配置文件
$ cp -r themes/eureka/examplesite/config ./ # 拷贝配置文件夹到站点根目录
```

更多配置详情内容请参阅：[Eureka](https://www.wangchucheng.com/zh/docs/hugo-eureka/)

下面补充我个人站点构建的其他内容。需求是使用git管理站点仓库，推送时希望推送到源码到该仓库的develop分支，生成的页面内容推送到master分支。

使用站点生成命令`hugo`自动在站点目录下生成`public`目录。

创建一个自动部署博客的脚本：

```
#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 进入生成的文件夹
cd public

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.gitee.io/<REPO>
git push -f git@gitee.com:endlesspeak/endlesspeak.git master

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master

cd - #返回到上一次的工作目录。

```

为站点初始化git仓库，然后指定远程分支

```bash
$ cd hugosite
$ git init
$ git remote add origin git@gitee.com:endlesspeak/endlesspeak.git
$ git push origin master:develop
```

最后一行代表将当前本地仓库推送到远程，其中origin是远程仓库名，master是准备推送的本地仓库分支，develop是希望推送到的远程仓库分支。

也可以使用关联分支命令，将本地master分支与远程的develop分支关联起来，这样以后只需要直接push就可以了，操作如下：

```bash
$ git branch -u origin/develop master
$ git push
```

