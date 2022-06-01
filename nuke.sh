#!/bin/sh

# Nukes all built docker images
docker stop image-utils
docker rm -v image-utils
docker rmi plattar/image-utils:latest --force