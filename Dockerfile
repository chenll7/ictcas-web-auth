From registry.docker-cn.com/library/ubuntu:16.04
Maintainer furrybear bearcubhaha@gmail.com
COPY [".","/web-auth-ictcas"]
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y sudo wget tar bzip2 inetutils-ping && \
    apt-get install -y --no-install-recommends cron
RUN bash /web-auth-ictcas/install.sh
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get clean
ENTRYPOINT ["bash","/web-auth-ictcas/docker-entrypoint.sh"]

