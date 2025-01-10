#!/bin/bash
#ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=.
BUILD_FOLDER=$ROOT_DIR/build
INSTALL_FOLDER=$BUILD_FOLDER/install

CONFIG=Release
if [[ $# -gt 0 ]]
then
    key=$1
    case $key in
        -d|--debug)
        shift # Consume Argument
        CONFIG=Debug
        ;;
        -c|--config)
        shift # Consume Argument
        CONFIG="$1"
        shift # Consume Argument
        ;;
    esac
fi

mkdir -p $BUILD_FOLDER
mkdir -p $INSTALL_FOLDER
cmake --install $BUILD_FOLDER --config $CONFIG --prefix $INSTALL_FOLDER $@

