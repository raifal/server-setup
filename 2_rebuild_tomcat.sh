source ../secrets/docker.env
export $(cut -d= -f1 ../secrets/docker.env)

sudo docker stop hsm-server
sudo docker rm -v hsm-server

sudo docker run -d --name=hsm-server tomcat:8.0
sudo docker network connect rf_network hsm-server

