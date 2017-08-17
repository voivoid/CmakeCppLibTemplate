cmake_minimum_required(VERSION 3.8)

message("Building thirdparties...")
set(DEPENDENCIES_DIR ${CMAKE_CURRENT_BINARY_DIR}/dependencies)
include(thirdparties/boost.cmake)
include(thirdparties/catch.cmake)
include(thirdparties/fakeit.cmake)
message("Building thirdparties done")

project(CppLib LANGUAGES CXX)

set(BOOST_ROOT ${BOOST_DIR})
set(Boost_USE_STATIC_LIBS ON)
find_package(Boost REQUIRED COMPONENTS filesystem)

add_library(CppLib src/lib.cpp inc/lib.h)
target_include_directories(CppLib PUBLIC inc)
target_link_libraries(CppLib PUBLIC Boost::boost Boost::filesystem)

add_executable(CppLibTests tests/lib.cpp)
target_link_libraries(CppLibTests CppLib catch fakeit)