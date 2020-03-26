## Goal

Build the generated files of Tuleap

## Build the Docker image

```shell
$ docker build -t tuleap-generated-files-builder .
```

## Usage

```shell
$ docker run --rm -v /path/to/tuleap/sources:/tuleap -v /path/to/put/the/generated/sources/tarball:/output --tmpfs /tmp/tuleap_build:rw,noexec,nosuid --read-only tuleap-generated-files-builder
```

## Choose your NPM registry and NPM login

You can use a different NPM registry and log in with the user of your choice using
the following environment variables:
  * ``NPM_REGISTRY``: registry address
  * ``NPM_USER``: user name used to log in into the registry
  * ``NPM_PASSWORD``: password of the user
  * ``NPM_EMAIL``: public mail that will be used if you publish a package

## Use a GitHub token for Composer

You can set a GitHub token to use with Composer using the following environnement variables:
  * ``COMPOSER_GITHUB_AUTH``: GitHub token with the repo scope
