# Valhalla Mobile Build POC

## Setup

```sh
git submodule update --init --recursive

# Build 
./build_protoc.sh
./build_android.sh armeabi-v7a
./build_android.sh arm64-v8a
./build_android.sh x86
./build_android.sh x86_64
./combine_libs.sh # Fails with `ld: archive member '/' not a mach-o file`
```

## "Valhalla Min" Requirements for Mobile Routing

This is a guestimate list (this was pulled from my swift package)

* `src/baldr`
* `src/loki`
* `src/meili`
* `src/midgard`
* `src/odin`
* `src/proto`
* `src/sif`
* `src/skadi`
* `src/thor`
* `src/tyr`
* `src/proto_conversions.cc`
* `src/worker.cc`
* `src/filesystem.cc`

### TODO

- [ ] Handle NDKs on different platforms (linux, windows)?
- [ ] Build all android archs (armeabi-v7a, arm64-v8a, x86, x86_64)
- [ ] Combine libvalhalla into single libvalhalla.so?
- [ ] All the JNI stuff... OR figure out how to autogenerate the JNI definitions?

### References
 
* https://github.com/valhalla/valhalla/issues/4131
* https://stackoverflow.com/questions/69730296/libvalhalla-cmake-link-static-library-android