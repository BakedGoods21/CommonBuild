#!/bin/bash
#ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=.
BUILD_FOLDER=$ROOT_DIR/build
INSTALL_FOLDER=$BUILD_FOLDER/install

VERBOSE=FALSE
MY_CONFIG=Release
EXTERNAL_CMAKE_FILE="Externals.cmake"
while [[ $# -gt 0 ]]; do
    key=$1
    echo "key $key"
    echo "\$\# $#"
    case $key in
	-v|--verbose)
	shift # Consume Argument
	VERBOSE=TRUE
	;;
        -e|--external-dir)
        shift # Consome Argument
        EXTERNAL_DIRECTORY="$1"
        shift # Consome Argument
        ;;
        -f|--external-cmake-file)
        shift # Consome Argument
        EXTERNAL_CMAKE_FILE="$1"
        shift # Consome Argument
        ;;
        -c|--config)
        shift # Consume Argument
        MY_CONFIG="$1"
        shift # Consume Argument
        ;;
        -d|--debug)
        shift # Consume Argument
        MY_CONFIG=Debug
        ;;
        *)
        break;
        ;;
    esac
done

if [ -z ${EXTERNAL_DIRECTORY} ]; then
    echo "'EXTERNAL_DIRECTORY' environment variable or commandline argument not found!"
    echo "Defaulting to './build'..."
    export EXTERNAL_DIRECTORY=./3rdPartyLibs
fi

echo "EXTERNAL_DIRECTORY: ${EXTERNAL_DIRECTORY}"
echo "EXTERNAL_CMAKE_FILE: ${EXTERNAL_CMAKE_FILE}"
echo "cmake -S $ROOT_DIR -B $BUILD_FOLDER -DCMAKE_BUILD_TYPE=$MY_CONFIG -DEXTERNAL_DIRECTORY=$EXTERNAL_DIRECTORY -DGIT_VERBOSITY=$VERBOSE -DCMAKE_INSTALL_PREFIX=${INSTALL_FOLDER} $@"
cmake -S $ROOT_DIR -B $BUILD_FOLDER -DCMAKE_BUILD_TYPE=$MY_CONFIG -DEXTERNAL_DIRECTORY=$EXTERNAL_DIRECTORY -DEXTERNAL_CMAKE_FILE=$EXTERNAL_CMAKE_FILE -DGIT_VERBOSITY=$VERBOSE -DCMAKE_INSTALL_PREFIX=${INSTALL_FOLDER} $@

