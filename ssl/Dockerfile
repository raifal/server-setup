FROM openjdk:8

ARG ssl_storepass

# Create SSL certificates
# RUN mkdir -p /etc/ssl/private
# RUN mkdir -p /etc/ssl/certs
RUN openssl req -new -x509 -days 99999 -sha1 -newkey rsa:1024 -nodes -keyout /etc/ssl/private/ss_server.key -out /etc/ssl/certs/ss_server.crt -subj '/O=raifal/OU=raifal/CN=raifal'
RUN keytool -import -storepass ${ssl_storepass} -noprompt -alias myalias -keystore /hsm.keystore -trustcacerts -file /etc/ssl/certs/ss_server.crt

