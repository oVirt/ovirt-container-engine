docker stop ovirt-postgres
docker stop ovirt-engine
#docker stop nfs
docker rm -v ovirt-postgres
docker rm -v ovirt-engine
#docker rm -v nfs
#docker run -d --name nfs --privileged -p 111 -p 2049 cpuguy83/nfs-server /mnt/
docker run --name ovirt-postgres -e POSTGRES_PASSWORD=engine -e POSTGRES_USER=engine  -p 5433:5432 -e POSTGRES_DB=engine -d rmohr/ovirt-postgres
docker run --name ovirt-engine  --link ovirt-postgres:postgres -e OVIRT_PASSWORD=engine -p 8443:8443 -d rmohr/ovirt-engine

export PGPASSWORD=engine
psql engine -h localhost -p 5433  -U engine -c "UPDATE vdc_options set option_value = 'false' WHERE option_name = 'SSLEnabled';"
psql engine -h localhost -p 5433  -U engine -c "UPDATE vdc_options set option_value = 'false' WHERE option_name = 'EncryptHostCommunication';"
psql engine -h localhost -p 5433  -U engine -c "UPDATE vdc_options set option_value = 'false' where option_name = 'InstallVds'"
