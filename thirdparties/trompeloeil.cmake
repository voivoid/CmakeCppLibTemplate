include(FetchContent)

find_package(Git REQUIRED)

set(TrompeloeilVer v30)

FetchContent_Declare(
    trompeloeil
    GIT_REPOSITORY https://github.com/rollbear/trompeloeil
    GIT_TAG ${TrompeloeilVer}
)

message("Building Trompeloeil...")
FetchContent_Populate(trompeloeil)
FetchContent_GetProperties(trompeloeil)

add_subdirectory(${trompeloeil_SOURCE_DIR} ${trompeloeil_BINARY_DIR})

message("Building Trompeloeil done")
