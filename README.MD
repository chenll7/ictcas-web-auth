# 中科院计算所定时web认证程序（Web Auth ICTCAS）

## 功能

　　中科院计算所科研楼定时web认证程序，防止长时间不使用断网。

## 环境

　　需要预先安装Docker（建议先在能上网的机器上用SSR或者SS搭建http代理，然后利用代理安装上Docker先）。

## 运行

　　到<https://github.com/furrybear/web-auth-ictcas/releases>下载web-auth-ictcas-release.tar.gz。在run.sh里添加用户名和密码，然后加载镜像和运行容器就可以了：

```sh
bash load.sh && bash run.sh
```

## 另一种运行方式

将项目克隆下来，进入目录：

```sh
git clone https://github.com/furrybear/web-auth-ictcas.git
cd web-auth-ictcas
```

构建镜像的命令：

```sh
docker build -t furrybear/web-auth-ictcas .
```

运行容器的命令：

```sh
docker run -d \
 --user $(id -u) \
 -e USERNAME="<你的上网账号用户名>" \
 -e PASSWD="<你的上网账号密码>" \
 -v <存放日志的目录>:/log \
 --restart always \
 --name furrybear/web-auth-ictcas web-auth-ictcas
```

## 原理

　　login.sh会用phantomjs执行login.js进行登录。logout.sh会用phantomjs执行logout.js进行注销。

　　登陆原理是用phantomjs在<http://159.226.39.22/srun_portal_pc.php?ac_id=1&>填写表单，然后点击登陆按钮。

## 备注

　　写这东西的时候我还不知道docker-compose，使用docker-compose管理容器会更方便。但是我不想维护了。

## 联系

　　Furrybear(fbcll@outlook.com)

　　2019-01-13
