cmake_minimum_required(VERSION 3.11.0)

project(CppApp LANGUAGES CXX)
set(FETCHCONTENT_QUIET OFF)

include(thirdparties/boost.cmake)
include(thirdparties/fakeit.cmake)


add_library(CppLib src/lib.cpp inc/lib.h)
target_include_directories(CppLib PUBLIC inc)
target_link_libraries(CppLib PUBLIC Boost::boost Boost::log)

add_executable(CppLibTests tests/lib.cpp)
target_link_libraries(CppLibTests CppLib Boost::unit_test_framework Fakeit)
