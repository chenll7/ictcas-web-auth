#!/bin/sh
#-----------------------------------------
#功能：在计算所科研楼的web认证页进行下线操作
#返回：没有进行任何操作返回99，成功操作返回100，是失败操作返回101
#作者：furrybear(bearcubhaha@gmail.com)
#修改时间：2018.04.28
#-----------------------------------------

#本文件所在目录
DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR

export PATH="$DIR/phantomjs-2.1.1-linux-x86_64/bin:$PATH"

checkAccess () {
	echo "检查是否联网……"
	ping -c 3 www.baidu.com >/dev/null 2>&1
	return $?
}

run () {
	checkAccess
	if [ $? != 0 ]
	then
		echo "没有联网哦"
		return 99
	else
		echo "联网中，进行下线操作"	
		for i in $(seq 0 3)
		do
			echo "用pantomjs进行下线操作"
			echo "------------------"
			timeout -s 2 10 phantomjs --ignore-ssl-errors=true $DIR/logout.js
			echo "------------------"
			echo "下线操作完毕"
			checkAccess
			if [ $? != 0 ]
			then
				echo "已经下线了"
				return 100
			else
				echo "还是没有下线"
			fi
		done
		echo "多次尝试下线但是下线失败"
	        return 101
	fi
}

echo "进行下线操作"
run
OUT=$?
echo "认证联网脚本结束"
echo "返回值为$OUT"
exit $OUT
