#!/bin/bash

# Directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Android SDK and NDK
export ANDROID_SDK=~/Library/Android/sdk
export NDK=$ANDROID_SDK/ndk/25.0.8775105  # <-- Update with the correct NDK path

# Valhalla directory
export VALHALLA_DIR=$DIR/src/valhalla/

# Android toolchain
# TODO: Handle Windows & Linux?
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64

# Set the path to the cmake toolchain file
#export CMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake
#export CMAKE_MAKE_PROGRAM=$(which make)

# TODO: Loop over all the ABIs & build them in named directories OR just make these an argument to the script
export ABI=$1

export TARGET=armv7a-linux-androideabi
export API=28

# Toolchain binaries
export AR=$TOOLCHAIN/bin/llvm-ar
export AS=$TOOLCHAIN/bin/llvm-as
export CC=$TOOLCHAIN/bin/clang
export CXX=$TOOLCHAIN/bin/clang++
export LD=$TOOLCHAIN/bin/ld
export STRIP=$TOOLCHAIN/bin/llvm-strip

# Flags
export CFLAGS="-fPIE -fPIC"
export LDFLAGS="-pie"
export CXXFLAGS="$CFLAGS"

# Outer build directory
mkdir -p build/android && cd build/android

export PROTOBUF_DIR=`pwd`
echo "Protobuf in $PROTOBUF_DIR"

# Build directory
mkdir -p $ABI && cd $ABI

export BUILD_DIR=`pwd`
echo "Building into $BUILD_DIR"

conan profile new default --detect

# Verify that build_protoc.sh has been run
if [ ! -d "$PROTOBUF_DIR/protobuf-install" ]; then
    echo "Error: protobuf-install directory not found. Please run build_protoc.sh first."
    exit 1
fi

mkdir -p $BUILD_DIR/valhalla && cd $BUILD_DIR/valhalla

# source ./protocenable.sh
#echo $CMAKE_MAKE_PROGRAM

pwd
conan install $VALHALLA_DIR
cmake \
    -DCMAKE_BUILD_TYPE=Release -DENABLE_TOOLS=Off -DENABLE_DATA_TOOLS=Off -DENABLE_PYTHON_BINDINGS=Off -DENABLE_NODE_BINDINGS=Off -DENABLE_HTTP=Off -DENABLE_SERVICES=Off \
    -DANDROID_ABI=$ABI -DANDROID_PLATFORM=android-$API \
    -DProtobuf_INCLUDE_DIR=$PROTOBUF_DIR/protobuf-install/include -DProtobuf_LIBRARY=$PROTOBUF_DIR/protobuf-install/lib/libprotobuf.a \
    -DProtobuf_PROTOC_EXECUTABLE=$PROTOBUF_DIR/protobuf-install/bin/protoc \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -S $VALHALLA_DIR \
    -B .
    # -DCMAKE_PREFIX_PATH=$BOOST_DIR \

make -j$(nproc)
cd ..