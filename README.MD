# 中科院计算所定时web认证脚本（web-auth-ictcas）

## 功能

　　由于中科院计算所科研楼实验室的网经常莫名其妙断掉，造成一些麻烦，比如与跳板机断开连接。

　　这个脚本可以定时进行web认证，防止长时间断网。

## 环境

　　仅在Ubuntu16.04上测试过，其他环境请自行阅读脚本并修改。环境需要安装cron，支持命令apt-get、wget和tar。

## 使用

### 主要

　　在config.json中配置好用户名密码。

　　执行`sudo bash install.sh`，可以安装需要的依赖、设置cron定时执行web认证。install.sh可以多次执行，没有其他影响。

### 其他

　　执行`sudo bash uninstall.sh`，可以解除安装。

　　执行`bash login.sh`，可以进行单次登陆。

　　执行`bash login-log.sh`，可以调用login.sh进行单次登录并记录一条日志到login.log。

　　执行`bash logout.sh`，可以进行单次下线。

　　[如何查看日志](https://blog.csdn.net/u014221090/article/details/53835969)

## 原理

　　login.sh会用phantomjs执行login.js进行登陆。logout.sh会用phantomjs执行logout.js进行下线。

　　登陆原理是用phantomjs在<http://159.226.39.22/srun_portal_pc.php?ac_id=1&>填写表单，然后点击登陆按钮。

　　install.sh会用apt安装libfontconfig1，用wget下载phantomjs-2.1.1-linux-x86_64，并写`*/10 * * * * * bash <脚本所在目录>/login-log.sh`到/etc/cron.d/web-auth-ictcas，让cron每10分钟调用一次login-log.sh。

注：在Ubuntu16.04下使用apt安装的phantomjs不能使用，有bug。

## 联系

　　furrybear(bearcubhaha@gmail) 

　　2018-04-28
