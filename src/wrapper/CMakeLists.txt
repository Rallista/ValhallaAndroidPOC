
project(valhalla_wrapper)

add_library(valhalla_wrapper 
            SHARED)

target_sources(valhalla_wrapper
               PUBLIC
               main.cpp valhalla_actor.cpp)

target_include_directories(valhalla_wrapper
                           PUBLIC
                           ${CMAKE_CURRENT_SOURCE_DIR}/include)