FROM debian:buster-slim

LABEL maintainer = Gustavo Mathias Rocha <gustavo8000@icloudl.com>

RUN \
  echo "**** install packages ****" && \
    apt-get update && \
    apt-get upgrade -y && \
  echo "**** download openvpn-as ****" \
    curl -L https://install.pivpn.io | bash \
  && echo "**** ensure home folder for abc user set to /config ****" && \
    usermod -d /config abc && \
  echo "**** create admin user and set default password for it ****" && \
    useradd -s /sbin/nologin admin && \
    echo "admin:password" | chpasswd && \
    rm -rf /tmp/* /var/lib/apt/lists/*

# ports and volumes
EXPOSE 943/tcp 1194/udp 9443/tcp
VOLUME /config