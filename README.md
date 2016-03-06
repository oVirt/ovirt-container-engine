# docker-ovirt-engine
Dockerized version of ovirt-engine, the management part of oVirt.

## Run ovirt-engine

```bash
docker run --name ovirt-postgres -e POSTGRES_PASSWORD=engine -e POSTGRES_USER=engine -e POSTGRES_DB=engine -e OVIRT_PASSWORD=engine -d rmohr/ovirt-postgres
docker run --name ovirt-engine -p 8443:8443 -d rmohr/ovirt-engine

```
Visit https://127.0.0.1:8443 and login with the user `admin` and the password
`engine`. Use a different value for the environment variable `OVIRT_PASSWORD`
to change the admin password.

## Examine logs

```bash
docker logs ovirt-engine
```

