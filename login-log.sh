#!/bin/sh
#-------------------------
#功能：调用login.sh并向login.log写日志。
#作者：furrybear(bearcbhaha@gmail.com)
#修改日期：2018-05-02
#-------------------------
#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"
cd $DIR
# login.log超过一定大小删除
if [ -f "$DIR/login.log" ];then
  if [ $(ls -l $DIR/login.log|awk '{print $5}') -gt 1000000 ];then
    rm $DIR/login.log
  fi
fi

bash login.sh
out=$?
echo $(date) >> $DIR/login.log
if [ $out == 99 ];then
  echo "已经联网，没有进行任何操作。" >> $DIR/login.log
elif [ $out == 100 ];then
  echo "认证成功，已经联网。" >> $DIR/login.log
elif [ $out == 101 ];then
  echo "认证失败，仍未联网。请检查config.json配置。" >> $DIR/login.log
fi
