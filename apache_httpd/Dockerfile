# https://github.com/BisnodeInformatics/docker-reverse-proxy 

FROM debian:jessie

ARG apache_httpd_passwd_user
ARG apache_httpd_passwd_password
ARG arduino_interface_passwd_user
ARG arduino_interface_passwd_password

# install apache 2
RUN apt-get update && apt-get install -y apache2

# Create SSL certificates
# RUN mkdir -p /etc/ssl/private
# RUN mkdir -p /etc/ssl/certs
RUN openssl req -new -x509 -days 99999 -sha1 -newkey rsa:1024 -nodes -keyout /etc/ssl/private/ss_server.key -out /etc/ssl/certs/ss_server.crt -subj '/O=Rainer.Faller/OU=Rainer.Faller/CN=Rainer.Faller'

# install needded modules
RUN a2enmod ssl proxy proxy proxy_balancer proxy_http headers status rewrite proxy_html xml2enc

# add user to passwd for basic authentication
RUN mkdir -p /var/www/passwd
RUN htpasswd -b -c /var/www/passwd/passwords ${apache_httpd_passwd_user} ${apache_httpd_passwd_password}
RUN htpasswd -b -c /var/www/passwd/passwords_arduino_interface ${arduino_interface_passwd_user} ${arduino_interface_passwd_password}

# config for forcing redirect to https
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

# run apache in foreground
CMD ["apachectl", "-DFOREGROUND"]
