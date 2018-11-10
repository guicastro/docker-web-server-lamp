# Web Server Docker Container Apache/Multi PHP/MySQL for Mac
This is a Docker Container compatible with macOS to up a webserver with:
- Apache 2 (latest) on debian
- PHP 5.6 using FPM (latest release)
- PHP 7.1 using FPM (latest release)
- MySQL 5.7 (latest release)

## YML Files and Instructions

### **docker-compose-mysql57.yml**
Single container with MySQL 5.7 (latest release). 

This container has a network called web-server. Don't forget to setup the MySQL root password in MYSQL_ROOT_PASSWORD enviroment variable. There is an option to create additional user, without root privileges, you can define this on variables MYSQL_USER and MYSQL_PASSWORD enviroment variables. 

You can connect in your own host to MySQL using default port **3306** and **localhost** hostname. To connect from Apache Web Server container you need to use **mysql57** hostname to connect in MySQL Server. 

All data files will be saved on mysql57/data folder and all logs in logs/mysql57. You can customize MySQL configuration file on mysql57/etc/my.cnf. This example sets the SQL_MODE to NO_ENGINE_SUBSTITUTION only, like older MySQL versions.

### **docker-compose.yml**
This file contain all you need to setup and customize your webserver using Apache 2.4.37, PHP 5.6.38 and PHP 7.1.23 (default).

With this container you can use both PHP versions, **5.6 on 8080** port and **7.1 on default port (80)**. Customize the PHP libraries on Dockerfile of php56 ou php71 folders. You can setup PHP INI using php56.ini and php71.ini files on their respective folders.

Don't forget to setup your Document Root folder on Volumes mapping.

When you setup first time, all libraries will be downloaded, scripts enable and recompile PHP. This process has many steps and may take few minutes. Some errors may be showed, but all resouces and libraries will be works fine.

All Apache configuration (default configuration and vhosts) are in apache2 folder. Master configuration are in apache2/conf-available/apache2.conf and vhosts are in apache2/sites-available. 

To add more libraries in Apache, you need to edit Dockerfile on apache2 folder. To enable/disable Apache modules, configurations or sites, you can user a2enmod, a2enconf and a2ensite in apache2/apache.sh script.

All Apache logs, including Access Log, Apache or PHP errors will be saved in logs/apache2 folder.

## **Step by Step to up**
1. Download/pull this container and enter on root folder
2. Run docker-composer -f docker-compose-mysql57.yml up -d to up MySQL Container
3. Run docker-composer up -d to up Web Server
4. Access your server using http://localhost to PHP 7.1 and http://localhost:8080 to PHP 5.6