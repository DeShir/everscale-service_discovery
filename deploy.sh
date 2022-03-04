#!/bin/bash

set -e

function echoc {
    echo -e "\033[1;30m$1\033[0m"
}

NETWORK=https://net.ton.dev
GIVER_ADDR=0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94

COMPILE_DIR=./build/compile
DEPLOY_DIR=./build/deploy

function deploy {
    APP_NAME=$1
    echoc "Start to generate $APP_NAME address"
    tonos-cli genaddr "$COMPILE_DIR/$APP_NAME.tvc" "$COMPILE_DIR/$APP_NAME.abi.json" --genkey "$DEPLOY_DIR/$APP_NAME.keys.json" > "$DEPLOY_DIR/${APP_NAME}_genaddr.log"
    # shellcheck disable=SC2002
    APP_ADDR=$(cat "$DEPLOY_DIR/${APP_NAME}_genaddr.log" | grep "Raw address:" | cut -d ' ' -f 3)
    echoc "address: $APP_ADDR"
    echoc "Done."

    echoc "Ask Giver to send grams"
    tonos-cli --url $NETWORK call --abi ./conf/giver.abi.json $GIVER_ADDR sendGrams "{\"dest\":\"$APP_ADDR\",\"amount\":10000000000}"
    echoc "Done."

    echoc "Deploying $APP_NAME"
    tonos-cli --url $NETWORK deploy "$COMPILE_DIR/$APP_NAME.tvc" "{}" --sign "$DEPLOY_DIR/$APP_NAME.keys.json" --abi "$COMPILE_DIR/$APP_NAME.abi.json"
}

echoc "Deploying apps..."
rm -rf $DEPLOY_DIR
mkdir $DEPLOY_DIR

IFS=';'
read -ra APP_NAMES <<< "$1"
for APP_NAME in "${APP_NAMES[@]}"; do
    deploy "$APP_NAME"
done
IFS=' '
echoc "Done."
