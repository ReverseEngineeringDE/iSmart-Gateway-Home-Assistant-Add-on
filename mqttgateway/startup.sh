#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json
# SAIC Variables
#SAIC_URI="$(bashio::config 'saic_uri')"
#SAIC_USER="$(bashio::config 'saic_user')"
#SAIC_PASS="$(bashio::config 'saic_pass')"
# MQTT Variables
#MQTT_URI="$(bashio::config 'mqtt_uri')"
#MQTT_USER="$(bashio::config 'mqtt_user')"
#MQTT_PASS="$(bashio::config 'mqtt_pass')"
CONFIG="$(bashio::config 'config')"

java -jar ismart-mqtt-gateway-latest-full.jar --config ${CONFIG}

#java -jar ismart-mqtt-gateway-latest-full.jar --mqtt-uri ${MQTT_URI} --mqtt-user ${SAIC_USER} --mqtt-password ${SAIC_PASS} --saic-uri ${SAIC_URI} --saic-user ${SAIC_USER} --saic-password ${SAIC_PASS}
