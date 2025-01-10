###############################################
# 
# This file is not meant to be modified, but
# will automatically call a user defined 
# Externals.cmake file to configure, build, and
# install 3rdPartyLibraries into the 
# `EXTERNAL_DIRECTORY` envionmental variable 
# defined path (can be overriden by the 
# `--external-dir` command line argument.
#
###############################################

cmake_minimum_required(VERSION 3.30 FATAL_ERROR)

project(CommonBuild)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(EXTERNAL_DIRECTORY "${CMAKE_SOURCE_DIR}/3rdPartyLibs" CACHE STRING "This is the directory where the 3rdPartyLibraries will be configured, built, and installed.")
set(EXTERNAL_CMAKE_FILE "${CMAKE_SOURCE_DIR}/Externals.cmake" CACHE STRING "This is the file location of the Externals.cmake (or whatever you call it) that will be used to specify which versions of which projects from Github to configure, build, and install. Reference the example 'Externals.cmake' file.")

message(STATUS "EXTERNAL_DIRECTORY: ${EXTERNAL_DIRECTORY}")
message(STATUS "EXTERNAL_CMAKE_FILE: ${EXTERNAL_CMAKE_FILE}")

include(Config.cmake)
include(${EXTERNAL_CMAKE_FILE})

