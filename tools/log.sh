#!/bin/bash
#写日志的函数：第一个参数是文件名前缀，第二个参数是一条日志内容
writeToLog(){
    if [ ! -d /log ];then mkdir /log;fi
    # 日志文件超过一定大小删除
    if [ -f /log/$1.log ];then
        if [ $(ls -l /log/$1.log|awk '{print $5}') -gt 1000000 ];then
            rm /log/$1.log
        fi
    fi
    echo $(date) >> /log/$1.log
    echo $2 >> /log/$1.log
}

