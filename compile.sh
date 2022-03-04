#!/bin/bash

set -e

COMPILE_DIR=./build/compile
SOURCE_DIR=./src/main/solidity

function echoc {
    echo -e "\033[1;30m$1\033[0m"
}

function compile {
  echoc "Compiling... ${1}"
  everdev sol compile "$1" -o $COMPILE_DIR
}

IFS=';'
echoc "Start compiling..."
rm -rf $COMPILE_DIR
read -ra APP_PATHS <<< "$1"
for APP_PATH in "${APP_PATHS[@]}"; do
    compile "$SOURCE_DIR/$APP_PATH.sol"
done
IFS=' '
echoc "Done."
