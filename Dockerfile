FROM ubuntu:20.04

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates php-cli php-dom php-zip php-curl php-gd php-mbstring unzip git cpio gettext gosu expect bzip2 make curl nodejs npm xsltproc && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    npm install --global npm@6.14.4 && \
    rm /usr/bin/npx /usr/bin/npm

COPY --from=composer:1.10 /usr/bin/composer /usr/bin/composer

COPY run.sh /
COPY run-as-owner.sh /
COPY npm-login.sh /

VOLUME ["/tuleap", "/output"]

WORKDIR /tuleap

ENTRYPOINT ["/run.sh"]
