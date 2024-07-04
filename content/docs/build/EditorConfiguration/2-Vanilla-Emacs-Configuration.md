---
title: Vanilla Emacs
date: 2022-07-01 22:00:00
authors:
  - EndlessPeak
toc: true
hidden: false
draft: false
weight: 2
description: 本文章主要讨论在自定义Emacs中解决常见的基础配置问题。
---

## 参考配置 {#参考配置}

以下记录在 `Emacs` 中所遇到的常见问题与解决方案。
如果不希望从零开始，这里有一些常见的配置推荐（持续更新）：

1.  [MatthewZMD's emacs](https://github.com/MatthewZMD/.emacs.d)
2.  [Centaur's emacs](https://github.com/seagle0128/.emacs.d)
3.  [Redguard's emacs](https://github.com/redguardtoo/emacs.d)
4.  [Evanmeek's emacs](https://github.com/evanmeek/.emacs.d)
5.  [SpringHan's emacs](https://github.com/springhan/.emacs.d)
6.  [Cabins' emacs](https://github.com/cabins/.emacs.d)
7.  [7ym0n's emacs](https://github.com/7ym0n/dotfairy)


## 中文输入 {#中文输入}

fcitx5 是新一代输入法框架，具有默认的拼音输入引擎，当然也有 `fcitx5-rime` 。


### Locale {#locale}

调整 locale:

```text
LANG=zh_CN.UTF-8
LC_CTYPE="zh_CN.UTF-8"
LC_NUMERIC="zh_CN.UTF-8"
LC_TIME="zh_CN.UTF-8"
LC_COLLATE="zh_CN.UTF-8"
LC_MONETARY="zh_CN.UTF-8"
LC_MESSAGES="zh_CN.UTF-8"
LC_PAPER="zh_CN.UTF-8"
LC_NAME="zh_CN.UTF-8"
LC_ADDRESS="zh_CN.UTF-8"
LC_TELEPHONE="zh_CN.UTF-8"
LC_MEASUREMENT="zh_CN.UTF-8"
LC_IDENTIFICATION="zh_CN.UTF-8"
LC_ALL=
```


### Install {#install}

安装软件包：

```shell
sudo pacman -S xorg-fonts-misc
```


## 字体 {#字体}


### Doom emacs 中设置字体 {#doom-emacs-中设置字体}

设置中文字体，并为其添加 `hook` 。原因是 `doom eamcs` 大量采用了懒加载技术。

```emacs-lisp
;;设置中文字体
(defun leesin/set-fonts()
  (set-fontset-font "fontset-default" 'unicode (font-spec :family "等距更纱黑体 Slab Sc"
                                                          :size 20)
                    nil 'prepend))
(add-hook! 'after-setting-font-hook :append 'leesin/set-fonts)
```

设置英文字体,注释中详细说明了如何查看本机字体。简单来说，可以使用 `M-x menu-set-font` 。

```emacs-lisp
(setq doom-font (font-spec :family "SauceCodePro Nerd Font"
                           :size 20 )
      doom-variable-pitch-font (font-spec :family "SauceCodePro Nerd Font"
                                          :size 20)
      doom-unicode-font (font-spec :family "SauceCodePro Nerd Font"
                                   :size 18)
      doom-big-font (font-spec :family "SauceCodePro Nerd Font" :size 22))
```


### Vanilla Emacs 中设置字体 {#vanilla-emacs-中设置字体}

待更新


## 终端渲染 {#终端渲染}

```emacs-lisp
(when (display-graphic-p)
  (set-frame-width (selected-frame) 150)
  (set-frame-height (selected-frame) 60))
```


### 代理 {#代理}

```emacs-lisp
(defun leesin/toggle-proxy ()
  (interactive)
  (if (null url-proxy-services)
      (progn
        (setq url-proxy-services
              '(("http" . "127.0.0.1:8889")
                ("https" . "127.0.0.1:8889")))
        (message "代理已开启."))
    (setq url-proxy-services nil)
    (message "代理已关闭.")))
```


## Org 中文行内格式 {#org-中文行内格式}

```emacs-lisp
;; 设置org-mode中文格式，包括行内格式，折行问题
;; 由于Emacs懒加载的特性，下面的代码需要加入hook才能运行
;; 注意必须是 `add-hook' 而不能是 `add-hook!'
(add-hook 'org-mode-hook (lambda ()
                            (setcar (nthcdr 0 org-emphasis-regexp-components)
                                    "-[:multibyte:][:space:]('\"{")
                            (setcar (nthcdr 1 org-emphasis-regexp-components)
                                    "-[:multibyte:][:space:].,:!?;'\")}\\[")
                            (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
                            (org-element-update-syntax)
                            ;; 规定上下标必须加 {}，否则中文使用下划线时它会以为是两个连着的下标
                            (setq org-use-sub-superscripts "{}")
                            ;; 设置自动换行
                            (setq truncate-lines nil)
                            ;; 针对中文折行的问题进行设置
                            (toggle-word-wrap nil)
                            ))
```


## 背景透明 {#背景透明}

```emacs-lisp
  ;;;###autoload
(defun leesin/toggle-transparency()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ((numberp (cadr alpha)) (cadr alpha)))
              100
              )
         '(90 . 90) '(100 . 100)
        ))))
```
