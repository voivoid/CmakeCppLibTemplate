message("Making fakeit...")

find_package(Git REQUIRED)

set(FAKEIT_VER 2.0.4)
set(FAKEIT_DIR "${DEPENDENCIES_DIR}/Fakeit")

if(EXISTS ${FAKEIT_DIR})
    message("Fakeit is already cloned")
else()
    file(MAKE_DIRECTORY ${FAKEIT_DIR})
    execute_process(COMMAND git clone https://github.com/eranpeer/FakeIt
                    WORKING_DIRECTORY ${DEPENDENCIES_DIR})
    execute_process(COMMAND git checkout ${FAKEIT_VER}
                    WORKING_DIRECTORY ${FAKEIT_DIR})
endif()

add_library(fakeit INTERFACE)
target_include_directories(catch INTERFACE ${FAKEIT_DIR}/single_header/catch)


message("Making Fakeit done")