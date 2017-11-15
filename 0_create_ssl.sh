source ../secrets/secrets.env
export $(cut -d= -f1 ../secrets/secrets.env)

mkdir ssl_generated

docker stop temp-ssl
docker rm -v temp-ssl

docker build  --build-arg ssl_storepass=${ssl_storepass} -t temp-ssl  ssl/.
docker run --name=temp-ssl temp-ssl

docker cp temp-ssl:/etc/ssl/private/ss_server.key ./ssl_generated/.
docker cp temp-ssl:/etc/ssl/certs/ss_server.crt ./ssl_generated/.
docker cp temp-ssl:/hsm.keystore ./ssl_generated/.
