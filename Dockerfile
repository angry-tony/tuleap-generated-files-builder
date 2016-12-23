FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y nodejs npm ruby-sass gosu expect && \
    gem install scss_lint && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install --global npm && \
    rm -rf /var/lib/apt/lists/*


COPY run.sh /
COPY run-as-owner.sh /
COPY npm-login.sh /

VOLUME /tuleap

WORKDIR /tuleap

ENTRYPOINT ["/run.sh"]
