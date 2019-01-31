FROM ubuntu:18.04

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y php php-dom php-zip unzip git cpio gettext gosu expect bzip2 make g++ curl nodejs npm && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    npm install --global npm@6.4.1

COPY --from=composer:1.8 /usr/bin/composer /usr/bin/composer

COPY run.sh /
COPY run-as-owner.sh /
COPY npm-login.sh /

VOLUME ["/tuleap", "/output"]

WORKDIR /tuleap

ENTRYPOINT ["/run.sh"]
