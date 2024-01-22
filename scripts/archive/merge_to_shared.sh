#!/bin/bash

# Make the extract directory if it doesn't exist
mkdir -p build/android/arm64-v8a/extract
cp build/android/arm64-v8a/valhalla/src/libvalhalla.a build/android/arm64-v8a/extract/libvalhalla.a

# Step 1: Extract Object Files
cd build/android/arm64-v8a/extract
ar -x libvalhalla.a
# # ar -x build/android/armeabi-v7a/valhalla/src/libvalhalla.a

# # Step 2: Compile Object Files into a Shared Library
gcc -shared -o libvalhalla.so *.o -march=arm64-v8a -mthumb

# # Clean up the temporary object files
# rm *.o