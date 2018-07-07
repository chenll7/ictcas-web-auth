#!/bin/bash
source tools/log.sh

if [ -z $USERNAME ];then
    writeToLog error "没有设置登录用户名！"
    sleep infinity
fi
if [ -z $PASSWD ];then
    writeToLog error "没有设置登录密码！"
    sleep infinity
fi

while true;do
    bash login-log.sh
    sleep 60s
done
