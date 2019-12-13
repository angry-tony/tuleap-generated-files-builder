FROM ubuntu:19.10

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates php-cli php-dom php-zip unzip git cpio gettext gosu expect bzip2 make curl nodejs npm && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    npm install --global npm@6.13.4

COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer

COPY run.sh /
COPY run-as-owner.sh /
COPY npm-login.sh /

VOLUME ["/tuleap", "/output"]

WORKDIR /tuleap

ENTRYPOINT ["/run.sh"]
