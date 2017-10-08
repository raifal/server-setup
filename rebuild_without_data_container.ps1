$lines = Get-Content ..\secrets\docker.env
foreach ($line in $lines) {
    $a,$b = $line.split('=')
    Set-Variable $a $b
}

docker stop rf_apache_httpd
docker rm -v rf_apache_httpd
docker rmi rf_apache_httpd

docker network rm rf_network
docker network inspect rf_network
docker network create rf_network

docker build --build-arg apache_httpd_passwd_user=${apache_httpd_passwd_user} --build-arg apache_httpd_passwd_password=${apache_httpd_passwd_password} -t rf_apache_httpd  apache_httpd/.

docker run --restart='always' -d --name=rf_apache_httpd -p 80:80 -p 443:443 rf_apache_httpd
docker network connect rf_network rf_apache_httpd


