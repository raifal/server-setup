source ../secrets/secrets.env
export $(cut -d= -f1 ../secrets/secrets.env)

# backup
sudo rm mydump.sql
sudo docker exec -t hsm-database  pg_dumpall -c -U postgres > mydump.sql

sudo docker stop hsm-database
sudo docker rm -v hsm-database

sudo docker run --name hsm-database -e POSTGRES_PASSWORD=${postgres_password} -d postgres:10.0
sudo docker network connect rf_network hsm-database

#restore
#cat .\mydump.sql | docker exec -i hsm-database psql -U postgres

# init data
#cat .\init.sql | docker exec -i hsm-database psql -U postgres

# command line
#docker run -it --rm --link hsm-database:postgres postgres psql -h postgres -U postgres
