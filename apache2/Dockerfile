# Serveur apache
FROM debian:latest

LABEL maintainer "Guilherme Castro <guicastro@gmail.com>"

RUN echo 'deb http://ftp.br.debian.org/debian/ jessie non-free' >> /etc/apt/sources.list
RUN echo 'deb-src http://ftp.br.debian.org/debian/ jessie non-free' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install apache2 libapache2-mod-fastcgi

RUN rm /etc/apache2/sites-enabled/*

ADD conf-available /etc/apache2/conf-available
ADD sites-available /etc/apache2/sites-available

EXPOSE 80
EXPOSE 8080

ADD apache.sh /usr/bin/apache.sh
RUN chmod +x /usr/bin/apache.sh
ENTRYPOINT apache.sh

VOLUME /var/www

WORKDIR /var/www
