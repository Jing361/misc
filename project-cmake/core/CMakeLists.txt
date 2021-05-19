MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
      LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO()

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR})

FOREACH(subdir ${SUBDIRS})
  MESSAGE(STATUS "Configuring ${subdir}")
  ADD_SUBDIRECTORY(${subdir})
ENDFOREACH()

# It might be cool to turn the contents of module/CMakeLists.txt into a function
#   or macro or something, and basically traverse the entire project from here
