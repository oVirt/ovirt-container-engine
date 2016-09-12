#!/bin/bash
set -e

cp -f answers.conf.in answers.conf
echo OVESETUP_DB/user=str:$POSTGRES_USER >> answers.conf
echo OVESETUP_DB/password=str:$POSTGRES_PASSWORD >> answers.conf
echo OVESETUP_DB/database=str:$POSTGRES_DB >> answers.conf
echo OVESETUP_DB/host=str:$POSTGRES_HOST >> answers.conf
echo OVESETUP_DB/port=str:$POSTGRES_PORT >> answers.conf
echo OVESETUP_ENGINE_CONFIG/fqdn=str:$OVIRT_FQDN >> answers.conf
echo OVESETUP_CONFIG/fqdn=str:$OVIRT_FQDN >> answers.conf
echo OVESETUP_CONFIG/adminPassword=str:$OVIRT_PASSWORD >> answers.conf
echo OVESETUP_PKI/organization=str:$OVIRT_PKI_ORGANIZATION >> answers.conf

# Copy pki template files into original template location.
# Mounts on kubernetes hide the original files in the image.
cp -a /etc/pki/ovirt-engine.tmpl/* /etc/pki/ovirt-engine/

export PGPASSWORD=$POSTGRES_PASSWORD
psql $POSTGRES_DB -h $POSTGRES_HOST -p $POSTGRES_PORT  -U $POSTGRES_USER -c "UPDATE vdc_options set option_value = '$HOST_ENCRYPT' WHERE option_name = 'SSLEnabled';"
psql $POSTGRES_DB -h $POSTGRES_HOST -p $POSTGRES_PORT  -U $POSTGRES_USER -c "UPDATE vdc_options set option_value = '$HOST_ENCRYPT' WHERE option_name = 'EncryptHostCommunication';"
psql $POSTGRES_DB -h $POSTGRES_HOST -p $POSTGRES_PORT  -U $POSTGRES_USER -c "UPDATE vdc_options set option_value = '$HOST_INSTALL' where option_name = 'InstallVds'"

engine-setup --config=answers.conf --offline && su -m -s /bin/python ovirt /usr/share/ovirt-engine/services/ovirt-engine/ovirt-engine.py start
