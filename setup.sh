#!/usr/bin/env bash

debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password devuser"
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password devuser"

sudo apt update
sudo apt -y upgrade

echo 'install nginx'
sudo apt -y install nginx
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

echo 'install mysql server'
sudo apt install mysql-server

sudo cp ./conf/mysql/my.cnf /etc/mysql/conf.d/

sudo service mysql restart
sudo service mysql enable

wget https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz
tar -xvzf mysql-connector-java-5.1.48.tar.gz

echo 'install jira software'
wget https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-8.7.1-x64.bin
chmod a+x ./atlassian-jira-software-8.7.1-x64.bin
sudo ./atlassian-jira-software-8.7.1-x64.bin
sudo cp ./mysql-connector-java-5.1.48/my* /opt/atlassian/jira/lib/

sudo rm /etc/init.d/jira
sudo cp ./conf/jira/server.xml /opt/atlassian/jira/conf/
sudo cp ./conf/jira/jira.service /etc/systemd/system/

echo 'install bitbucket'
wget https://product-downloads.atlassian.com/software/stash/downloads/atlassian-bitbucket-6.10.1-x64.bin
chmod a+x atlassian-bitbucket-6.10.1-x64.bin
sudo ./atlassian-bitbucket-6.10.1-x64.bin
sudo cp ./mysql-connector-java-5.1.48/my* /var/atlassian/application-data/bitbucket/lib/

sudo cp ./conf/bitbucket/bitbucket.properties /var/atlassian/application-data/bitbucket/shared/bitbucket.properties

echo 'copy nginx conf'
sudo cp ./conf/bitbucket/bitbucket.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/bitbucket.conf /etc/nginx/sites-enabled/

sudo cp ./conf/jira/jira.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jira.conf /etc/nginx/sites-enabled/jira.conf

sudo apt update
sudo apt -y upgrade
