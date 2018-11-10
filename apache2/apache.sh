#! /bin/bash

a2enmod proxy
a2enmod proxy_fcgi
a2enmod rewrite
a2enconf apache2
a2ensite php56
a2ensite php71

/usr/sbin/apache2ctl -D FOREGROUND
