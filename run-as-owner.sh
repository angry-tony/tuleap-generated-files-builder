#!/bin/sh

set -e

TULEAP_BUILD_TMP_FOLDER='/tmp/tuleap_build'

create_tuleap_build_folders() {
    mkdir -p "$TULEAP_BUILD_TMP_FOLDER"
}

build_generated_files() {
    # Set the HOME environnement variable is crappy but it seems that is the
    # only way to prevent npm and node-gyp to put their files everywhere
    TMP="$TULEAP_BUILD_TMP_FOLDER" HOME="$TULEAP_BUILD_TMP_FOLDER" OS='rhel6' make -C "$(pwd)/tools/rpm" tarball
    rm -rf "$TULEAP_BUILD_TMP_FOLDER"/*
}

configure_npm_registry(){
    if [ ! -z "$NPM_REGISTRY" ]; then
        HOME="$TULEAP_BUILD_TMP_FOLDER" npm config set registry "$NPM_REGISTRY"
    fi
    if [ ! -z "$NPM_USER" -a ! -z "$NPM_PASSWORD" -a ! -z "$NPM_EMAIL" ]; then
      HOME="$TULEAP_BUILD_TMP_FOLDER" /npm-login.sh "$NPM_USER" "$NPM_PASSWORD" "$NPM_EMAIL"
    fi
}

create_tuleap_build_folders
configure_npm_registry
build_generated_files
