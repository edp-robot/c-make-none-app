#!/bin/bash

CacheDIR=$1

echo "Installing dependencies..."


apt update && apt install -y \
    cmake

# Install libmicrohttpd
if [ ! -d "${CacheDIR}/microhttpd" ]; then
    mkdir -p ${CacheDIR}/microhttpd
    wget https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-0.9.73.tar.gz
    tar -xzf libmicrohttpd-0.9.73.tar.gz
    cd libmicrohttpd-0.9.73
    ./configure --prefix=${CacheDIR}/microhttpd
    make && make install
    cd ..
else
    echo "libmicrohttpd already installed in ${CacheDIR}/microhttpd"
fi

# Install Unity
if [ ! -d "${CacheDIR}/Unity" ]; then
    echo "Installing Unity..."
    curl -L https://github.com/ThrowTheSwitch/Unity/archive/master.zip -o unity.zip
    apt update && apt install unzip
    unzip unity.zip
    mkdir -p ${CacheDIR}/Unity/src
    cp -r Unity-master/src/* ${CacheDIR}/Unity/src/
    rm -rf Unity-master unity.zip
    echo "Unity installed in ${CacheDIR}/Unity"
else
    echo "Unity already installed in ${CacheDIR}/Unity"
fi
