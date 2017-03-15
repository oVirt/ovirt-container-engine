#!/bin/bash -xe
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

IMG_PREFIX="docker.io/bronhaim/"
IMAGES_PATH="./image-specifications"

# we can use here "git describe --all" if we want to keep image history
# but then we need to change openshift deployment to use this tag
TAGV="4.1"

function clean_up {
    docker images -f dangling=true -q | xargs -r docker rmi -f
}

trap clean_up SIGHUP SIGINT SIGTERM
cd ${IMAGES_PATH}

# TODO: add jenkins docker login

for img in "engine" "node" "ovirt-postgres" "syslog" "spice-squid"
do
  cd ${img}
  docker build -t ${IMG_PREFIX}${img}:${TAGV} .
  docker push ${IMG_PREFIX}${img}:${TAGV}
  cd ..
done

clean_up
