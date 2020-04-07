#!/usr/bin/env bash
echo "Starting update"
yum -y update 

echo "Finished update, adding epel, docker-ce, mysql-community-release repositories and installing wget and yum-utils"
yum -y install epel-release wget yum-utils
yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum-config-manager --disable mysql56-community
yum-config-manager --enable mysql57-community-dmr
yum -y update

echo "Added docker-ce repo, starting docker install"
yum -y install docker-ce docker-ce-cli containerd.io

echo "Finished docker install, enabling and starting docker service"
systemctl enable docker
service docker start

echo "Installing MySQL"
yum -y install mysql-community-server
systemctl start mysqld
mysql -u root -e 'create database picsure'
mysql -u root -e 'create database auth'

echo "Building and installing Jenkins"
docker build -t pic-sure-jenkins:`git log -n 1 | grep commit | cut -d ' ' -f 2 | cut -c 1-7` jenkins/jenkins-docker
docker tag pic-sure-jenkins:`git log -n 1 | grep commit | cut -d ' ' -f 2 | cut -c 1-7` pic-sure-jenkins:LATEST
echo "Creating Jenkins Log Path"
mkdir -p /var/log/jenkins-docker-logs
mkdir -p /var/jenkins_home
cp -r jenkins/jenkins-docker/jobs /var/jenkins_home/jobs

mkdir -p /usr/local/docker-config

