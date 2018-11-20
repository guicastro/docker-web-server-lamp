FROM php:7.1-fpm

LABEL maintainer "Guilherme Castro <guicastro@gmail.com>"

RUN apt-get update

RUN apt-get install -y zlib1g-dev libicu-dev g++ libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev unixodbc-dev libpq-dev tzdata
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install mbstring pdo mysqli pdo_mysql pdo_pgsql mcrypt
   
ADD php71.ini /usr/local/etc/php/conf.d/php.ini

RUN apt-get -y install locales

# Set the locale
RUN locale-gen pt_BR.utf8
RUN update-locale pt_BR.utf8

RUN rm /etc/timezone
# Set up your timezone
RUN cp /usr/share/zoneinfo/America/Cuiaba /etc/localtime
RUN echo "America/Cuiaba" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

ENTRYPOINT php-fpm --nodaemonize

VOLUME /var/www

WORKDIR /var/www

ENV SERVER_TYPE=LOCAL