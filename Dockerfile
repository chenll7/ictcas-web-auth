From ubuntu:16.04
Maintainer furrybear fbcll@outlook.com

ENV DEBIAN_FRONTEND noninteractive

#安装依赖
RUN apt-get update \
 && apt-get install -y sudo wget tar bzip2 inetutils-ping libfontconfig1 \
 && rm -rf /var/lib/apt/lists/* \
 && apt clean

#安装phantomjs
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xjvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && rm phantomjs-2.1.1-linux-x86_64.tar.bz2
ENV PATH $PATH:/phantomjs-2.1.1-linux-x86_64/bin

#把代码拷进来
COPY [".","/web-auth-ictcas"]
ENV PATH $PATH:/web-auth-ictcas
WORKDIR /web-auth-ictcas
