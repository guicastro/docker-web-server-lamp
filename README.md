# Web Server Docker Container Apache/Multi PHP/MySQL/Oracle/SQL Server for Mac and Windows
This is a Docker Container was tested on macOS 10.13 and Windows 10 to up a webserver with:
- Apache 2 (latest) on debian
- PHP 5.6 using FPM (latest release)
- PHP 7.2 using FPM (latest release) with drivers to work with MySQL, PostgreeSQL, Oracle Database and MS SQL Server
- MySQL 5.7 (latest release)

## YML Files and Instructions

### **docker-compose-mysql57.yml**
Single container with MySQL 5.7 (latest release). 

This container has a network called web-server. Don't forget to setup the MySQL root password in MYSQL_ROOT_PASSWORD enviroment variable. There is an option to create additional user, without root privileges, you can define this on variables MYSQL_USER and MYSQL_PASSWORD enviroment variables. 

You can connect in your own host to MySQL using default port **3306** and **localhost** hostname. To connect from Apache Web Server container you need to use **mysql57** hostname to connect in MySQL Server. 

All data files will be saved on mysql57/data folder and all logs in logs/mysql57. You can customize MySQL configuration file on mysql57/etc/my.cnf. This example sets the SQL_MODE to NO_ENGINE_SUBSTITUTION only, like older MySQL versions.

### **docker-compose.yml**
This file contain all you need to setup and customize your webserver using Apache 2.4.37, PHP 5.6.38 and PHP 7.2.XX (default).

With this container you can use both PHP versions, **5.6 on 8080** port and **7.2 on default port (80)**. Customize the PHP libraries on Dockerfile of php56 ou php7 folders. You can setup PHP INI using php56.ini and php7.ini files on their respective folders.

Don't forget to setup your Document Root folder on Volumes mapping.

When you setup first time, all libraries will be downloaded, scripts enable and recompile PHP. This process has many steps and may take few minutes. Some errors may be showed, but all resouces and libraries will be works fine.

All Apache configuration (default configuration and vhosts) are in apache2 folder. Master configuration are in apache2/conf-available/apache2.conf and vhosts are in apache2/sites-available. 

To add more libraries in Apache, you need to edit Dockerfile on apache2 folder. To enable/disable Apache modules, configurations or sites, you can user a2enmod, a2enconf and a2ensite in apache2/apache.sh script.

All Apache logs, including Access Log, Apache or PHP errors will be saved in logs/apache2 folder.

This container uses a external repo to download, install and compile the Oracle Instant Client 12.2 and PDO Drivers. Only PHP 7.2 container has all PDO drivers to work with Oracle Database (PDO and OCI8), MS SQL Server (official PHP Driver), PostgreeSQL and MySQL. Thanks Caffeina Lab for Oracle Instant Client links (https://github.com/caffeinalab/php-fpm-oci8).

This files was built in macOS environment. If you are using Windows, maybe necessary to disable EOL Git conversion or check EOL in all shell scripts (SH). In some cases, problems may occour to run shell scripts in Windows.

## **Step by Step to up container**
1. Clone this repo (https://github.com/guicastro/docker-web-server-lamp) and enter on root folder
2. Run docker-composer -f docker-compose-mysql57.yml up -d to up MySQL Container
3. Run docker-composer up -d to up Web Server
4. Access your server using http://localhost to PHP 7.2 and http://localhost:8080 to PHP 5.6
