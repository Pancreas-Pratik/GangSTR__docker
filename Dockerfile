FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN git clone --depth 1 https://github.com/gymreklab/GangSTR.git && \
    cd GangSTR && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cmake --install . && \
    cd / && \
    rm -rf /tmp/GangSTR

CMD ["GangSTR", "--help"]
