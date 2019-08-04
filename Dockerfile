FROM debian:10.0-slim

ARG IMAGE_NAME=debian_base
ARG IMAGE_VERSION=0.0.1

LABEL \
    NAME=${IMAGE_NAME}} \
    VERSION=${IMAGE_VERSION}}

# Set User
USER root

# Set working directory
WORKDIR /opt/
RUN set -ex \
    && \
    mkdir -p /root/bin \
    && \
    mkdir -p /opt/bin
ENV PATH=${PATH}:/opt/bin:/root/bin

# Set timezone
ENV TZ=America/Los_Angeles
RUN set -ex \
    && \
    apt-get update \
    && \
    apt-get install  --no-install-recommends -y \
    tzdata \
    && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && \
    echo ${TZ} > /etc/timezone \
    && \
    date \
    && \
    apt-get remove -y tzdata

# Install utility commands
RUN set -ex \
    && \
    apt-get update \
    && \
    apt-get install  --no-install-recommends -y \
    bash \
    wget \
    curl \
    tar \
    gzip \
    unzip \
    coreutils \
    ca-certificates \
    openssl \
    openssh-client \
    gnupg

# Install develpment commands
RUN set -ex \
    && \
    apt-get update \
    && \
    apt-get install  --no-install-recommends -y \
    git \
    gcc \
    g++ \
    gfortran \
    perl 

# Clean apt
RUN set -ex \
    && \
    apt-get autoclean \
    && \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash"]
