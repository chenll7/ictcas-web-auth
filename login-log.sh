#!/bin/sh
#-------------------------
#功能：调用login.sh并向login.log写日志。
#作者：furrybear(bearcbhaha@gmail.com)
#修改日期：2018-05-02
#-------------------------
#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"
cd $DIR

DIR_LOG="$DIR/log"
# 创建log目录
if [ ! -d $DIR_LOG ];then
  mkdir $DIR_LOG
fi

# login.log超过一定大小删除
if [ -f "$DIR_LOG/login.log" ];then
  if [ $(ls -l $DIR_LOG/login.log|awk '{print $5}') -gt 1000000 ];then
    rm $DIR_LOG/login.log
  fi
fi
#执行登录操作
bash login.sh
#检查结果并记录日志
out=$?
echo $(date) >> $DIR_LOG/login.log
if [ $out == 99 ];then
  echo "已经联网，没有进行任何操作。" >> $DIR_LOG/login.log
elif [ $out == 100 ];then
  echo "认证成功，已经联网。" >> $DIR_LOG/login.log
elif [ $out == 101 ];then
  echo "认证失败，仍未联网。请检查config.json配置。" >> $DIR_LOG/login.log
fi
