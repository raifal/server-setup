source ../secrets/secrets.env
export $(cut -d= -f1 ../secrets/secrets.env)

sudo docker network disconnect rf_network rf_apache_httpd
sudo docker network disconnect rf_network hsm-database

# sudo docker stop hsm-database
# sudo docker rm -v hsm-database

sudo docker stop rf_apache_httpd
sudo docker rm -v rf_apache_httpd
sudo docker rmi rf_apache_httpd

sudo docker network rm rf_network
sudo docker network create rf_network

sudo docker build --build-arg apache_httpd_passwd_user=${apache_httpd_passwd_user} --build-arg apache_httpd_passwd_password=${apache_httpd_passwd_password} --build-arg arduino_interface_passwd_user=${arduino_interface_passwd_user} --build-arg arduino_interface_passwd_password=${arduino_interface_passwd_password} -t rf_apache_httpd  apache_httpd/.


sudo docker run --restart='always' -d --name=rf_apache_httpd -p 80:80 -p 443:443 -p 7071:7071 rf_apache_httpd
sudo docker network connect rf_network rf_apache_httpd

sudo docker network connect rf_network hsm-database

sudo docker cp ./apache_httpd/html rf_apache_httpd:/var/www

# sudo docker run -it --rm --link rf_jenkins_master --name=rf_apache_httpd -p 80:80 -p 443:443 rf_apache_httpd /bin/bash
# apachectl -DFOREGROUND &
