include(FetchContent)


set(BOOST_VERSION "1.66.0")
set(BOOST_COMPONENTS log test)
set(Boost_USE_STATIC_LIBS TRUE)
set(BOOST_SHA256 bd0df411efd9a585e5a2212275f8762079fed8842264954675a4fddc46cfcf60)



string(REPLACE . _ BOOST_VERSION_UNDERSCORED ${BOOST_VERSION})
FetchContent_Declare(
  boost
  URL "https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_UNDERSCORED}.tar.gz"
  URL_HASH SHA256=${BOOST_SHA256}
)

message("Building boost...")
FetchContent_Populate(boost)
FetchContent_GetProperties(boost)


set(BOOST_SRC_DIR ${boost_SOURCE_DIR})
set(BOOST_LIB_DIR ${BOOST_SRC_DIR}/stage/lib)

foreach(COMPONENT ${BOOST_COMPONENTS})
  list(APPEND BOOST_COMPONENTS_CMD_LINE "--with-${COMPONENT}")
endforeach()


if(DEFINED BOOST_COMPONENTS_CMD_LINE)

    if(WIN32)
      set(BOOST_BOOTSTRAP_CMD cmd /C ${BOOST_SRC_DIR}/bootstrap.bat)
      set(BOOST_B2 ${BOOST_SRC_DIR}/b2.exe)
    else()
      set(BOOST_BOOTSTRAP_CMD $ENV{SHELL} ${BOOST_SRC_DIR}/bootstrap.sh)
      set(BOOST_B2 ${BOOST_SRC_DIR}/b2)
    endif()

    if(EXISTS ${BOOST_B2} )
        message("Boost library is already bootstrapped")
    else()
        message("Bootstrapping boost library...")
        execute_process(COMMAND ${BOOST_BOOTSTRAP_CMD}
                        WORKING_DIRECTORY ${BOOST_SRC_DIR})
    endif()



    set(BOOST_B2_CMD ${BOOST_B2} ${BOOST_COMPONENTS_CMD_LINE} -j 8)

    if(EXISTS ${BOOST_LIB_DIR})
        message("Boost library is already built")
    else()
        message("Building boost library...")
        execute_process(COMMAND ${BOOST_B2_CMD}
                        WORKING_DIRECTORY ${BOOST_SRC_DIR})
    endif()

endif()



set(BOOST_ROOT ${BOOST_SRC_DIR})

string(REPLACE test unit_test_framework BOOST_COMPONENTS "${BOOST_COMPONENTS}")
find_package(Boost 1.66.0 REQUIRED COMPONENTS ${BOOST_COMPONENTS})

message("Building boost done")
