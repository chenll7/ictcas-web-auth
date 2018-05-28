#!/bin/sh
#-----------------------------------------
#功能：注销操作，会造成所有用这个账号登录的IP下线
#返回：0
#-----------------------------------------

#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR

export PATH="$DIR/phantomjs-2.1.1-linux-x86_64/bin:$PATH"

run () {
  echo "进行注销操作"
  echo "------------------"
  timeout -s 2 10 phantomjs --ignore-ssl-errors=true $DIR/logout.js
  echo "------------------"
  echo "注销操作完毕"
}

run
exit 0
