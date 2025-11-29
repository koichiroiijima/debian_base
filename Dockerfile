ARG BASE_IMAGE=bookworm-slim

FROM debian:${BASE_IMAGE}

ARG IMAGE_NAME=debian_base
ARG IMAGE_VERSION=0.0.1
ARG USERNAME=appuser
ARG USER_ID=1000
ARG GROUP_ID=1000

LABEL \
    NAME=${IMAGE_NAME} \
    VERSION=${IMAGE_VERSION}

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
ENV PATH=/opt/bin:/root/bin:${PATH}

# Set working directory
SHELL ["/bin/bash", "-c"]
RUN set -ex \
    && \
    mkdir -p /root/bin \
    && \
    mkdir -p /opt/bin \
# Set timezone
    && \
    apt-get update \
    && \
    apt-get upgrade -y \
    && \
    apt-get dist-upgrade -y \
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
    git \
    && \
    update-ca-certificates \
    && \
    apt-get autoremove -y \
    && \
    apt-get autoclean \
    && \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/* \
# Create a non-root user
    && \
    groupadd -r -g ${GROUP_ID} ${USERNAME} \
    && \
    useradd -r -g ${GROUP_ID} -u ${USER_ID} ${USERNAME} -m -d /home/${USERNAME} -s /bin/bash \
    && \
    mkdir -p /home/${USERNAME} \
    && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}
ENV ENV=/home/${USERNAME}/.bashrc

CMD ["bash"]
