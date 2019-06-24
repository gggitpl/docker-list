# git钩子设置

```bash
#/bin/bash

if [ ! -d "blog" ]; then
    git clone https://git.gggitpl.com/gggitpl/blog.git
else
    git --git-dir=$PWD/blog/.git --work-tree=$PWD/blog pull
fi
```

# 使用lsyncd命令同步html文件

```bash
lsyncd -direct /root/docker/gitea/data/git/repositories/gggitpl/blog.git/blog /root/docker/nginx/html/blog
```