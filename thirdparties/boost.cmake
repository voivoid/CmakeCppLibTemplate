include(FetchContent)


set(BoostVersion "1.68.0")
set(BoostLibs log test)
set(BoostSHA256 da3411ea45622579d419bfda66f45cd0f8c32a181d84adfa936f5688388995cf)
set(Boost_USE_STATIC_LIBS TRUE)



string(REPLACE . _ BoostVersionUnderscored ${BoostVersion})
FetchContent_Declare(
  boost
  URL "https://dl.bintray.com/boostorg/release/${BoostVersion}/source/boost_${BoostVersionUnderscored}.tar.gz"
  URL_HASH SHA256=${BoostSHA256}
)

message("Building Boost...")
FetchContent_Populate(boost)
FetchContent_GetProperties(boost)


set(BoostSrcDir ${boost_SOURCE_DIR})
set(BoostLibDir ${BoostSrcDir}/stage/lib)

foreach(BoostLib ${BoostLibs})
  list(APPEND BoostLibsCmdLine "--with-${BoostLib}")
endforeach()

string(REPLACE test unit_test_framework BoostComponents "${BoostLibs}")


if(DEFINED BoostLibsCmdLine)

    if(WIN32)
      set(BoostBootstrapCmd cmd /C ${BoostSrcDir}/bootstrap.bat)
      set(BoostB2 ${BoostSrcDir}/b2.exe)
    else()
      set(BoostBootstrapCmd $ENV{SHELL} ${BoostSrcDir}/bootstrap.sh)
      set(BoostB2 ${BoostSrcDir}/b2)
    endif()

    if(EXISTS ${BoostB2} )
        message("Boost is already bootstrapped")
    else()
        message("Bootstrapping boost...")
        execute_process(COMMAND ${BoostBootstrapCmd}
                        WORKING_DIRECTORY ${BoostSrcDir})
    endif()


    file(
      GLOB BoostBuiltLibs
      RELATIVE ${BoostLibDir}
      ${BoostLibDir}/*)

    set(AllLibsBuilt TRUE)
    foreach(Component ${BoostComponents})
      string(FIND "${BoostBuiltLibs}" ${Component} ComponentFound)
      if(ComponentFound EQUAL -1)
        set(AllLibsBuilt FALSE)
      endif()
    endforeach()

    if(AllLibsBuilt)
        message("Boost libraries are already built")
    else()
        message("Building boost libraries...")
        set(BoostB2Cmd ${BoostB2} ${BoostLibsCmdLine} -j 8)
        execute_process(COMMAND ${BoostB2Cmd}
                        WORKING_DIRECTORY ${BoostSrcDir})
    endif()

endif()



set(BOOST_ROOT ${BoostSrcDir})
find_package(Boost ${BoostVersion} REQUIRED COMPONENTS ${BoostComponents})

message("Building boost done")
