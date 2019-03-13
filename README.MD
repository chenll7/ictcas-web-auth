# 中科院计算所定时web认证脚本（ICTCAS WEB AUTH）

## 功能

　　中科院计算所科研楼定时web认证程序，防止长时间不使用断网。

## 环境

　　Ubuntu，需要预先安装phantomjs和libfontconfig1（建议先在能上网的机器上用SSR或者SS搭建http代理，然后利用代理下载[phantomjs](http://phantomjs.org/download.html)和安装libfontconfig1（`apt install libfontconfig1`））。

## 运行

登录：`./login.sh -u <用户名> -p <密码>`
注销：`./logout.sh -u <用户名> -p <密码>`
保持登录：`./login.sh -u <用户名> -p <密码> --interval`
保持登录（发现在线IP满了就强行注销再登录）：`./login.sh -u <用户名> -p <密码> --interval --force`


## 原理

　　login.sh会用phantomjs执行login.js进行登录。logout.sh会用phantomjs执行logout.js进行注销。

　　登陆原理是用phantomjs在<http://159.226.39.22/srun_portal_pc.php?ac_id=1&>填写表单，然后点击登陆按钮。

　　2019-03-13
