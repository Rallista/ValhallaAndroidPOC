#!/bin/bash

protobuf_dir=build
protobuf_version=3.20.3

# Make the outer protobuf directory
mkdir -p $protobuf_dir
cd $protobuf_dir

# Setup the ABI
android_abis=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")
android_targets=("aarch64-linux-android" "armv7a-linux-androideabi" "i686-linux-android" "x86_64-linux-android")

# Configure the ABI and target for the build
ABI=$1

# Find the android_target associated with the ABI specified as $1
for ((i=0; i<${#android_abis[@]}; i++)); do
    if [[ ${android_abis[i]} == $ABI ]]; then
        TARGET=${android_targets[i]}
        break
    fi
done

# If the TARGET is not set, exit with an error
if [[ -z $TARGET ]]; then
    echo "ABI $ABI not found in android_abis"
    exit 1
fi

# Create the output
export BUILD_DIR=`pwd`/$ABI/protobuf
mkdir -p $BUILD_DIR
echo "Building protobuf for $ABI (target: $TARGET) in $BUILD_DIR"

# Download and extract protobuf source code
wget -nc https://github.com/protocolbuffers/protobuf/releases/download/v$protobuf_version/protobuf-cpp-$protobuf_version.tar.gz
tar xvf protobuf-cpp-$protobuf_version.tar.gz -C $BUILD_DIR
cd $BUILD_DIR/protobuf-$protobuf_version

# Build protobuf
./autogen.sh
./configure --prefix=$BUILD_DIR/protobuf-install --host=$TARGET \
    --with-protoc=$BUILD_DIR/../protoc/bin/protoc \
    CFLAGS="-fPIC -DGOOGLE_PROTOBUF_NO_RTTI" CXXFLAGS="-fPIC -DGOOGLE_PROTOBUF_NO_RTTI"
make -j$(nproc)
make install
