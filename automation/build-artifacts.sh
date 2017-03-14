#!/bin/bash -xe
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

IMG_PREFIX="ovirt/"
IMAGES_PATH="./image-specifications"
NODE_PATH="image-specifications/Engine"

# we can use here "git describe --all" if we want to keep image history
TAGV="4.1"

function clean_up {
    docker images -f dangling=true -q | xargs -r docker rmi
}

trap clean_up SIGHUP SIGINT SIGTERM
cd ${IMAGES_PATH}

ENGINE="engine"
cd ${ENGINE}

docker build -t ${IMG_PREFIX}${ENGINE}:${TAGV} .

NODE="node"
cd ../
cd ${NODE}
docker build -t ${IMG_PREFIX}${NODE}:${TAGV} .

POSTGRES="postgres"
cd ../
cd ${POSTGRES}
docker build -t ${IMG_PREFIX}${POSTGRES}:${TAGV} .

SYSLOG="syslog"
cd ../
cd ${SYSLOG}
docker build -t ${IMG_PREFIX}${SYSLOG}:${TAGV} .

docker save ${IMG_PREFIX}${ENGINE}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz
docker save ${IMG_PREFIX}${NODE}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz
docker save ${IMG_PREFIX}${POSTGRES}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz
docker save ${IMG_PREFIX}${SYSLOG}:${TAGV} | gzip > ../exported-artifacts/${CNAME/\//-}-${TAGV}.tar.gz

clean_up
