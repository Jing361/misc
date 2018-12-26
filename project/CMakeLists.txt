#https://cmake.org/cmake-tutorial/
cmake_minimum_required( VERSION 3.12 )
#Project name
set( TARGET_NAME PROJECT_NAME )
project( ${TARGET_NAME} )

#C++ standard
set( CMAKE_CXX_STANDARD 17 )

#Version number
set( MAJOR_REV 0 )
set( MINOR_REV 1 )
set( INCIDENTAL_REV 0 )

find_package( OpenGL REQUIRED )

#find and get all git submodules
find_package( Git QUIET )
if( GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git" )
    option( GIT_SUBMODULE "Check submodules during build" ON )
    if( GIT_SUBMODULE )
        message( STATUS "Submodule update" )
        execute_process( COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                         WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                         RESULT_VARIABLE GIT_SUBMOD_RESULT )
        if( NOT GIT_SUBMOD_RESULT EQUAL "0" )
            message( FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules" )
        endif()
    endif()
endif()

#Check submodule
if( NOT EXISTS "${PROJECT_SOURCE_DIR}/glfw/CmakeLists.txt" )
    message( FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again." )
endif()

#header file locations
include_directories( header )
include_directories( Catch2/single_include )
include_directories( glfw/include )
include_directories( glad/include )
include_directories( datastructures/header )

#how to find project source files
#aux_source_directory( source source_location )
file( GLOB source_location source/*.cc)

#configure glfw to build for export
set(GLFW_BUILD_DOCS     OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS    OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

#add_custom_target( GLFW_TARGET COMMAND glfw/ )
#add_custom_target( GLAD_TARGET COMMAND main.py )

#build subprojects
add_subdirectory( glfw )
add_subdirectory( glad )

add_executable( ${TARGET_NAME} ${source_location} )
target_link_libraries( ${TARGET_NAME} glfw ${GLFW_LIBRARIES} ${OPENGL_LIBRARY} glad gdi32 )
message( "var test ${OPENGL_LIBRARY}" )

#add_dependencies( ${TARGET_NAME} GLFW_TARGET )

# build flags
set( DEFAULT_OPTIONS -Wall -Wextra -pedantic -std=c++17 )
set( DEBUG_OPTIONS ${DEFAULT_OPTIONS} -DDEBUG -ggdb3 )
set( RELEASE_OPTIONS ${DEFAULT_OPTIONS} -O2 -s )

#define builds
target_compile_options( ${TARGET_NAME} PUBLIC "$<$<CONFIG:DEFAULT>:${DEFAULT_OPTIONS}>" )
target_compile_options( ${TARGET_NAME} PUBLIC "$<$<CONFIG:DEBUG>:${DEBUG_OPTIONS}>" )
target_compile_options( ${TARGET_NAME} PUBLIC "$<$<CONFIG:RELEASE>:${RELEASE_OPTIONS}>" )
