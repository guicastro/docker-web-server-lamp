# Serveur apache
FROM debian:latest

LABEL maintainer "Guilherme Castro <guicastro@gmail.com>"

#Add Debian jessie APT repository
RUN echo 'deb http://ftp.br.debian.org/debian/ jessie non-free' >> /etc/apt/sources.list
RUN echo 'deb-src http://ftp.br.debian.org/debian/ jessie non-free' >> /etc/apt/sources.list


#Update APT repository
RUN apt-get update

#Install Apache and dependencies
RUN apt-get -y install apache2 libapache2-mod-fastcgi tzdata logrotate nano

# Set up your timezone
RUN rm /etc/timezone
RUN cp /usr/share/zoneinfo/America/Cuiaba /etc/localtime
RUN echo "America/Cuiaba" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

#Remove all default Apache Conf
RUN rm /etc/apache2/sites-enabled/*

#Copy conf files
ADD conf-available /etc/apache2/conf-available
ADD sites-available /etc/apache2/sites-available

#Expose ports
EXPOSE 80
EXPOSE 8080

#Add and configure permissions to run Apache endscript
ADD apache.sh /usr/bin/apache.sh
RUN chmod +x /usr/bin/apache.sh

#Delete temporary files
RUN rm -rf /var/lib/apt/lists/*

#Run Apache endscript
ENTRYPOINT apache.sh

VOLUME /var/www

WORKDIR /var/www