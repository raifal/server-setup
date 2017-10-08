source ../secrets/docker.env
export $(cut -d= -f1 ../secrets/docker.env)

sudo docker stop rf_apache_httpd
sudo docker rm -v rf_apache_httpd
sudo docker rmi rf_apache_httpd

sudo docker network rm rf_network
sudo docker network inspect rf_network
sudo docker network create rf_network

sudo docker build --build-arg apache_httpd_passwd_user=${apache_httpd_passwd_user} --build-arg apache_httpd_passwd_password=${apache_httpd_passwd_password} -t rf_apache_httpd  apache_httpd/.

sudo docker run --restart='always' -d --name=rf_apache_httpd -p 80:80 -p 443:443 rf_apache_httpd
sudo docker network connect rf_network rf_apache_httpd


# sudo docker run -it --rm --link rf_jenkins_master --name=rf_apache_httpd -p 80:80 -p 443:443 rf_apache_httpd /bin/bash
# apachectl -DFOREGROUND &
