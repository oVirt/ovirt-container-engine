# TODO: log setup log and boot.log to stdout only
# TODO: fix gpg key warnings
# TODO: make sure unicode is used
# TODO: give ovirt user a well known gid and uid
# TODO: fix redirect from http to https (port is missing)

FROM centos:7.2.1511

MAINTAINER Roman Mohr <rmohr@redhat.com>

# Database
ENV POSTGRES_USER engine
ENV POSTGRES_PASSWORD engine
ENV POSTGRES_DB engine
ENV POSTGRES_HOST postgres
ENV POSTGRES_PORT 5432

# oVirt
ENV OVIRT_FQDN localhost

EXPOSE 8080 8443

USER root

RUN yum -y localinstall http://resources.ovirt.org/pub/yum-repo/ovirt-release40.rpm \
    && yum -y install ovirt-engine patch \
    && yum -y clean all

# dockerize helps us waiting for postgres being ready
ENV DOCKERIZE_VERSION v0.2.0
RUN curl -OL https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
    
# engine-setup needs the link to initctl
RUN ln -s /usr/sbin/service /usr/bin/initctl

#oVirt
ENV OVIRT_PASSWORD engine
ENV OVIRT_PKI_ORGANIZATION oVirt

COPY entrypoint.sh answers.conf.in setup.patch /
COPY 999-ovirt-engine.conf /etc/ovirt-engine/engine.conf.d/

# patch engine-setup so that it does not try to start or stop services with systemd
RUN patch -p0 < setup.patch

# For kubernetes copy pki template files to a backup directory
RUN cp -a /etc/pki/ovirt-engine /etc/pki/ovirt-engine.tmpl

# Persist this folder to keep the generated TLS certificates on the first start
VOLUME /etc/pki/ovirt-engine
# Persist this folder to keep the database backups
VOLUME /var/lib/ovirt-engine/backups

# Encrypt host communication
ENV HOST_ENCRYPT=true
# Try to provision hosts when they are added
ENV HOST_INSTALL=true
# Use host identifier when talking with the host, so that the host sees who it is from the engines view.
# This is valuable when working with ovirt-vdsmfake
ENV HOST_USE_IDENTIFIER=false
# HACK: Config BlockMigrationOnSwapUsagePercentage so that the vm will start in ovirt-engine
# For some reason this check fails the start vm - this should be figured out instead of this hack
ENV BLOCK_MIGRATION_ON_SWAP_USAGE_PERCENTAGE=9999

# Public reachable HTTPS port
ENV HTTPS_PORT 8443
ENV SSO_ALTERNATE_ENGINE_FQDNS="localhost:8443 127.0.0.1:8443"

CMD bash /entrypoint.sh
