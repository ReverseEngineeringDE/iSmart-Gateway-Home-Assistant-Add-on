#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json
CONFIG="$(bashio::config 'config')"

java -jar ismart-mqtt-gateway-latest-full.jar --config ${CONFIG}
