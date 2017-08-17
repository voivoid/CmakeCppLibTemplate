message("Making catch...")

find_package(Git REQUIRED)

set(CATCH_VER v1.9.7)
set(CATCH_DIR "${DEPENDENCIES_DIR}/Catch")

if(EXISTS ${CATCH_DIR})
    message("Catch is already cloned")
else()
    file(MAKE_DIRECTORY ${CATCH_DIR})
    execute_process(COMMAND git clone https://github.com/philsquared/Catch.git
                    WORKING_DIRECTORY ${DEPENDENCIES_DIR})
    execute_process(COMMAND git checkout ${CATCH_VER}
                    WORKING_DIRECTORY ${CATCH_DIR})
endif()

add_library(catch INTERFACE)
target_include_directories(catch INTERFACE ${CATCH_DIR}/include)



message("Making catch done")