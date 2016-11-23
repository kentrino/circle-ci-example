#!/bin/sh
set -xe

if [ -e ~/cache/docker-fluentd.tar ] && [ $(md5sum Dockerfile | cut -d' ' -f1) = $(cat ~/cache/dockerfile.digest) ]
then
  docker load < ~/cache/docker-fluentd.tar
else
  mkdir -p ~/cache
  docker build -t fluentd docker/
  md5sum Dockerfile | cut -d' ' -f1 > ~/cache/dockerfile.digest
  docker save fluentd > ~/cache/docker-fluentd.tar
fi

