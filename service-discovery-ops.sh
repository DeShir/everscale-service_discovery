#!/bin/bash

set -e

function echoc {
    echo -e "\033[1;30m$1\033[0m"
}

NETWORK=https://net.ton.dev

COMPILE_DIR=./build/compile
DEPLOY_DIR=./build/deploy

SERVICE_DISCOVERY_APP=App
# shellcheck disable=SC2002
SERVICE_DISCOVERY_ADDR=$(cat "$DEPLOY_DIR/${SERVICE_DISCOVERY_APP}_genaddr.log" | grep "Raw address:" | cut -d ' ' -f 3)

function add {
    SERVICE_ADDR=$1
    SERVICE_TAGS=$2
    echoc "Add service $SERVICE_ADDR to $SERVICE_DISCOVERY_ADDR"
    # shellcheck disable=SC2002
    tonos-cli --url $NETWORK call "$SERVICE_DISCOVERY_ADDR" add "{\"service\":{\"addr\":\"$SERVICE_ADDR\",\"tags\":$SERVICE_TAGS}}" --sign "$DEPLOY_DIR/$SERVICE_DISCOVERY_APP.keys.json" --abi "$COMPILE_DIR/$SERVICE_DISCOVERY_APP.abi.json"
    echoc "Done."
}

function all {
      echoc "Fetch index"
      # shellcheck disable=SC2002
      tonos-cli --url $NETWORK run "$SERVICE_DISCOVERY_ADDR" all {} --abi "$COMPILE_DIR/$SERVICE_DISCOVERY_APP.abi.json"
      echoc "Done."
}

function find {
    SERVICE_TAGS=$1
    echoc "Add service $SERVICE_ADDR to $SERVICE_DISCOVERY_ADDR"
    # shellcheck disable=SC2002
    tonos-cli --url $NETWORK run "$SERVICE_DISCOVERY_ADDR" find "{\"tags\":$SERVICE_TAGS}" --abi "$COMPILE_DIR/$SERVICE_DISCOVERY_APP.abi.json"
    echoc "Done."
}

function remove {
    SERVICE_ADDR=$1
    echoc "Add service $SERVICE_ADDR to $SERVICE_DISCOVERY_ADDR"
    # shellcheck disable=SC2002
    tonos-cli --url $NETWORK call "$SERVICE_DISCOVERY_ADDR" remove "{\"addr\":\"$SERVICE_ADDR\"}" --sign "$DEPLOY_DIR/$SERVICE_DISCOVERY_APP.keys.json" --abi "$COMPILE_DIR/$SERVICE_DISCOVERY_APP.abi.json"
    echoc "Done."
}

case $1 in

  add)
    add "$2" "$3"
    ;;

  all)
    all
    ;;

  find)
    find "$2"
    ;;

  remove)
    remove "$2"
    ;;
esac

