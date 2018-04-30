#!/bin/sh
#-----------------------------------------
#功能：调用“phantomjs login.js”来对计算所的网进行web认证从而连上外网
#返回：没有进行任何操作返回99，进行认证并成功联网返回100，进行认证但是没有成功联网返回101
#作者：furrybear(bearcubhaha@gmail.com)
#修改时间：2018.04.28
#-----------------------------------------

#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR

export PATH="$DIR/phantomjs-2.1.1-linux-x86_64/bin:$PATH"

checkAccess () {
	echo "检查是否联网"
	ping -c 3 www.baidu.com >/dev/null 2>&1
	return $?
}
run () {
	checkAccess
	if [ $? -eq 0 ]
	then
		echo "已经联网了"
		return 99
	else
		echo "惊恐！没有联网！"		
		for i in $(seq 0 3)
		do
			echo "用pantomjs进行登陆操作"
			echo "------------------"
			timeout -s 2 10 phantomjs --ignore-ssl-errors=true $DIR/login.js
			echo "------------------"
			echo "登陆操作完毕"
			checkAccess
			if [ $? -eq 0 ]
			then
				echo "已经联网了"
				return 100
			else
				echo "还是没有联网"
			fi
		done
		echo "多次尝试联网但是联网失败"
	        return 101
	fi
}

echo "进行web认证上网操作"
run
OUT=$?
echo "认证联网脚本结束"
echo "返回值为$OUT"
exit $OUT
