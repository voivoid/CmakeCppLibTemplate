include(FetchContent)

find_package(Git REQUIRED)

set(CATCH_VER v2.2.1)

FetchContent_Declare(
    catch
    GIT_REPOSITORY https://github.com/catchorg/Catch2
    GIT_TAG ${CATCH_VER}
)

FetchContent_Populate(catch)
FetchContent_GetProperties(catch)

add_library(Catch INTERFACE)
target_include_directories(Catch INTERFACE ${catch_SOURCE_DIR}/single_include)
