#Version 1.0.1
FROM centos

MAINTAINER Kevin_Gu "gubaijing2004@163.com"

#设置工作目录
WORKDIR /home/mysql

#安装mysql
RUN yum -y install mysql-server

#创建一个数据库
RUN mysql_install_db --user=root

#创建用户名密码
ENV MYSQL_USER gplucky
ENV MYSQL_PASS gplucky

#让容器支持中文
ENV LC_ALL en_US.UTF-8

#对外暴露端口
EXPOSE 3306

#默认启动行为
RUN #!/bin/bash
RUN mysql_safe
