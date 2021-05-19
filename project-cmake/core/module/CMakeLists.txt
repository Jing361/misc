GET_FILENAME_COMPONENT(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
STRING(REPLACE " " "_" ProjectId ${ProjectId})

PROJECT(${ProjectId})

FILE(GLOB SOURCE_FILES
     LIST_DIRECTORIES false
     ${PROJECT_SOURCE_DIR}/source/*)
FILE(GLOB HEADER_FILES
     LIST_DIRECTORIES false
     ${PROJECT_SOURCE_DIR}/header/*)
FILE(GLOB PRIVATE_HEADERS
     LIST_DIRECTORIES false
     ${PROJECT_SOURCE_DIR}/include/*)

LIST(LENGTH SOURCE_FILES SOURCE_COUNT)

IF(${SOURCE_COUNT} EQUAL 0)
    ADD_LIBRARY(${ProjectId} INTERFACE ${HEADER_FILES} ${PRIVATE_HEADERS})
ELSE()
    ADD_LIBRARY(${ProjectId} ${SOURCE_FILES} ${HEADER_FILES} ${PRIVATE_HEADERS})
ENDIF()

TARGET_INCLUDE_DIRECTORIES(${ProjectId}
                           PUBLIC header
                           PRIVATE include)

ADD_SUBDIRECTORY(test)

# c++20
SET_TARGET_PROPERTIES(${ProjectId} PROPERTIES
                      CXX_STANDARD 20
                      CXX_STANDARD_REQUIRED YES)
TARGET_COMPILE_FEATURES(${PROJECT_NAME}
                        PUBLIC
                        cxx_std_20)

# strong warnings
TARGET_COMPILE_OPTIONS(${ProjectId}
                       PRIVATE
                       $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:GNU>>:
                       -Wall -Wextra -pedantic>
                       $<$<CXX_COMPILER_ID:MSVC>:
                       /W4>)
