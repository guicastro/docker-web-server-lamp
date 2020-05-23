FROM php:7.2-fpm

LABEL maintainer "Guilherme Castro <guicastro@gmail.com>"

#Update APT repository
RUN apt-get update

# Download and unzip Oracle Instant Client (from Caffeina Lab Repo)
RUN apt-get -y install wget bsdtar libaio1 unzip && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip | bsdtar -xvf-  -C /usr/local && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local && \
 ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
 ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so && \
 ln -s /usr/local/instantclient/lib* /usr/lib && \
 ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

# Set environment variables for Oracle Instant Client and MS SQL Server Driver
ENV LD_LIBRARY_PATH /usr/lib/oracle/18.3/client64/lib
ENV ORACLE_HOME /usr/lib/oracle/18.3/client64/lib
ENV ACCEPT_EULA=Y
ENV SERVER_TYPE=LOCAL

#Install main libraries
RUN apt-get install -y apt-transport-https gnupg zlib1g-dev libicu-dev libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev unixodbc-dev libpq-dev tzdata locales

#Download Microsoft SQL Server Driver for PHP
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && apt-get -y --no-install-recommends install msodbcsql17

#Configure PHP Extensions
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

#Install MS SQL Server extension
RUN pecl install sqlsrv pdo_sqlsrv mcrypt-1.0.1

#Configure and Compile Oracle Instant Client for PHP, with OCI8 and PDO
RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient
RUN docker-php-ext-configure pdo_oci --with-pdo_oci=instantclient,/usr/local/instantclient,12.1

#Install all PDO drivers for PHP and other extensions
RUN docker-php-ext-install mbstring pdo oci8 mysqli pdo_mysql pdo_pgsql pdo_oci zip exif

#Enable Oracle Instant Client and MS SQL Server extension for PHP
RUN docker-php-ext-enable oci8 sqlsrv pdo_sqlsrv mcrypt
   
#Copy PHP.INI conf
ADD php7.ini /usr/local/etc/php/conf.d/php.ini

# Set the locale
RUN locale-gen pt_BR.utf8
RUN update-locale pt_BR.utf8

# Set up your timezone
RUN rm /etc/timezone
RUN cp /usr/share/zoneinfo/America/Cuiaba /etc/localtime
RUN echo "America/Cuiaba" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

#Delete temporary files
RUN rm -rf /var/lib/apt/lists/*

#Run php-fpm
ENTRYPOINT php-fpm --nodaemonize

#Get and Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && rm composer-setup.php && mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1

#Set workdir as /var/www
VOLUME /var/www
WORKDIR /var/www

