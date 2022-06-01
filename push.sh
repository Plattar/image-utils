#!/bin/sh

# push a local build into dockerhub
docker tag plattar/image-utils:latest plattar/image-utils:version-$1
docker push plattar/image-utils:version-$1