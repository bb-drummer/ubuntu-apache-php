###!/usr/bin/env bash
set -e

#curl -H "Content-Type: application/json" --data '{"build": true}' -X POST https://registry.hub.docker.com/u/bbdrummer/ubuntu-apache-php/trigger/${DOCKER_BUILD_TOKEN}/

curl -H "Content-Type: application/json" --data '{"build": true}' -X POST ${DOCKER_AUTOBUILD_TRIGGER}
