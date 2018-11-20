# Serveur apache
FROM mysql:5.7

LABEL maintainer "Guilherme Castro <guicastro@gmail.com>"

RUN echo 'deb http://ftp.br.debian.org/debian/ jessie non-free' >> /etc/apt/sources.list
RUN echo 'deb-src http://ftp.br.debian.org/debian/ jessie non-free' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install tzdata logrotate nano

RUN rm /etc/timezone
# Set up your timezone
RUN cp /usr/share/zoneinfo/America/Cuiaba /etc/localtime
RUN echo "America/Cuiaba" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

EXPOSE 3306