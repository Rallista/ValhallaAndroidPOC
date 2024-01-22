
# Set the minimum version of CMake that can be used
cmake_minimum_required(VERSION 3.14)

# Set the project name
project(valhalla_android)

# Valhalla requires at least C++17
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ language version to use (default is 17)")

# Configure Android

# WRAPPER ---------------------------------------------------------

add_subdirectory(wrapper)

# PROTOBUF ---------------------------------------------------------

# PROTOBUF OPTION A ---------------------------------------------------------

# # START - This is where we use the pre-compiled protobuf
# # TODO: Figure out why Protobuf_LITE_LIBRARIES is Not Found
# link_directories(${PROJECT_SOURCE_DIR}/build/${ANDROID_ABI}/../protobuf/protobuf-install/lib)
# find_package(Protobuf REQUIRED)
# message(STATUS "Protobuf_LIBRARIES: ${Protobuf_LIBRARIES}, ${Protobuf_LITE_LIBRARIES}")
# target_link_libraries(valhalla_wrapper PUBLIC ${Protobuf_LIBRARIES})
# # END

# PROTOBUF OPTION B ---------------------------------------------------------

message(STATUS "Protobuf fetching from github...")

# Fetch Protobuf source code
# https://cmake.org/cmake/help/latest/module/FetchContent.html#overriding-where-to-find-cmakelists-txt
include(FetchContent)
FetchContent_Declare(
    protobuf
    GIT_REPOSITORY https://github.com/protocolbuffers/protobuf.git
    GIT_TAG v3.20.3  # You can specify a particular commit or tag
    SOURCE_SUBDIR cmake
    FIND_PACKAGE_ARGS NAMES protobuf
)

message(STATUS "Protobuf fetching - done")
message(STATUS "Protobuf building...")

set(WITHPROTOC {$Protobuf_PROTOC_EXECUTABLE} CACHE INTERNAL "")
set(protobuf_BUILD_STATIC_LIBS ON CACHE INTERNAL "")
set(protobuf_BUILD_LIBPROTOC ON CACHE INTERNAL "")
set(protobuf_BUILD_PROTOC_BINARIES OFF CACHE INTERNAL "")
set(protobuf_BUILD_TESTS OFF CACHE INTERNAL "")
set(protobuf_BUILD_CONFORMANCE OFF CACHE INTERNAL "")
set(protobuf_BUILD_EXAMPLES OFF CACHE INTERNAL "")

FetchContent_MakeAvailable(Protobuf)

message(STATUS "Protobuf bulding -done")

set(Protobuf_INCLUDE_DIR ${protobuf_SOURCE_DIR}/src)
set(Protobuf_LIBRARIES protobuf::libprotobuf-lite)

include(FindProtobuf) 
find_package(Protobuf CONFIG REQUIRED)

if (NOT Protobuf_FOUND)
    message(FATAL_ERROR "Protobuf not found")
endif()

# Link Protobuf
target_link_libraries(valhalla_wrapper PRIVATE protobuf::libprotobuf)

# VALHALLA ---------------------------------------------------------

add_subdirectory(valhalla EXCLUDE_FROM_ALL)
target_link_libraries(valhalla_wrapper PRIVATE valhalla)