[![Twitter: @plattarglobal](https://img.shields.io/badge/contact-@plattarglobal-blue.svg?style=flat)](https://twitter.com/plattarglobal)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg?style=flat)](LICENSE)

_Image Utils_ is a docker image that contains a number of pre-built tools useful for image file processing and conversion tasks. These tools typically take a long time to build from source. This image can serve as a useful base for other applications. Check out the Plattar [dockerhub](https://hub.docker.com/r/plattar/image-utils) repository for the latest pre-built images.

* * *

### About

-   Check image tracking quality, useful for assigning as a marker image
-   Convert images into BASIS format using Basis Universal
-   Convert images into KTX2 format using KTX Software

### Quickstart

Prebuilt containers are available from Plattar [dockerhub](https://hub.docker.com/r/plattar/image-utils) repository.

##### Building/Running Locally

```sh
# to build a local version of this repository run the following script
docker-compose -f live.yml build

# once built, run the following script to bring up the container
docker-compose -f live.yml up

# once the container is running, the user can exec into it with the following command
docker exec -it image-utils /bin/sh

# to clean everything run the following script as follows
sh nuke.sh
```

### Acknowledgements

This tool relies on the following open source projects.

-   [Google ARCore SDK](https://github.com/google-ar/arcore-android-sdk)
-   [BinomialLLC Basis Universal Project](https://github.com/binomialLLC/basis_universal)
-   [KhronosGroup KTX Software](https://github.com/KhronosGroup/KTX-Software)