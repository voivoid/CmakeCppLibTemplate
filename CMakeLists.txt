cmake_minimum_required(VERSION 3.11.0)

project(CppApp LANGUAGES CXX)

include(thirdparties/boost.cmake)
include(thirdparties/fakeit.cmake)


add_library(CppLib src/lib.cpp inc/CoolLib/lib.h)
target_include_directories(CppLib PUBLIC inc)
target_link_libraries(CppLib PUBLIC Boost::boost Boost::log)

add_executable(CppApp app/main.cpp)
target_link_libraries(CppApp PUBLIC CppLib)

add_executable(CppLibTests tests/lib.cpp)
target_link_libraries(CppLibTests CppLib Boost::unit_test_framework FakeIt)

find_program(ClangFormat clang-format)
if(ClangFormat)
  get_target_property(CppLibSrcs CppLib SOURCES)
  get_target_property(CppAppSrcs CppApp SOURCES)
  get_target_property(CppLibTestsSrcs CppLibTests SOURCES)
  add_custom_target(clangformat
    COMMAND clang-format  -style=Chromium -i ${CppLibSrcs} ${CppAppSrcs} ${CppLibTestsSrcs}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
endif()
