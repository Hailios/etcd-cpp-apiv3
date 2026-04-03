# - Config file for the etcd-cpp-apiv3 package
#
# It defines the following variables
#
#  ETCD_CPP_INCLUDE_DIR         - include directory for etcd
#  ETCD_CPP_INCLUDE_DIRS        - include directories for etcd
#  ETCD_CPP_LIBRARIES           - libraries to link against

# find dependencies
include(CMakeFindDependencyMacro)
find_dependency(Protobuf)
find_package(gRPC QUIET)
if(NOT gRPC_FOUND)
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
    find_dependency(GRPC)
endif()

find_dependency(cpprestsdk)
if(cpprestsdk_FOUND)
    set(CPPREST_LIB cpprestsdk::cpprest)
endif()

set(ETCD_CPP_HOME "${CMAKE_CURRENT_LIST_DIR}/../../..")
#include("${CMAKE_CURRENT_LIST_DIR}/etcd-targets.cmake")

message(STATUS "Looking for etcd-targets.cmake in: ${CMAKE_CURRENT_LIST_DIR}")
#file(GLOB TARGETS_FILE "${CMAKE_CURRENT_LIST_DIR}/cpprestsdk-targets.cmake")
#if(TARGETS_FILE)
#  message(STATUS "Found cpprestsdk-targets.cmake at: ${TARGETS_FILE}")
#  include("${TARGETS_FILE}")
#else()
#  message(FATAL_ERROR "cpprestsdk-targets.cmake not found in ${CMAKE_CURRENT_LIST_DIR}")
#endif()

#set(TARGETS_FILE "${CMAKE_CURRENT_LIST_DIR}/../../CMakeFiles/Export/0f425fe7e2467babc1de94b92f87002d/cpprestsdk-targets.cmake")
set(TARGETS_FILE "${CMAKE_CURRENT_LIST_DIR}/CMakeFiles/Export/09a1cce3d3c3326e68846f694d0a26ca/etcd-targets.cmake")
if(EXISTS "${TARGETS_FILE}")
    message(STATUS "Found targets file at: ${TARGETS_FILE}")
    include("${TARGETS_FILE}")
else()
    message(FATAL_ERROR "Targets file NOT found at: ${TARGETS_FILE}")
endif()


set(etcd-cpp-api_FOUND TRUE)
set(ETCD_CPP_LIBRARIES etcd-cpp-api)
set(ETCD_CPP_CORE_LIBRARIES etcd-cpp-api-core)
set(ETCD_CPP_INCLUDE_DIR "${ETCD_CPP_HOME}/include")
set(ETCD_CPP_INCLUDE_DIRS "${ETCD_CPP_INCLUDE_DIR}")
message("ffff ETCD_CPP_INCLUDE_DIR: ${ETCD_CPP_INCLUDE_DIR}")

include(FindPackageMessage)
find_package_message(etcd
    "Found etcd: ${CMAKE_CURRENT_LIST_FILE} (found version \"@etcd-cpp-api_VERSION@\")"
    "etcd-cpp-apiv3 version: @etcd-cpp-api_VERSION@\n"
    "etcd-cpp-apiv3 libraries: ${ETCD_CPP_LIBRARIES}\n"
    "etcd-cpp-apiv3 core libraries: ${ETCD_CPP_CORE_LIBRARIES}\n"
    "include directories: ${ETCD_CPP_INCLUDE_DIRS}"
)
