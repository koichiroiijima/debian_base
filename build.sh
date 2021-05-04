#!/bin/bash
set -ex
cd "$(dirname "$0")"

BASE_IMAGE=bullseye-20210408-slim
VERSION=${BASE_IMAGE}-20210504
docker build .  -t debian_base:${VERSION} --build-arg IMAGE_VERSION=${VERSION} --build-arg IMAGE_NAME="debian_base" --build-arg BASE_IMAGE=${BASE_IMAGE}
docker tag debian_base:${VERSION} debian_base:latest

docker login
docker tag debian_base:${VERSION} koichiroiijima/debian_base:${VERSION}
docker tag debian_base:${VERSION} koichiroiijima/debian_base:latest
docker push koichiroiijima/debian_base:${VERSION}
docker push koichiroiijima/debian_base:latest
