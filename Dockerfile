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


# Install WDT from source
RUN apt-get install -y \
    libgtest-dev \
    libboost-all-dev

RUN mkdir /usr/app && chmod 777 /usr/app
RUN git clone --recurse-submodules https://github.com/length967/warp-cli.git /usr/app/warp-cli
RUN python3 /usr/app/warp-cli/core/warp.py --install
        
ENV WDTDATA /data

VOLUME ["/data"]
#change-2

RUN mkdir -p /data

WORKDIR /data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["wdt"]
