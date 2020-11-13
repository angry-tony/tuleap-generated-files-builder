#!/bin/sh

set -e

TULEAP_BUILD_TMP_FOLDER='/tmp/tuleap_build'

create_tuleap_build_folders() {
    mkdir -p "$TULEAP_BUILD_TMP_FOLDER"
}

build_generated_files() {
    # Set the HOME environnement variable is crappy but it seems that is the
    # only way to prevent npm and node-gyp to put their files everywhere
    TMPDIR="$TULEAP_BUILD_TMP_FOLDER" TMP="$TULEAP_BUILD_TMP_FOLDER" HOME="$TULEAP_BUILD_TMP_FOLDER" OS='rhel7' make -C "$(pwd)/tools/rpm" tarball
    if [ "$1" = "dev" ]; then
        TMPDIR="$TULEAP_BUILD_TMP_FOLDER" TMP="$TULEAP_BUILD_TMP_FOLDER" HOME="$TULEAP_BUILD_TMP_FOLDER" make composer generate-po
    fi
}

configure_composer_github_auth(){
    if [ ! -z "$COMPOSER_GITHUB_AUTH" ]; then
        HOME="$TULEAP_BUILD_TMP_FOLDER" TMPDIR="$TULEAP_BUILD_TMP_FOLDER" composer config --global --auth github-oauth.github.com "$COMPOSER_GITHUB_AUTH"
    fi
}

configure_npm_registry(){
    if [ ! -z "$NPM_REGISTRY" ]; then
        HOME="$TULEAP_BUILD_TMP_FOLDER" npm config set registry "$NPM_REGISTRY"
    fi
    if [ ! -z "$NPM_USER" -a ! -z "$NPM_PASSWORD" -a ! -z "$NPM_EMAIL" ]; then
      HOME="$TULEAP_BUILD_TMP_FOLDER" /npm-login.sh "$NPM_USER" "$NPM_PASSWORD" "$NPM_EMAIL"
    fi
}

copy_tarball_to_output_dir() {
    cp "$TULEAP_BUILD_TMP_FOLDER"/rpmbuild/SOURCES/*.tar.gz /output
}

create_tuleap_build_folders
configure_composer_github_auth
#configure_npm_registry
build_generated_files $@
copy_tarball_to_output_dir
