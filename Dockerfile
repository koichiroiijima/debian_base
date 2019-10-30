FROM debian:10.1-slim

ARG IMAGE_NAME=debian_base
ARG IMAGE_VERSION=0.0.1

LABEL \
    NAME=${IMAGE_NAME}} \
    VERSION=${IMAGE_VERSION}}

# Set User
USER root

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=America/Los_Angeles
ENV PATH=/opt/bin:/root/bin:${PATH}

# Set working directory
WORKDIR /opt/
RUN set -ex \
    && \
    mkdir -p /root/bin \
    && \
    mkdir -p /opt/bin \
# Set timezone
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
    apt-get remove -y tzdata \
# Install utility commands
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
    gnupg \
    inetutils-ping \
    vim \
# Install develpment commands
    && \
    apt-get install  --no-install-recommends -y \
    git \
    gcc \
    g++ \
    gfortran \
    perl \
    && \
    apt-get autoclean \
    && \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/*

ENV ENV=/root/.bashrc
SHELL ["/bin/bash", "-c"]

CMD ["bash"]
