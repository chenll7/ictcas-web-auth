#!/bin/sh
#-----------------------------------
#功能：安装依赖和在cron添加定时任务
#作者：furrybear(bearcubhaha@gmail.com)
#备注：仅在Ubuntu16.04上测试过，需要cron支持
#-----------------------------------

#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR

TARFILE_PhantomJS="phantomjs-2.1.1-linux-x86_64.tar.bz2"
MD5_TARFILE_PhantomJS="1c947d57fce2f21ce0b43fe2ed7cd361"
DIR_PhantomJS="phantomjs-2.1.1-linux-x86_64"

printAndExit(){
  echo -e "\033[41;37m$1\033[0m"
  exit -1
}

username=""
passwd=""

if [ $# == 2 ];then
  username=$1
  passwd=$2
elif [ $# == 0 ];then
  echo "没有输入用户名密码，请安装完后在config.json内添加。"
else
  echo "参数个数不对，用户名密码需要两个参数。"
  exit -1
fi

echo "下载缓慢时可以按Ctrl+C终止安装过程。"
trap "bash uninstall.sh & exit 0" 2

echo "更新apt源……"
sudo apt-get update > /dev/null || printAndExit "更新apt源失败。是否联网？没有获得root权限？"

echo "用apt安装依赖libfontconfig1"
sudo apt-get install -y libfontconfig1 > /dev/null || printAndExit "apt安装依赖失败。请检查是否联网。"

if [ -f $TARFILE_PhantomJS ];then
  REAL_MD5_TARFILE_PhantomJS=$(md5sum $TARFILE_PhantomJS|cut -d ' ' -f1)
  if [ $REAL_MD5_TARFILE_PhantomJS != $MD5_TARFILE_PhantomJS ];then
    echo "发现$TARFILE_PhantomJS不是完整的，因为计算出来的MD5值为$REAL_MD5_TARFILE_PhantomJS，正确应为$MD5_TARFILE_PhantomJS"
    rm $TARFILE_PhantomJS
  fi
fi

if [ ! -f $TARFILE_PhantomJS ];then
  echo "下载phantomjs安装包"
  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 || printAndExit "下载失败。是否有wget命令？"
fi

if [ -d $DIR_PhantomJS ];then
  echo "已经存在$DIR_PhantomJS目录，删除该目录"
  rm -rf $DIR_PhantomJS
fi
echo "解压phantomjs安装包"
  tar -xjf $TARFILE_PhantomJS -C . || printAndExit "解压安装包失败。请检查系统是否有tar命令。"

if [ ! -f "config.json" ];then
  echo "创建config.json文件"
  echo -e "{\n  \"username\":\"$username\",\n  \"password\":\"$passwd\"\n}" > config.json
  chmod a+w config.json
else
  echo "config.json已经存在，不再创建"
fi

echo "用cron设置定时执行认证上网"
echo -e "# 功能：定时调用login.sh进行计算所科研楼web认证上线\n# 备注：解安装时建议用uninstall.sh删除本文件\n# 作者：furrybear(bearcubhaha@gmial.com)\n*/10 * * * * $(whoami) bash $DIR/login-log.sh" |sudo tee /etc/cron.d/web-auth-ictcas

echo "安装完成！"
