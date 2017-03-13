#!/bin/bash -xe
# TODO validate Dockerfile syntax
# This code should be replaced with a real verification.
# Currently, just checking docker build in STD-CI
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

CNAME="ovirt/engine-monolithic"
OVERSION="4.0"
SUFFIX="$(date -u +%Y%m%d%H%M%S).git$(git rev-parse --short HEAD)"
TAGV=${OVERSION}-${SUFFIX}

cd ${OVERSION}
docker build --no-cache --pull -t ${CNAME}:${TAGV} -f Dockerfile .
docker save ${CNAME}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz
