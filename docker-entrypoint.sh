#!/bin/sh
#-------------------
#功能：docker镜像作为容器执行时的入口脚本，接受用户名和密码两个参数，并启动cron
#作者：furrybear<bearcubhaha@gmail.com>
#-------------------
if [ $# != 2  ];then
  echo "必须有两个参数作为用户名密码！" > /web-auth-ictcas/log/error.log
  exit -1
fi
echo -e "{\n  \"username\":\"$1\",\n  \"password\":\"$2\"\n}"  > /web-auth-ictcas/config.json
cron -f
