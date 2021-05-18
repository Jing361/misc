CMAKE_MINIMUM_REQUIRED(VERSION 3.18)

GET_FILENAME_COMPONENT(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
STRING(REPLACE " " "_" ProjectId ${ProjectId})

PROJECT(${ProjectId})

FUNCTION(LOADSCRIPTS curdir)
    FILE(GLOB CmakeScripts RELATIVE ${curdir} ${curdir}/cmake/*.cmake)

    FOREACH(script ${CmakeScripts})
        MESSAGE(STATUS "Loading cmake script: ${script}")
        INCLUDE(${script})
    ENDFOREACH()
ENDFUNCTION()

LOADSCRIPTS(${CMAKE_CURRENT_SOURCE_DIR})

INCLUDE_DIRECTORIES(header)# global header.  currently just version.hh

ADD_SUBDIRECTORY(core)
