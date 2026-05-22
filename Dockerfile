FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        build-essential \
        cmake \
        make \
        wget \
        curl \
        ca-certificates \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libncurses5-dev \
        libncursesw5-dev \
        autoconf \
        automake \
        autotools-dev \
        libtool \
        pkg-config && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN git clone --depth 1 https://github.com/gymreklab/GangSTR.git && \
    cd GangSTR && \
    sed -i 's|UPDATE_COMMAND autoreconf ${CMAKE_BINARY_DIR}/thirdparty/htslib/src/htslib|UPDATE_COMMAND autoreconf --install ${CMAKE_BINARY_DIR}/thirdparty/htslib/src/htslib|' CMakeLists.txt && \
    grep -n "UPDATE_COMMAND autoreconf" CMakeLists.txt && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j1 && \
    cmake --install . && \
    cd / && \
    rm -rf /tmp/GangSTR

WORKDIR /data

CMD ["GangSTR", "--help"]
