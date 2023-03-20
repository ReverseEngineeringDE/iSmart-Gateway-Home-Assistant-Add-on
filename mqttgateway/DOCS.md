# MG iSmart/iSmart lite (SAIC API) MQTT-Gateway for Home Assistant

This repository allows Home Assistant users to access the data of their MG5 electric (2022) car (https://www.mgmotor.de/model/mg5) via the iSmart/iSmart lite API (other models with iSmart might also work).

Main project can be found here (help needed):
[SAIC API Documentation](https://github.com/ReverseEngineeringDE/SAIC-API-Documentation)

Used .jar file based on: [saic-java-mqtt-gateway](https://github.com/ReverseEngineeringDE/SAIC-API-Documentation/tree/main/saic-java-mqtt-gateway)

This is a work in progress (WIP). In the future this will be simplified by creating a native Home Assistant Add-on repository.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]


## Overview


![Home Assistant Screenshot SAIC API](./docs/HA-Addon.jpg)


What is possible at the moment:

- Login & Read vehicle charging status endpoint (SOC, mileage...)
- 600 seconds API-Response caching (to prevent 12v battery drain of the vehicle)
- Get extended vehicleData (GPS position, door status, tire pressure...)

What is not possible at the moment:

- Send commands (pre-heat vehicle, set car-alarm...)


How it is done:
Based on the work of [SAIC API Documentation](https://github.com/ReverseEngineeringDE/SAIC-API-Documentation) I wrote a simple API-wrapper to get access to the JSON output of the Java-Application (because I am unable to translate the code to Python - help needed!).

This .jar is then packaged into a Docker container (very inefficient - I know!) and will be run by Home Assistant. You then can access the API response in Home Assistant via the [MQTT_Sensor Integration](https://www.home-assistant.io/integrations/sensor.mqtt/).

### Architecture
1. Java-Application (this add-on):
- runs in a Docker container
- connects to the SAIC API
- provides the vehicle data to your mqtt broker

2. Home Assistant (you have to configure it, see below):
- Reads the mqtt telegrams
- parses the data to sensors/entities

## Manual Installation

1. Download the latest release or clone the repository
2. Extract the folder and put it in a subfolder in your Home Assistant Add-ons folder /addons/saic. This can be done via FTP access or the add-on "Filebrowser" (search for "Filebrowser" under Settings-->Add-ons-->Filebrowser).
3. Open Settings --> Add-ons --> Button: Add-on Store --> Dot-Menu right top --> "Check for updates" to tell Home Assistant to search for the newly added Add-on
4. Install the add-on (takes up to 5-15 min on a Raspberry Pi)
5. setup config (see below) and start the add-on
6. Docker-Container should be running

## Home Assistant Sensor/Entity

Download the config-file [saic-mqtt-gateway.toml](https://github.com/ReverseEngineeringDE/SAIC-API-Documentation/blob/main/saic-java-mqtt-gateway/src/dist/etc/saic-mqtt-gateway.toml) to your HA config folder and fill in your data. You can also use [Home Assistant Secrets](https://www.home-assistant.io/docs/configuration/secrets/)).

```
[mqtt]
uri = "tcp://localhost:1883"
username = "mqtt_user"
password = "mqtt_pass"

[saic]
uri = "https://tap-eu.soimt.com"
username = "ismart_user"
password = "ismart_password"

[abrp]
api-key = "8cfc314b-03cd-4efe-ab7d-4431cd8f2e2d"

[[abrp.token]]
"vin1" = "token1"

[[abrp.token]]
"vin2" = "token2"
```
It's also possible to rename the config file and change the path in den Add-On config.

### configurations.yaml

Actually the mqtt structure is saic/vehicle/VIN/, so you need to create sensors like these in your configuration.yaml:


```
mqtt:
  sensor:
    - name: "MG5_SOC"
      state_topic: saic/vehicle/LSJExxxxxxxxxxxxxx/soc
      unit_of_measurement: "%"
    - name: "MG5_Mileage"
      state_topic: saic/vehicle/LSJExxxxxxxxxxxxxx/mileage
      unit_of_measurement: "km"
      
```
A full list of topics will be available soon. At the moment you could use an mqtt client an subscribe to saic/vehicle/LSJExxxxxxxxxxx/# to see all topics.

Restart Home Assistant after creating your config!
At the moment you will see the following log if everything works well:

```
s6-rc: info: service s6rc-oneshot-runner: starting
s6-rc: info: service s6rc-oneshot-runner successfully started
s6-rc: info: service fix-attrs: starting
s6-rc: info: service fix-attrs successfully started
s6-rc: info: service legacy-cont-init: starting
s6-rc: info: service legacy-cont-init successfully started
s6-rc: info: service legacy-services: starting
s6-rc: info: service legacy-services successfully started
```

## Issues & Feedback

Feel free to open issues to give us some feedback!

## License

Distributed under the MIT License. See [LICENSE.txt](/LICENSE.txt) for more information.

The usage of the MG iSmart System is covered by their [EULA](https://www.mgmotor.eu/ismart-eula).

Section 6 (Version: 10.2021) states:

> RESTRICTIONS: You are prohibited from renting, lending, public presentation, performance or broadcasting or any other kind of distribution of the Services. You will not, and you will not allow any person to, copy or modify the Services or any part thereof or to reverse engineer, decompile or disassemble the Services except as indispensable to install the App on your end device and to obtain the information necessary to establish the interoperability with an independently created computer programme. You may not use the Services in connection with any illegal, fraudulent, dishonest, unethical activity or behaviour and/or use the Services to store or transmit malicious code, interfere with the integrity or performance of the Services or attempt to gain unauthorised access to the Services and/or any systems or networks connected thereto. You shall keep your login credentials unavailable to others, except vis-a-vis your representatives which use the Services on behalf of you as Represented Party.

This project aims to *obtain the information necessary to establish the interoperability with an independently created computer programme* and is therefore allowed under the terms of the EULA.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
