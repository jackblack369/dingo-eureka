cmake_minimum_required(VERSION 3.23.1 FATAL_ERROR)
project(dingo-eureka C CXX)

# third-party install path
if(NOT INSTALL_PATH)
    set(INSTALL_PATH "$ENV{HOME}/.local/dingo-eureka")
endif()
message("INSTALL_PATH:${INSTALL_PATH}")

include(ExternalProject)

ExternalProject_Add(gflags
   PREFIX gflags
   SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/gflags
   CMAKE_ARGS
       -DBUILD_STATIC_LIBS=ON
       -DBUILD_TESTING=OFF
       -DINSTALL_HEADERS=ON
   CMAKE_CACHE_ARGS
       -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
       -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_PATH}
       -DCMAKE_INSTALL_LIBDIR:PATH=${INSTALL_PATH}/lib
)