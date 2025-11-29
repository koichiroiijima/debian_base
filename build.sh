#!/bin/bash
set -ex
cd "$(dirname "$0")"

BASE_IMAGE=bookworm-20251117-slim
VERSION=${BASE_IMAGE}-20251130
docker build . --progress=plain -t debian_base:${VERSION} \
    --build-arg IMAGE_VERSION=${VERSION} \
    --build-arg IMAGE_NAME="debian_base" \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg USERNAME="appuser" \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g)
    
docker tag debian_base:${VERSION} debian_base:latest

docker login
docker tag debian_base:${VERSION} koichiroiijima/debian_base:${VERSION}
docker tag debian_base:${VERSION} koichiroiijima/debian_base:latest
docker push koichiroiijima/debian_base:${VERSION}
docker push koichiroiijima/debian_base:latest
