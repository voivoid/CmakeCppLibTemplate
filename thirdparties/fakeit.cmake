include(FetchContent)

find_package(Git REQUIRED)

set(FakeItVer 2.0.4)

FetchContent_Declare(
    fakeit
    GIT_REPOSITORY https://github.com/eranpeer/FakeIt
    GIT_TAG ${FakeItVer}
)

message("Building FakeIt...")
FetchContent_Populate(fakeit)
FetchContent_GetProperties(fakeit)


add_library(FakeIt INTERFACE IMPORTED)
target_include_directories(FakeIt INTERFACE ${fakeit_SOURCE_DIR}/single_header/boost)
message("Building FakeIt done")
