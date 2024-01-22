# Valhalla Mobile Build POC

## Setup

```sh
git submodule update --init --recursive

# Build 
./build_protoc_local.sh
./build_wrapper.sh
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
* https://github.com/protocolbuffers/protobuf/issues/11671