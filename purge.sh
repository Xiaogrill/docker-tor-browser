#!/bin/sh

INSTALL_PREFIX=/usr/local/bin

if [ `id -u` != 0 ]; then
  exec sudo `realpath $0` "$@"
fi

rm -r /root/docker/tor $INSTALL_PREFIX/tor
docker rmi tor
