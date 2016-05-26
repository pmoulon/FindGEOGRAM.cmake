################################################################################
# - FindGEOGRAM.cmake
################################################################################
# Find the GEOGRAM includes and librar(y/ies)
################################################################################
# This module defines
#  GEOGRAM_INCLUDE_DIRS, where to find geogram/mesh/mesh.h.
#  GEOGRAM_LIBRARIES, the libraries needed to use GEOGRAM.
#  GEOGRAM_FOUND, If false, do not try to use GEOGRAM.
#
# Author: Pierre Moulon
# Date: 2016
#-------------------------------------------------------------------------------

#Find GEOGRAM includes
find_path(GEOGRAM_DIR "geogram/mesh/mesh.h"
    HINTS "${GEOGRAM_ROOT}" "$ENV{GEOGRAM_ROOT}"
    PATHS "$ENV{PROGRAMFILES}" "$ENV{PROGRAMW6432}" "/usr" "/usr/local"
    PATH_SUFFIXES "include"
    DOC "Root directory of Geogram library")

#Find GEOGRAM libraries (libgeogram & libgeogram_gfx)
find_library(
  GEOGRAM_LIBRARY
  NAMES libgeogram libgeogram.so
  HINTS ${GEOGRAM_ROOT} "$ENV{GEOGRAM_ROOT}" 
  PATHS "/usr/lib"
  PATH_SUFFIXES "lib")

find_library(
  GEOGRAM_LIBRARY_GFX 
  NAMES libgeogram_gfx libgeogram_gfx.so
  HINTS ${GEOGRAM_ROOT} "$ENV{GEOGRAM_ROOT}" 
  PATHS "/usr/lib"
  PATH_SUFFIXES "lib")

##==============================================================================
## Check if GEOGRAM library was found & configure the required cmake variables
##------------------------------------------------------------------------------
if(EXISTS "${GEOGRAM_DIR}"
   AND EXISTS "${GEOGRAM_LIBRARY}"
   AND NOT "${GEOGRAM_DIR}" STREQUAL ""
  )
  # required path & libraries are found / configure the required cmake variables
  set(GEOGRAM_FOUND TRUE)
  set(GEOGRAM_INCLUDE_DIRS ${GEOGRAM_DIR})
  set(GEOGRAM_DIR "${GEOGRAM_DIR}" CACHE PATH "" FORCE)
  mark_as_advanced(GEOGRAM_DIR)
  set(GEOGRAM_INCLUDE_DIR ${GEOGRAM_DIR})

if (EXISTS "${GEOGRAM_LIBRARY}")
  set(GEOGRAM_LIBRARIES "${GEOGRAM_LIBRARY}")
endif()
if (EXISTS "${GEOGRAM_LIBRARY_GFX}")
  list(APPEND GEOGRAM_LIBRARIES "${GEOGRAM_LIBRARY_GFX}")
endif()

  message(STATUS "GEOGRAM found in: ${GEOGRAM_INCLUDE_DIRS}")
  message(STATUS "GEOGRAM libraries: ${GEOGRAM_LIBRARIES}")

else()

  if(GEOGRAM_FIND_REQUIRED)
    message(FATAL_ERROR "GEOGRAM required, but not found:\n"
    "Please specify GEOGRAM directory using GEOGRAM_ROOT env. variable")
  else()
    message(STATUS "WARNING: GEOGRAM was not found:\n"
    "Please specify GEOGRAM directory using GEOGRAM_ROOT env. variable")
  endif()

endif()
##==============================================================================
