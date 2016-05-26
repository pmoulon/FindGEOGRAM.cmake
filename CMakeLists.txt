
cmake_minimum_required(VERSION 2.8.11)

SET(CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR})

FIND_PACKAGE(GEOGRAM)
if (GEOGRAM_FOUND)
  include_directories(${GEOGRAM_INCLUDE_DIR})
  add_executable(main_demo main.cpp)
  target_link_libraries(main_demo ${GEOGRAM_LIBRARIES})
endif()
