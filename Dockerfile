FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y nodejs npm php ruby-sass git cpio gettext gosu expect && \
    rm -rf /var/lib/apt/lists/* && \
    gem install scss_lint && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install --global npm@5.4.2 bower gulp-cli && \
    npm install --no-save phantomjs-prebuilt && \
    mv /node_modules/phantomjs-prebuilt /usr/local/lib/node_modules/phantomjs-prebuilt && \
    ln -s /usr/local/lib/node_modules/phantomjs-prebuilt/bin/phantomjs /usr/local/bin/phantomjs && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Composer Installer verified'; } else { echo 'Composer Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer


COPY run.sh /
COPY run-as-owner.sh /
COPY npm-login.sh /

VOLUME /tuleap

WORKDIR /tuleap

ENTRYPOINT ["/run.sh"]
