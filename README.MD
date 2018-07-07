# 中科院计算所定时web认证程序（web-auth-ictcas）

## 功能

　　由于中科院计算所科研楼实验室的网经常莫名其妙断掉，造成一些麻烦，比如与跳板机断开连接。

　　这个程序可以定时进行web认证，防止长时间不使用断网。

## 环境

　　仅在Ubuntu16.04的docker-ce上测试过。

## 运行

　　到<https://github.com/furrybear/web-auth-ictcas/releases>下载web-auth-ictcas-release.tar.gz。然后根据里面README.MD加载镜像和运行容器就可以了：

```sh
bash load.sh && bash run.sh
```

## 说明

　　这个仓库是docker镜像的Dockerfile。

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

## 联系

　　furrybear(lfbll@outlook.com)

　　2018-04-28
