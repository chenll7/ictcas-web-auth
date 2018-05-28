#!/bin/sh
#-----------------------------------------
#功能：调用“phantomjs login.js”来进行登录操作
#返回：没有进行任何操作返回99，进行认证并成功联网返回100，进行认证但是没有成功联网返回101
#-----------------------------------------

#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR

export PATH="$DIR/phantomjs-2.1.1-linux-x86_64/bin:$PATH"

checkAccess () {
  echo "检查是否联网"
  ping -c 2 www.baidu.com >/dev/null 2>&1
  return $?
}
run () {
  checkAccess
  if [ $? -eq 0 ];then
    echo "已经联网了"
    return 99
  else
    echo "惊恐！没有联网！"		
    for i in $(seq 0 0)
    do
      echo "进行登录操作"
      echo "------------------"
      timeout -s 2 10 phantomjs --ignore-ssl-errors=true $DIR/login.js
      echo "------------------"
      echo "登录操作完毕"
      checkAccess
      if [ $? -eq 0 ]
      then
        echo "已经联网了"
        return 100
      else
        echo "还是没有联网"
      fi
    done
    echo "多次尝试联网但是联网失败。可能错误原因:（1）config.json设置错误（2）该账号在线IP数达到上限，建议前往“https://gw.ict.ac.cn:8900/”查看或者执行bash logout.sh强迫其他IP下线。"
    return 101
  fi
}

echo "进行web认证上网操作"
run
OUT=$?
echo "认证联网脚本结束"
echo "返回值为$OUT"
exit $OUT
