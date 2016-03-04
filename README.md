# docker-ovirt-engine
Dockerized version of ovirt-engine, the management part of oVirt.

## Run ovirt-engine

```bash
docker run --name ovirt-postgres -e POSTGRES_PASSWORD=engine -e POSTGRES_USER=engine -e POSTGRES_DB=engine -d rmohr/ovirt-postgres
docker run --name ovirt-engine -p 8443:8443 -d rmohr/ovirt-engine

```

Visit https://127.0.0.1:8443.

## Examine logs

```bash
docker logs ovirt-engine
```

