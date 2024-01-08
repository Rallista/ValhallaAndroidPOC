#!/bin/bash

mkdir -p build/android && cd build/android

export BUILD_DIR=`pwd`

echo "Building protobuf/protoc into $BUILD_DIR"

# Download and extract protobuf source code
PROTOBUF_VERSION=3.6.1
wget -nc https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOBUF_VERSION/protobuf-cpp-$PROTOBUF_VERSION.tar.gz
tar xvf protobuf-cpp-$PROTOBUF_VERSION.tar.gz
cd protobuf-$PROTOBUF_VERSION

# Build protobuf
./autogen.sh
./configure --prefix=$BUILD_DIR/protobuf-install --host=$TARGET --with-protoc=$BUILD_DIR/protobuf-host/bin/protoc CFLAGS="-fPIC -DGOOGLE_PROTOBUF_NO_RTTI" CXXFLAGS="-fPIC -DGOOGLE_PROTOBUF_NO_RTTI"
make -j$(nproc)
make install

echo "Done building protobuf/protoc into $BUILD_DIR/protobuf-install"