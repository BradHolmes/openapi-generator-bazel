#!/usr/bin/env bash

set -e

VERSION=${1:?Must supply version as single argument.  Do not prefix with 'v'  Like 0.2.0}

echo "Creating test package for version $VERSION"

TOPLEVEL_DIR=$(git rev-parse --show-toplevel)
cd ${TOPLEVEL_DIR}

sed -i s/0.0.0/${VERSION}/g MODULE.bazel

NAME=openapi-generator-bazel-v${VERSION}

git archive --format=tar --prefix ${PREFIX}/ HEAD \
    BUILD.bazel \
    LICENSE \
    MODULE.bazel \
    MODULE.bazel.lock \
    defs.bzl \
    extension.bzl \
    internal/openapi_generator.bzl \
    internal/BUILD.bazel |
    gzip > ${NAME}.tar.gz
