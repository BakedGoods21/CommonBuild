#!/bin/bash
#ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=.
BUILD_FOLDER=$ROOT_DIR/build
INSTALL_FOLDER=$BUILD_FOLDER/install

VERBOSE=FALSE
MY_CONFIG=Release
EXTERNAL_CMAKE_FILE="Externals.cmake"
CUSTOM_PREFIX=
ADDITIONAL_FLAGS=$()
while [[ $# -gt 0 ]]; do
    key=$1
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
        ADDITIONAL_FLAGS+=("$1")
        shift # Consume Argument
        ;;
    esac
done

if [ -z ${EXTERNAL_DIRECTORY} ]; then
    export EXTERNAL_DIRECTORY=${BUILD_FOLDER}/3rdPartyLibs
fi

echo "EXTERNAL_DIRECTORY: ${EXTERNAL_DIRECTORY}"
echo "EXTERNAL_CMAKE_FILE: ${EXTERNAL_CMAKE_FILE}"

(set -x; cmake -S $ROOT_DIR -B $BUILD_FOLDER -DCMAKE_BUILD_TYPE=$MY_CONFIG -DEXTERNAL_DIRECTORY=$EXTERNAL_DIRECTORY -DEXTERNAL_CMAKE_FILE=$EXTERNAL_CMAKE_FILE -DGIT_VERBOSITY=$VERBOSE -DCMAKE_INSTALL_PREFIX=${INSTALL_FOLDER} ${ADDITIONAL_FLAGS[@]})

