FROM ubuntu:18.04

# Install basic deps for all packages
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    cmake \
    git \
    wget \
    g++

# Install Folly

# Install folly package deps
RUN apt-get install -y \
    g++ \
    cmake \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libiberty-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    build-essential \
    pkg-config

# Install folly itself
RUN git clone https://github.com/facebook/folly.git

# Install WDT from source
RUN apt-get install -y \
    libgtest-dev \
    libboost-all-dev

RUN git clone --single-branch --branch folly-fixes https://github.com/sashanullptr/wdt.git && \
    cd wdt && \
    mkdir _build && cd _build && \
    cmake .. \
    -DBUILD_TESTING=off && \
    make -j$(nproc) && \
    make install
    
RUN apk add --no-cache openssh-client git

ENV WDTDATA /data

VOLUME ["/data"]

RUN mkdir -p /data

WORKDIR /data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["wdt"]
