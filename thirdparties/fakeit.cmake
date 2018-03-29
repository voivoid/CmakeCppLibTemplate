include(FetchContent)

find_package(Git REQUIRED)

set(FAKEIT_VER 2.0.4)

FetchContent_Declare(
    fakeit
    GIT_REPOSITORY https://github.com/eranpeer/FakeIt
    GIT_TAG ${FAKEIT_VER}
)

FetchContent_Populate(fakeit)
FetchContent_GetProperties(fakeit)


add_library(Fakeit INTERFACE)
target_include_directories(Fakeit INTERFACE ${fakeit_SOURCE_DIR}/single_header/boost)
