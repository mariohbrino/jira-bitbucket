# Ubuntu server with Jira Software and Bitbucket
This script will install nginx, mysql server, download jira/bitbucket and start the install. Also it will add/change some config files for nginx, mysql, jira and bitbucket.

Guide to install jira software self-host
```bash
https://confluence.atlassian.com/adminjiraserver/installing-jira-applications-on-linux-from-archive-file-938846844.html
```

Guide to install bitbucket self-host
```bash
https://confluence.atlassian.com/bitbucketserver/install-bitbucket-server-on-linux-from-an-archive-file-868977010.html
```

Clone this repo and execute the `setup.sh` file, and follow the instructions to install
```
cd atlassian
sudo ./setup.sh
```

Create database and user for jira and bitbucket
```bash
CREATE DATABASE jira CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES on jira.* TO 'jira'@'localhost' IDENTIFIED BY 'devuser';

CREATE DATABASE bitbucket CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES on bitbucket.* TO 'bitbucket'@'localhost' IDENTIFIED BY 'devuser';

flush privileges;
```

Commands that you may need to use
```bash
sudo systemctl enable jira
sudo systemctl start jira
sudo systemctl restart jira

sudo service atlbitbucket enable
sudo service atlbitbucket start
sudo service atlbitbucket restart

sudo service nginx start
sudo service nginx restart
```