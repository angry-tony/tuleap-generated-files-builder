#!/bin/sh

set -e

TULEAP_BUILD_TMP_FOLDER='/tmp/tuleap_build'
TULEAP_BUILD_NPM_FOLDER="$TULEAP_BUILD_TMP_FOLDER/npm"

create_tuleap_build_folders() {
    mkdir -p "$TULEAP_BUILD_NPM_FOLDER"
}

build_files_generated_through_npm() {
    # Set the HOME environnement variable is crappy but it seems that is the
    # only way to prevent npm and node-gyp to put their files everywhere
    TMP="$TULEAP_BUILD_NPM_FOLDER" HOME="$TULEAP_BUILD_NPM_FOLDER" npm install
    TMP="$TULEAP_BUILD_NPM_FOLDER" HOME="$TULEAP_BUILD_NPM_FOLDER" npm run build
}

configure_npm_registry(){
    if [ ! -z "$NPM_REGISTRY" ]; then
        HOME="$TULEAP_BUILD_NPM_FOLDER" npm config set registry "$NPM_REGISTRY"
    fi
    if [ ! -z "$NPM_USER" -a ! -z "$NPM_PASSWORD" -a ! -z "$NPM_EMAIL" ]; then
      HOME="$TULEAP_BUILD_NPM_FOLDER" /npm-login.sh "$NPM_USER" "$NPM_PASSWORD" "$NPM_EMAIL"
    fi
}

create_tuleap_build_folders
configure_npm_registry
build_files_generated_through_npm
