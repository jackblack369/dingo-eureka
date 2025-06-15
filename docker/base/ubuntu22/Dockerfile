FROM ubuntu:22.04

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8     \
    LC_ALL=C.UTF-8

SHELL ["/bin/bash", "-c"]

# wget -P /tmp/ https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-x86_64.tar.gz
# wget -P /tmp/ https://musl.libc.org/releases/musl-1.2.5.tar.gz
# wget -P /tmp/ https://github.com/protocolbuffers/protobuf/releases/download/v25.1/protoc-25.1-linux-x86_64.zip
# wget -P /tmp/ https://golang.org/dl/go1.23.4.linux-amd64.tar.gz
# wget -P /tmp/ https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2
# wget -P /tmp/ https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip
COPY cmake-3.30.1-linux-x86_64.tar.gz musl-1.2.5.tar.gz protoc-25.1-linux-x86_64.zip go1.23.4.linux-amd64.tar.gz jemalloc-5.3.0.tar.bz2 ninja-linux.zip /tmp/

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get clean \
    && apt-get -y update \
    && apt install -y bzip2 unzip wget tar git make patch gcc g++ perl flex bison libnl-genl-3-dev libunwind-dev libfuse3-dev python3-dev python3-pip software-properties-common pkg-config \
    && apt install -y libsystemd-dev libblkid-dev libkeyutils-dev libcap-dev \
    && apt install -y libnghttp2-dev libssh2-1-dev libudev-dev \
    && apt install -y clang-14 clang-tools-14 libc++-14-dev libc++abi-14-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

RUN pip3 install -U meson
RUN pip3 install cython PyYAML

RUN cd /tmp && tar -zxvf cmake-3.30.1-linux-x86_64.tar.gz \
    && cp -rf cmake-3.30.1-linux-x86_64/bin/* /usr/local/bin/  \
    && cp -rf cmake-3.30.1-linux-x86_64/share/* /usr/local/share \
    && rm -rf cmake-3.30.1-linux-x86_64

RUN cd /tmp && tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz

RUN cd /tmp && unzip protoc-25.1-linux-x86_64.zip -d $HOME/.local

RUN cd /tmp && tar -zxvf musl-1.2.5.tar.gz && cd musl-1.2.5 && ./configure && make && make install

RUN cd /tmp && tar -xjvf jemalloc-5.3.0.tar.bz2 && chown -R root:root jemalloc-5.3.0 &&  cd jemalloc-5.3.0 && ./configure && make && make install

RUN cd /tmp && unzip ninja-linux.zip -d /usr/local/bin && chmod +x /usr/local/bin/ninja

# Add Ubuntu toolchain PPA to get GCC 13
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

# Install GCC 13 and related tools
RUN apt-get update && apt-get install -y \
    gcc-13 \
    g++-13 \
    gfortran-13 \
    libomp-13-dev \
    && rm -rf /var/lib/apt/lists/*

# Set GCC 13 as the default compiler
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-13 \
    --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-13

# Set up additional development tools and libraries
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    libtool-bin \
    build-essential \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV CC=/usr/bin/gcc-13
ENV CXX=/usr/bin/g++-13
ENV FC=/usr/bin/gfortran-13

ENV PATH=/usr/local/go/bin:/root/go/bin:/root/.local/bin:/usr/local/musl/bin:$PATH