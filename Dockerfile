#Version 1.0.1
FROM mysql:latest

MAINTAINER Kevin_Gu "gubaijing2004@163.com"

#设置工作目录
WORKDIR /home/workdir/mysql

service mysqld start

mysqladmin -u gplucky password gplucky

#让容器支持中文
ENV LC_ALL en_US.UTF-8

#对外暴露端口
EXPOSE 3306

#默认启动行为
RUN #!/bin/bash
RUN mysql_safe
