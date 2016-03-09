# docker-ovirt-engine
Dockerized version of ovirt-engine, the management part of oVirt.

## Run ovirt-engine

```bash
docker run --name ovirt-postgres -e POSTGRES_PASSWORD=engine -e POSTGRES_USER=engine -e POSTGRES_DB=engine -d rmohr/ovirt-postgres
docker run --name ovirt-engine  --link ovirt-postgres:postgres -e OVIRT_PASSWORD=engine -p 8443:8443 -d rmohr/ovirt-engine

```
Visit https://127.0.0.1:8443 and login with the user `admin` and the password
`engine`. Use a different value for the environment variable `OVIRT_PASSWORD`
to change the admin password.

## Examine logs

```bash
docker logs ovirt-engine
```

## Environment variables

### Database connection
```
ENV POSTGRES_USER engine     # Postgres user
ENV POSTGRES_PASSWORD engine # Postgres password
ENV POSTGRES_DB engine       # Postgres schema
ENV POSTGRES_HOST postgres   # Postgres host
ENV POSTGRES_PORT 5432       # Postgres port
```

### ovirt-engine
```
ENV OVIRT_FQDN localhost    # Full qualified domain name of the engine
ENV OVIRT_PASSWORD engine   # Admin password of the engine
ENV OVIRT_PKI_ORGANIZATION  # PKI organization name
```
