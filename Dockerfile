FROM debian:bullseye-slim

LABEL MAINTAINER PLATTAR(www.plattar.com)

ENV BASE_APP_DIR="imgutils"
ENV BASE_DIR="/usr/src/app"

# our binary versions where applicable
ENV ARCORE_VERSION="1.47.0"
ENV BASIS_VERSION="1.16.4"
ENV KTXSOFT_VERSION="4.3.2"

# BASIS UNIVERSAL ENV VARIABLES
ENV BASIS_SRC="basissrc"
ENV BASIS_BIN_PATH="${BASE_DIR}/${BASE_APP_DIR}/basisuniversal/bin"
ENV PATH="${PATH}:${BASIS_BIN_PATH}"

# ARCOREIMG ENV VARIABLES
ENV ARCOREIMG_SRC="arcoresrc"
ENV ARCOREIMG_BIN_PATH="${BASE_DIR}/${BASE_APP_DIR}/arcoreimg/bin"
ENV PATH="${PATH}:${ARCOREIMG_BIN_PATH}"

WORKDIR ${BASE_DIR}

# Required for compiling the various sources
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	git \
	build-essential \
	cmake \
	make \
	nasm \
	wget \
	curl && \
	# All our pre-compiled binaries and compiled binaries will be going
	# in this folder
	mkdir -p ${BASE_APP_DIR} && \
	# Basis Universal Clone/Compile
	# More info @ https://github.com/BinomialLLC/basis_universal
	git clone --branch "${BASIS_VERSION}" --single-branch https://github.com/BinomialLLC/basis_universal.git ${BASIS_SRC} && \
	cd ${BASIS_SRC} && cmake CMakeLists.txt && make && cd ../ && \
	mkdir -p ${BASE_APP_DIR}/basisuniversal && \
	mv ${BASIS_SRC}/bin ${BASIS_BIN_PATH} && \
	chmod +x ${BASIS_BIN_PATH}/basisu && \
	chmod 777 ${BASIS_BIN_PATH}/basisu && \
	rm -rf ${BASIS_SRC} && \
	# Cone and setup the KTX SOFTWARE Tools
	# More info @ https://github.com/KhronosGroup/KTX-Software
	wget https://github.com/KhronosGroup/KTX-Software/releases/download/v${KTXSOFT_VERSION}/KTX-Software-${KTXSOFT_VERSION}-Linux-x86_64.deb && \
	dpkg -i KTX-Software-${KTXSOFT_VERSION}-Linux-x86_64.deb && \
	rm -rf KTX-Software-${KTXSOFT_VERSION}-Linux-x86_64.deb && \
	# Clone and setup the Image Marker quality checker
	# More info @ https://github.com/google-ar/arcore-android-sdk
	git clone --branch "v${ARCORE_VERSION}" --single-branch https://github.com/google-ar/arcore-android-sdk.git ${ARCOREIMG_SRC} && \
	mkdir -p ${ARCOREIMG_BIN_PATH} && \
	mv ${ARCOREIMG_SRC}/tools/arcoreimg/linux/arcoreimg ${ARCOREIMG_BIN_PATH}/arcoreimg && \
	chmod +x ${ARCOREIMG_BIN_PATH}/arcoreimg && \
	chmod 777 ${ARCOREIMG_BIN_PATH}/arcoreimg && \
	rm -rf ${ARCOREIMG_SRC} && \
	# remove packages we no longer need/require
	# this keeps the container as small as possible
	# if others need them, they can install when extending
	apt-get purge -y git \
	build-essential \
	cmake \
	make \
	nasm \
	wget \
	curl && \
	apt autoremove -y && \
	apt-get autoclean -y