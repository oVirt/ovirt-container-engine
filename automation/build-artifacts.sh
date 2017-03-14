#!/bin/bash -xe
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

CNAME="ovirt/engine-monolithic"
ENGINE="image-specifications/Engine"
SUFFIX="$(date -u +%Y%m%d%H%M%S).git$(git rev-parse --short HEAD)"
TAGV=4.1

function clean_up {
    docker rmi ${CNAME}:${TAGV}
    docker images -f dangling=true -q | xargs -r docker rmi
}

trap clean_up SIGHUP SIGINT SIGTERM
cd ${ENGINE}
docker build --no-cache --pull -t ${CNAME}:${TAGV} -f Dockerfile .
docker save ${CNAME}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz
clean_up

# we need to do it for all images
