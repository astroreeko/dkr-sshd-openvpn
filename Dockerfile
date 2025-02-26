#ARG         ALPINE_VERSION="${ALPINE_VERSION:-3.15}"
FROM        alpine:3.20.1

LABEL       maintainer="https://github.com/hermsi1337"

ARG         OPENSSH_VERSION="${OPENSSH_VERSION:-8.8_p1-r1}"
ENV         CONF_VOLUME="/conf.d"
ENV         OPENSSH_VERSION="${OPENSSH_VERSION}" \
            CACHED_SSH_DIRECTORY="${CONF_VOLUME}/ssh" \
            AUTHORIZED_KEYS_VOLUME="${CONF_VOLUME}/authorized_keys" \
            ROOT_KEYPAIR_LOGIN_ENABLED="false" \
            ROOT_LOGIN_UNLOCKED="false" \
            USER_LOGIN_SHELL="/bin/bash" \
            USER_LOGIN_SHELL_FALLBACK="/bin/ash"

RUN         apk add --upgrade --no-cache \
                    iputils-ping \
                    iproute2 \
                    openvpn \
                    nano \
                    unzip \
                    curl \
                    p7zip \
                    bash \
                    bash-completion \
                    rsync \
                    iptables \
                    openssh \
            && \
            mkdir -p /root/.ssh "${CONF_VOLUME}" "${AUTHORIZED_KEYS_VOLUME}" \
            && \
            cp -a /etc/ssh "${CACHED_SSH_DIRECTORY}" \
            && \
            rm -rf /var/cache/apk/*

COPY        entrypoint.sh /
COPY        conf.d/etc/ /etc/

# Install open keys
RUN wget https://vpn.ncapi.io/groupedServerList.zip \
                && unzip groupedServerList.zip \
                && mkdir -p /etc/openvpn && mv tcp /etc/openvpn \
                && mv udp /etc/openvpn && rm -f groupedServerList.zip



EXPOSE      22
VOLUME      ["/etc/ssh"]
ENTRYPOINT  ["/entrypoint.sh"]
