#Version 1.0.1
FROM centos:7

MAINTAINER Kevin_Gu "gubaijing2004@163.com"

#设置工作目录
WORKDIR /root/

RUN yum install -y mysql-server mysql  
   
RUN /etc/init.d/mysqld start &&\  
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'letmein';"&&\  
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'letmein';"&&\  
    mysql -u root -pletmein -e "show databases;"  

#创建一个数据库
RUN mysql_install_db --user=root  --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data &

#创建用户名密码
ENV MYSQL_USER gplucky
ENV MYSQL_PASS gplucky

#让容器支持中文
ENV LC_ALL en_US.UTF-8
   
EXPOSE 3306  
   
CMD ["/usr/bin/mysqld_safe"]  
