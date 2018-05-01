#!/bin/sh
#-----------------------------------
#功能：安装依赖和在cron添加定时任务
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
  echo "下载缓慢时可以按Ctrl+C终止安装过程。"
  trap "bash uninstall.sh & exit 0" 2
  echo "更新apt源……"
  apt-get update > /dev/null || printAndExit "更新apt源失败。是否联网？"
  echo "用apt安装依赖libfontconfig1"
  apt-get install -y libfontconfig1 > /dev/null || printAndExit "apt安装依赖失败。请检查是否联网。"
  if [ ! -f "$DIR/phantomjs-2.1.1-linux-x86_64.tar.bz2" ];then
    echo "下载phantomjs安装包"
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 || printAndExit "下载失败。是否有wget命令？"
  fi
  if [ ! -d "$DIR/phantomjs-2.1.1-linux-x86_64" ];then
    echo "解压phantomjs安装包"
    tar -xjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C $DIR || printAndExit "解压安装包失败。请检查系统是否有tar命令。"
  fi
  if [ ! -f "config.json" ];then
    echo "创建config.json文件"
    echo -e "{\n  \"username\":\"\",\n  \"password\":\"\"\n}" > config.json 
    chmod a+w config.json
  fi
  echo "用cron设置定时执行认证上网"
  echo -e "# 功能：定时调用login.sh进行计算所科研楼web认证上线\n# 备注：解安装时建议用uninstall.sh删除本文件\n# 作者：furrybear(bearcubhaha@gmial.com)\n*/10 * * * * root bash $DIR/login.sh" > /etc/cron.d/web-auth-ictcas
  echo "安装完成！"
fi
