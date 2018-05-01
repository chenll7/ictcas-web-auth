#!/bin/sh
#-----------------------------------
#功能：移除依赖和删除cron定时任务
#作者：furrybear(bearcubhaha@gmail.com)
#备注：仅在Ubuntu16.04上测试过，需要cron支持
#修改时间：2018.04.28
#-----------------------------------
#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR

printAndExit(){
  echo -e "\033[41;37m$1\033[0m"
  exit -1
}

if [ $(whoami) != "root" ];then
  printAndExit "不是以root身份执行"
else
  echo "用apt移除依赖libfontconfig1"
  apt-get autoremove -y  libfontconfig1 > /dev/null || printAndExit "apt移除依赖失败。"
  echo "删除phantomjs"
  rm -rf $DIR/phantomjs-2.1.1-linux-x86_64
  rm $DIR/phantomjs-2.1.1-linux-x86_64.tar.bz2
  echo "删除cron定时任务"
  rm /etc/cron.d/web-auth-ictcas
  echo "解安装完成！"
fi
