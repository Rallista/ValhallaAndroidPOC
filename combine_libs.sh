#!/bin/bash

export BUILD_DIR=`pwd`/build/android

android_abis=(
    "armeabi-v7a" 
    "arm64-v8a"
    "x86"
    "x86_64"
)

for abi in "${android_abis[@]}"
do
    # Make libvalhalla.so for each output
    gcc -shared -o $BUILD_DIR/${abi}/libvalhalla.so -fPIC $BUILD_DIR/${abi}/valhalla/src/libvalhalla.a
done

# Combine all the libs into one
mkdir -p $BUILD_DIR/combined
lipo -create $BUILD_DIR/*/libvalhalla.so -output $BUILD_DIR/combined/libvalhalla.so

# Move 