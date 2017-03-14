#!/bin/bash -xe
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

IMG_PREFIX="docker.io/ovirt/"
IMAGES_PATH="./image-specifications"

# we can use here "git describe --all" if we want to keep image history
# but then we need to change openshift deployment to use this tag
TAGV="4.1"

function clean_up {
    docker images -f dangling=true -q | xargs -r docker rmi
}

trap clean_up SIGHUP SIGINT SIGTERM
cd ${IMAGES_PATH}

for img in "engine" "node" "ovirt-postgres" "syslog" "spice-squid"
do
  docker build -t ${IMG_PREFIX}${img}:${TAGV} .
  docker push ${IMG_PREFIX}${img}:${TAGV}
done

clean_up
