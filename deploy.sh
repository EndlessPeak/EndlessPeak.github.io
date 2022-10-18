#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 进入生成的文件夹
cd public

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init -b main
git add -A
git commit -m 'deploy'

# 发布到 https://endlesspeak.github.io
#git push -f git@gitee.com:endlesspeak/endlesspeak.git master

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages
git push -f git@github.com:EndlessPeak/EndlessPeak.github.io.git main:main

cd - #返回到上一次的工作目录。
