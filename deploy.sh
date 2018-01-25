#!/bin/sh

INSTALL_PREFIX=/usr/local/bin

if [ `id -u` != 0 ]; then
  exec sudo `realpath $0` "$@"
fi

set -e

mkdir -p /root/docker/tor || true

cp Dockerfile tor tor-browser-bundle.pub /root/docker/tor/

chown -R root:root /root/docker
chmod 600 /root/docker/tor/tor-browser-bundle.pub /root/docker/tor/Dockerfile
chmod 755 /root/docker/tor/tor

cp /root/docker/tor/tor $INSTALL_PREFIX/tor

$INSTALL_PREFIX/tor --build
