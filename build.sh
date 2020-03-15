#!/bin/bash
set -ex
cd "$(dirname "$0")"

VERSION=bullsey-2020224-slim-0.0.4-20200314
docker build . --squash -t debian_base:${VERSION} --build-arg IMAGE_VERSION=${VERSION} --build-arg IMAGE_NAME="debian_base"
docker tag debian_base:${VERSION} debian_base:latest

docker login
docker tag debian_base:${VERSION} koichiroiijima/debian_base:${VERSION}
docker tag debian_base:${VERSION} koichiroiijima/debian_base:latest
docker push koichiroiijima/debian_base:${VERSION}
docker push koichiroiijima/debian_base:latest
