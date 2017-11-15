source ../secrets/secrets.env
export $(cut -d= -f1 ../secrets/secrets.env)

mkdir ./apache_httpd/ssl_generated

sudo docker stop temp-ssl
sudo docker rm -v temp-ssl

sudo docker build  --build-arg ssl_storepass=${ssl_storepass} -t temp-ssl  ssl/.
sudo docker run --name=temp-ssl temp-ssl

sudo docker cp temp-ssl:/etc/ssl/private/ss_server.key ./apache_httpd/ssl_generated/.
sudo docker cp temp-ssl:/etc/ssl/certs/ss_server.crt ./apache_httpd/ssl_generated/.
sudo docker cp temp-ssl:/hsm.keystore ./apache_httpd/ssl_generated/.

sudo docker stop temp-ssl
sudo docker rm -v temp-ssl