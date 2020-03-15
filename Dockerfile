FROM debian:buster-slim

LABEL maintainer = Gustavo Mathias Rocha <gustavo8000@icloud.com>
ARG VERSION
ENV VERSION = ${VERSION}-2.4.8

COPY update-resolv-conf /etc/openvpn/update-resolv-conf

WORKDIR /tmp

RUN echo "**** install packages ****" \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
	git \
    tar \
    wget \
    curl \
    grep \
    dnsutils \
    whiptail \
    net-tools \
    bsdmainutils \
    libssl-dev \
    liblzo2-dev \
    libpam0g-dev \
    build-essential \
    && echo "**** download openvpn-as ****" \
    && wget https://swupdate.openvpn.org/community/releases/openvpn-${VERSION}.tar.gz \
    && tar -zxf openvpn-${VERSION}.tar.gz && cd openvpn-${VERSION} \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && openvpn --version \
    && mkdir /etc/openvpn && mkdir -p /run/openvpn/ \
    && chmod +x /etc/openvpn/update-resolv-conf \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# ports and volumes
EXPOSE 943/tcp 1194/udp 9443/tcp

CMD [ "up", "/etc/openvpn/update-resolv-conf" ]