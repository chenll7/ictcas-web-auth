#!/bin/sh
#--------------------
#功能：构建和启动docker容器
#--------------------

#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"
cd $DIR

if [ $# != 2 ];then
  echo "参数数量不对，需要两个参数作为用户名密码！"
  exit -1
fi
docker build -t web-auth-ictcas .
docker run --name web-auth-ictcas --restart always -d web-auth $1 $2
