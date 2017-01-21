#Version 1.0.1
FROM centos:7

MAINTAINER Kevin_Gu "gubaijing2004@163.com"

#设置工作目录
WORKDIR /root/

#安装mysql
RUN yum -y install mysql-server mysql-devel mysql

RUN yum -y install wget
RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN rpm -ivh mysql-community-release-el7-5.noarch.rpm

#
RUN yum -y install mysql-server

#创建一个数据库
RUN mysql_install_db --user=root  --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data &

#创建用户名密码
ENV MYSQL_USER gplucky
ENV MYSQL_PASS gplucky

#让容器支持中文
ENV LC_ALL en_US.UTF-8

RUN /etc/init.d/mysql start \
    && mysql -uroot -e "grant all privileges on *.* to 'root'@'%' identified by '1';" \
    && mysql -uroot -e "grant all privileges on *.* to 'root'@'localhost' identified by '1';" 

RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
    && echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
    && mv /tmp/my.cnf /etc/mysql/my.cnf

EXPOSE 3306  
CMD ["/usr/bin/mysqld_safe"]
