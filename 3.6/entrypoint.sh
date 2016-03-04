#!/bin/bash
set -e

echo OVESETUP_DB/user=str:$POSTGRES_USER >> answers.conf
echo OVESETUP_DB/password=str:$POSTGRES_PASSWORD >> answers.conf
echo OVESETUP_DB/database=str:$POSTGRES_DB >> answers.conf
echo OVESETUP_DB/host=str:$POSTGRES_HOST >> answers.conf
echo OVESETUP_DB/port=str:$POSTGRES_PORT >> answers.conf
echo OVESETUP_ENGINE_CONFIG/fqdn=str:$OVIRT_FQDN >> answers.conf
echo OVESETUP_CONFIG/fqdn=str:$OVIRT_FQDN >> answers.conf

engine-setup --config=answers.conf && su -m -s /bin/python ovirt /usr/share/ovirt-engine/services/ovirt-engine/ovirt-engine.py start
