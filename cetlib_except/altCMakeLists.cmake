#-----------------------------------------------------------------------
# Create library and properties
#
add_library(cetlib_except SHARED
  coded_exception.h
  demangle.cc
  demangle.h
  exception.cc
  exception.h
  exception_collector.cc
  exception_collector.h
  )
target_include_directories(cetlib_except
  PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  )

#-----------------------------------------------------------------------
# Install
#
install(TARGETS cetlib_except
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
# Install directory for headers - do this way as we don't have
# optional headers so no filtering/selection required
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/"
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
  FILES_MATCHING PATTERN "*.h"
  PATTERN "test" EXCLUDE
  )

#-----------------------------------------------------------------------
# Create exports file(s)
include(CMakePackageConfigHelpers)

# - Common to both trees
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  COMPATIBILITY SameMajorVersion
  )

# - Build tree (EXPORT only for now, config file needs some thought,
#   dependent on the use of multiconfig)
export(EXPORT ${PROJECT_NAME}Targets
  NAMESPACE ${PROJECT_NAME}::
  FILE "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Targets.cmake"
  )

# - Install tree
configure_package_config_file("${PROJECT_SOURCE_DIR}/${PROJECT_NAME}Config.cmake.in"
  "${PROJECT_BINARY_DIR}/InstallCMakeFiles/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_CMAKEDIR}/${PROJECT_NAME}"
  PATH_VARS CMAKE_INSTALL_INCLUDEDIR
  )

install(
  FILES
    "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    "${PROJECT_BINARY_DIR}/InstallCMakeFiles/${PROJECT_NAME}Config.cmake"
  DESTINATION
    "${CMAKE_INSTALL_CMAKEDIR}/${PROJECT_NAME}"
    )

install(EXPORT ${PROJECT_NAME}Targets
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION "${CMAKE_INSTALL_CMAKEDIR}/${PROJECT_NAME}"
  )


# ======================================================================
# Testing
if(BUILD_TESTING)
  add_subdirectory(test)
endif()

