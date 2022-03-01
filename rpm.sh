#!/bin/bash
set -ev

sudo -i
groupadd builder
useradd -G wheel -g builder builder
yum install redhat-lsb-core -y
yum install wget -y
yum install rpmdevtools -y
yum install rpm-build -y
yum install createrepo -y
yum install yum-utils -y
yum install mc -y
yum groupinstall 'Development Tools' -y


wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm

sudo rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

wget --no-check-certificate https://www.openssl.org/source/openssl-3.0.1.tar.gz

sudo tar -xvf openssl-3.0.1.tar.gz 

sudo chmod 777 /root/rpmbuild/SPECS/nginx.spec

sudo yum-builddep /root/rpmbuild/SPECS/nginx.spec -y

sudo rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec

sudo yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm

sudo systemctl start nginx

systemctl status nginx

sudo mkdir /usr/share/nginx/html/repo

cd /usr/share/nginx/html/repo

sudo cp /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/

sudo wget https://downloads.percona.com/downloads/percona-release/percona-release-0.1-6/redhat/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm

sudo createrepo /usr/share/nginx/html/repo/

sudo rm -Rf /etc/nginx/conf.d/default.conf

sudo wget https://raw.githubusercontent.com/Ascalonking/file/main/default.conf -O /etc/nginx/conf.d/default.conf

sudo nginx -t

sudo nginx -s reload

curl -a http://localhost/repo/

sudo wget https://raw.githubusercontent.com/Ascalonking/file/main/otus.repo -O /etc/yum.repos.d/otus.repo

sudo yum repolist enabled | grep otus

sudo yum install percona-release -y
