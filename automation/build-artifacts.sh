#!/bin/bash -xe
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

CNAME="ovirt/engine-monolithic"
OVERSION="4.0"
SUFFIX="$(date -u +%Y%m%d%H%M%S).git$(git rev-parse --short HEAD)"
TAGV=${OVERSION}-${SUFFIX}

function clean_up {
    docker rmi ${CNAME}:${TAGV}
    docker images -f dangling=true -q | xargs -r docker rmi
}

trap clean_up SIGHUP SIGINT SIGTERM
cd ${OVERSION}
docker build --no-cache --pull -t ${CNAME}:${TAGV} -f Dockerfile .
docker save ${CNAME}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz
clean_up
