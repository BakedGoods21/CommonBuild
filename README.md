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


## Functions
The `prepare_external_library` function is what configures, builds, and installs the 3rdPartyLibrary with the specific commit, flags, and submodules needed for the library.
```
prepare_external_library(<library_name> <library_url> <library_commit> <compiler_flags> <recursive_submodule_bool>)
```
- `<library_name>`: This is the name of the library being downloaded (sadly this needs to be exactly the name of the folder that get's installed so that we can use it in other repos appropriately.
- `<library_url>`: Github (or any git) url.
- `<library_commit>`: This is the commit that we want to build. It can be a branch, tag, or simply any commit that can be checked out by git.
- `<compiler_flags>`: These are flags that the 3rdPartyLib uses (can be optional or required).
- `<recursive_submodule_bool>`: Bool if the 3rdPartyLib has recusive submodules that need to be checked out.

The `ExternalProject_Add_StepDependencies` is used to determine the order of which libraries get's built. This maybe neccessary if a library requires another library in this list. The repo will build the libraries in parallel based on the `-j|--parallel` commandline argument, explanation is further in this README.
```
ExternalProject_Add_StepDependencies(<library_name> <dependent_stage> <dependency>)
```
- `<library_name>`: The library that has a dependency
- `<dependent_stage>`: This is the stage the dependency needs to finish before `<library_name>` can start
- `<dependency>` The library that is the dependency

