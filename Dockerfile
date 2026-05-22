FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        build-essential \
        cmake \
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
        pkg-config && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN git clone --depth 1 https://github.com/gymreklab/GangSTR.git && \
    cd GangSTR && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j1 && \
    cmake --install . && \
    cd / && \
    rm -rf /tmp/GangSTR

WORKDIR /data

CMD ["GangSTR", "--help"]
