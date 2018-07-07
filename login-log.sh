#!/bin/sh
#-------------------------
#功能：调用login.sh并向login.log写日志。
#作者：furrybear(bearcbhaha@gmail.com)
#修改日期：2018-05-02
#-------------------------
#本文件所在目录

source tools/log.sh

#执行登录操作
bash login.sh
#检查结果并记录日志
out=$?
if [ $out == 99 ];then
    writeToLog login  "已经联网，没有进行任何操作。"
elif [ $out == 100 ];then
    writeToLog login "认证成功，已经联网。"
elif [ $out == 101 ];then
    writeToLog login echo "认证失败，仍未联网。可能错误原因:（1）config.json设置错误（2）该账号在线IP数达到上限，建议前往“https://gw.ict.ac.cn:8900/”查看或者执行bash logout.sh强迫其他IP下线。"
fi
