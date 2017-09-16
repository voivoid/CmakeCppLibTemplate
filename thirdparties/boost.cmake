message("Making boost...")

set(BOOST_VERSION "1.65.1")
set(BoostComponents log)
set(BOOST_MD5 41d7542ce40e171f3f7982aff008ff0d)



foreach(Component ${BoostComponents})
  list(APPEND BoostComponentsCmdLine "--with-${Component}")
endforeach()
string(REPLACE . _ BOOST_VERSION_UNDERSCORED ${BOOST_VERSION})

set(BOOST_DIR "${DEPENDENCIES_DIR}/boost")
set(BOOST_URL "http://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_UNDERSCORED}.tar.bz2/download")
set(BOOST_TAR_FILE "${BOOST_DIR}/boost_${BOOST_VERSION_UNDERSCORED}.tar.bz2")
set(BOOST_SRC_DIR "${BOOST_DIR}/boost_${BOOST_VERSION_UNDERSCORED}")
set(BOOST_LIB_DIR "${BOOST_SRC_DIR}/stage/lib")

if(EXISTS ${BOOST_TAR_FILE})
    message("Boost archive is already downloaded")
else()
    message("Downloading boost to ${BOOST_TAR_FILE} from ${BOOST_URL}")
    file(DOWNLOAD ${BOOST_URL} ${BOOST_TAR_FILE} EXPECTED_HASH MD5=${BOOST_MD5})
endif()

if(EXISTS ${BOOST_SRC_DIR})
    message("Boost archive is already extracted")
else()
    message("Extracting boost archive")
    execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf ${BOOST_TAR_FILE}
                    WORKING_DIRECTORY ${BOOST_DIR})
endif()

if(DEFINED BoostComponentsCmdLine)
    if(WIN32)
      set(BOOST_BOOTSTRAP_CMD cmd /C ${BOOST_SRC_DIR}/bootstrap.bat)
      set(BOOST_B2 ${BOOST_SRC_DIR}/b2.exe)
    else()
      set(BOOST_BOOTSTRAP_CMD $ENV{SHELL} ${BOOST_SRC_DIR}/bootstrap.sh)
      set(BOOST_B2 ${BOOST_SRC_DIR}/b2)
    endif()

    set(BOOST_B2_CMD ${BOOST_B2} ${BoostComponentsCmdLine})

    if(EXISTS ${BOOST_B2} )
        message("Boost library is already bootstrapped")
    else()
        message("Bootstrapping boost library...")
        execute_process(COMMAND ${BOOST_BOOTSTRAP_CMD}
                        WORKING_DIRECTORY ${BOOST_SRC_DIR})
    endif()

    if(EXISTS ${BOOST_LIB_DIR})
        message("Boost library is already built")
    else()
        message("Building boost library...")
        execute_process(COMMAND ${BOOST_B2_CMD} ${BoostComponentsCmdLine}
                        WORKING_DIRECTORY ${BOOST_SRC_DIR})
    endif()
endif()

message("Building boost done")
