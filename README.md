# Description
Use this repo to build other Github projects compatible with CMake.

# How to use this project
Create a file like `Externals.cmake`. This repo will automatically
look for `Externals.cmake`, but `-DEXTERNAL_CMAKE_FILE` can be used 
to specify a different file for this repo to look at.

## CMake command
```
configure.sh <-c|--config> <-e|--external-dir> <-d|--debug>
build.sh <-j|--parallel> <-c|--config> <-d|--debug>
install.sh <-d|--debug> <-c|--config>
```
- `<-c|--config>`: Can be `Debug` or `Release`
- `<-e|--external-dir>`: Specify the external directory where the 3rdPartyLibs will be installed
- `<-d|--debug>`: Short-hand for setting the configuration (`-c|--config`) to 'Debug'
- `<-j|--parallel>`: Specify number of threads for build to use


## Functions
The `prepare_external_library` function is what configures, builds, and installs the 3rdPartyLibrary with the specific commit, flags, and submodules needed for the library.
```
prepare_external_library(<library_name> <library_url> <library_commit> <compiler_flags> <recursive_submodule_bool> <install_subdirectory>)
```
- `<library_name>`: This is the name of the library being downloaded (sadly this needs to be exactly the name of the folder that get's installed so that we can use it in other repos appropriately.
- `<library_url>`: Github (or any git) url.
- `<library_commit>`: This is the commit that we want to build. It can be a branch, tag, or simply any commit that can be checked out by git.
- `<compiler_flags>`: These are flags that the 3rdPartyLib uses (can be optional or required).
- `<recursive_submodule_bool>`: Bool if the 3rdPartyLib has recusive submodules that need to be checked out.
- `<install_subdirectory>`: This is the path within the install directory to intall the built objects

The `prepare_header_only` function is what installs the 3rdPartyLibrary with the specific commit header file or directory specified by `PATH_TO_COPY`.
```
prepare_header_only(<library_name> <library_url> <library_commit> <files_or_folder_to_install> <install_subdirectory>)
```
- `<library_name>`: This is the name of the library being downloaded (sadly this needs to be exactly the name of the folder that get's installed so that we can use it in other repos appropriately.
- `<library_url>`: Github (or any git) url.
- `<library_commit>`: This is the commit that we want to build. It can be a branch, tag, or simply any commit that can be checked out by git.
- `<compiler_flags>`: These are flags that the 3rdPartyLib uses (can be optional or required).
- `<recursive_submodule_bool>`: Bool if the 3rdPartyLib has recusive submodules that need to be checked out.
- `<install_subdirectory>`: This is the path within the install directory to intall the built objects

The `ExternalProject_Add_StepDependencies` is used to determine the order of which libraries get's built. This maybe neccessary if a library requires another library in this list. The repo will build the libraries in parallel based on the `-j|--parallel` commandline argument, explanation is further in this README.
```
ExternalProject_Add_StepDependencies(<library_name> <dependent_stage> <dependency>)
```
- `<library_name>`: The library that has a dependency
- `<dependent_stage>`: This is the stage the dependency needs to finish before `<library_name>` can start
- `<dependency>` The library that is the dependency

## Additional
The folder `CMakeHelpers` is a directory for various useful CMake macros to make various CMake tasks just a bit easier

- `GetExternaLibs.cmake` has macro `InstallExternalLib(<external_lib> <external_lib_target>)` for installing 3rd party library's shared objects (or dynamic-link library for windows) according to the specified targets.
```
InstallExternalLib(LibDataChannel LibDataChannel::LibDataChannel) # Will install datachannel.dll
InstallExternalLib(OpenCV opencv_highgui)                         # Will install opencv_highgui.dll
InstallExternalLib(OpenCV opencv_videoio)                         # Will install opencv_videoio.dll
InstallExternalLib(OpenCV opencv_imgcodecs)                       # Will install opencv_imgcodecs.dll
InstallExternalLib(OpenCV opencv_imgproc)                         # Will install opencv_imgproc.dll
InstallExternalLib(OpenCV opencv_core)                            # Will install opencv_core.dll
```

