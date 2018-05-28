# 中科院计算所定时web认证脚本（web-auth-ictcas）

## 功能

　　由于中科院计算所科研楼实验室的网经常莫名其妙断掉，造成一些麻烦，比如与跳板机断开连接。

　　这个脚本可以定时进行web认证，防止长时间断网。

## 环境

　　仅在Ubuntu16.04上和Ubuntu16.04的docker-ce上测试过。

## 使用

### 主要

#### 如果你的操作系统是Ubuntu16.04

　　执行`bash install.sh <用户名> <密码>`，便会安装需要的依赖、设置cron定时执行web认证。install.sh可以多次执行，没有其他影响（如果用户名密码输错了也没有关系，可以在生成的config.json里修改用户名密码；如果安装失败了，可以执行`bash uninstall.sh`解安装；可以通过log/login.log查看日志，每十分钟生成一条日志）。

#### 如果你的系统安装有docker

　　执行`bash docker-build-and-run.sh <用户名> <密码>`，可以生成镜像和并运行对应容器。容器会定时进行登录。

　　执行`docker exec -it web-auth-ictcas /bin/bash`来进入容器查看日志。

　　执行`docker rm -f web-auth-ictcas`来删除容器。

　　执行`docker run --name web-auth-ictcas --restart always -d web-auth-ictcas <用户名> <密码>`来启动容器。

（网络问题，做成的镜像推不到Docker Hub上……）

#### 以上操作都需要在联网状态下执行

　　以上操作都需要联网下载安装一些依赖（phantomjs和libfontconfig1）。

　　如果没联网，请先用[w3m](https://pkgs.org/download/w3m)等浏览器访问`http://159.226.39.22/srun_portal_pc.php?ac_id=1`进行手工认证。

　　因为实验室有免费ipv6，所以应该可以这样获得w3m：

```
sudo apt-get -o Acquire::ForceIPv6=true update
sudo apt-get -o Acquire::ForceIPv6=true install -y w3m w3m-img
```

### 其他

　　执行`bash uninstall.sh`，可以解除安装（删除libfontconfig1、删除/etc/cron.d/web-auth-ictcas）。

　　执行`bash login.sh`，可以进行一次登陆。

　　执行`bash login-log.sh`，可以调用login.sh进行单次登录并记录一条日志到log/login.log。

　　执行`bash logout.sh`，可以进行一次下线。如果config.json里的用户名密码是正确的，会造成该账号登录的所有IP下线，否则只有本IP下线。

## 原理

　　login.sh会用phantomjs执行login.js进行登陆。logout.sh会用phantomjs执行logout.js进行下线。

　　登陆原理是用phantomjs在<http://159.226.39.22/srun_portal_pc.php?ac_id=1&>填写表单，然后点击登陆按钮。

　　install.sh会用apt安装libfontconfig1，用wget下载phantomjs-2.1.1-linux-x86_64，并写`*/10 * * * * * bash <脚本所在目录>/login-log.sh`到/etc/cron.d/web-auth-ictcas，让cron每10分钟调用一次login-log.sh。

注：在Ubuntu16.04下使用apt安装的phantomjs不能使用，有bug。

## 联系

　　furrybear(lfbll@outlook.com) 

　　2018-04-28
