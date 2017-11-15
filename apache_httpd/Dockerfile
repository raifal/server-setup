# https://github.com/BisnodeInformatics/docker-reverse-proxy 

FROM debian:jessie

ARG apache_httpd_passwd_user
ARG apache_httpd_passwd_password
ARG arduino_interface_passwd_user
ARG arduino_interface_passwd_password

# install apache 2
RUN apt-get update && apt-get install -y apache2

ADD ./ssl_generated/ss_server.key /etc/ssl/private/ss_server.key
ADD ./ssl_generated/ss_server.crt /etc/ssl/certs/ss_server.crt

# install needded modules
RUN a2enmod ssl proxy proxy proxy_balancer proxy_http headers status rewrite proxy_html xml2enc

# add user to passwd for basic authentication
RUN mkdir -p /var/www/passwd
RUN htpasswd -b -c /var/www/passwd/passwords ${apache_httpd_passwd_user} ${apache_httpd_passwd_password}
RUN htpasswd -b -c /var/www/passwd/passwords_arduino_interface ${arduino_interface_passwd_user} ${arduino_interface_passwd_password}

# config for forcing redirect to https
ADD ./ports.conf /etc/apache2/ports.conf
ADD ./redirect2https /etc/apache2/sites-available/redirect2https.conf
ADD ./my-ssl.conf /etc/apache2/sites-available/my-ssl.conf
ADD ./my-https.conf /etc/apache2/sites-available/my-https.conf
ADD ./arduino-endpoint.conf /etc/apache2/sites-available/arduino-endpoint.conf

RUN a2dissite 000-default
RUN a2ensite my-ssl
RUN a2ensite my-https
RUN a2ensite redirect2https
RUN a2ensite arduino-endpoint

# add volumes for logs and ssl
VOLUME [ "/var/log/apache2" ]

# expose http and https ports
EXPOSE 80 
EXPOSE 443
EXPOSE 7071

# run apache in foreground
CMD ["apachectl", "-DFOREGROUND"]
