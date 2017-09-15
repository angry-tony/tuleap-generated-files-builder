FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y php ruby-sass git cpio gettext gosu expect bzip2 curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    gem install scss_lint && \
    npm install --global npm@5.4.2 bower gulp-cli && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Composer Installer verified'; } else { echo 'Composer Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer


COPY run.sh /
COPY run-as-owner.sh /
COPY npm-login.sh /

VOLUME /tuleap

WORKDIR /tuleap

ENTRYPOINT ["/run.sh"]
