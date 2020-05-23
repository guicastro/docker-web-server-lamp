FROM php:5.6-fpm

LABEL maintainer "Guilherme Castro <guicastro@gmail.com>"

#Update APT repository
RUN apt-get update

#Configure PHP Extensions
RUN apt-get install -y zlib1g-dev libicu-dev g++ libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev unixodbc-dev libpq-dev tzdata
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

#Install all PDO drivers for PHP and other extensions
RUN docker-php-ext-install mbstring pdo mysql mysqli pdo_mysql pdo_pgsql mcrypt zip exif

#Copy PHP.INI conf
ADD php56.ini /usr/local/etc/php/conf.d/php.ini

# Install and set the locale
RUN apt-get -y install locales
RUN locale-gen pt_BR.utf8
RUN update-locale pt_BR.utf8

RUN rm /etc/timezone
# Set up your timezone
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

#Set ENV Server Type (optional)
ENV SERVER_TYPE=LOCAL