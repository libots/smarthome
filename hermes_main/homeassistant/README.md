# My HA configuration...

Everything is happening on a NUC running Proxmox VE, with Home Assistant running inside a dedicated HassOS virtual machine. I'm planning to migrate over to core at some point, but that hasn't happened yet. Almost everything *else* is running on a Debian 10 VM on the same NUC. I've got a lot of Docker happening there.

## The Server

Home Assistant is running inside a virtual machine on a NUC. The hardware setup is:

* NUC10i7FNH
  * 32 GB RAM (2x 16 GB DDR4 PC4-21300)
  * 500 GB SSD (Samsung 970 EVO Plus SSD M.2)
* ConBee II
* Aeotec Z-Stick Gen 5
* HUSBZB-1: used for ZHA in HA

On the software side, the NUC is running Proxmox VE. Home Assistant is running inside a HassOS VM (https://github.com/whiskerz007/proxmox_hassos_install). While this gives me HASS add-ons, almost everything else is running as a docker container on another VM. I do like having HASS ingress for Node-RED, though, which is mostly why I keep HASS on a separate VM. The add-ons I have installed are:

* Glances
* Let's Encrypt
* Node-RED
* Portainer
* Samba share
* Terminal & SSH

## Docker Containers

These all run in a separate Debian 10 VM on the NUC. This is a select list of things that have some reasonable relation to HA and my smart home, there are other containers that are totally unrelated.

* DeCONZ
* Glances
* MariaDB
* Mosquitto
* Portainer
* Samba
* Traccar
* Traefik
* UniFi Controller
* Watchtower
* ZWave2MQTT

## Other Servers

That covers almost everything, but the NUC isn't really powerful enough for great graphics processing. I keep a separate Windows 10 machine that I run as a "server," monitored in HA using IOT Link.

* Dual E5-2680 v2 processors (10 cores each)
* 256 GB RAM (16x 16 GB DDR3 1333 MHz)
* NVIDIA GeForce GTX 550 Ti (a very old graphics card)
* Lots of hard drives and a few SSDs

The machine itself is really just used as a storage server, everything is running on VMs inside:

* Media VM for Plex and Subsonic
* Surveillance VM for Blue Iris
* Windows Server 2019

Most of these things don't interact too much with Home Assistant, but I do use Blue Iris for motion sensors over MQTT.

# Integrations

## UI Integrations
Some of these might still be configured in YAML, but they've been imported. Others, I set up in the UI from the start.
* Abode: used to capture Abode system events and as a backup to the HomeKit controller.
* AirVisual
* Alexa Media Player (https://github.com/custom-components/alexa_media_player)
* August
* Certificate Expiry
* deCONZ
* Glances
* HACS (https://hacs.xyz/)
* Home Assistant iOS
* HomeKit Controller (Abode): used as the primary method of controlling the alarm (local control is better than web).
* Internet Printing Protocol
* LIFX
* Local IP Address
* Logitech Harmony Hub
* Meteorologisk institutt
* Mobile App
* MQTT
* Nest (old school, I set it up a long time ago and as long as it works I don't have a great need to migrate to a more open thermostat)
* Node-RED (https://github.com/zachowj/hass-node-red)
* ONVIF
* RainMachine
* Roku
* Simple Icons (https://github.com/vigonotion/hass-simpleicons)
* Sonos
* TP-Link Kasa Smart
* Zigbee Home Automation

## Other Integrations
These are added in HACS but configured via YAML.
* Garbage Collection (https://github.com/bruxy70/Garbage-Collection)
* Lovelace Gen (https://github.com/thomasloven/hass-lovelace_gen)
* Lutron Caseta Smart Bridge PRO (https://github.com/upsert/lutron-caseta-pro)
* Proxmox VE (https://github.com/libots/ha-pve)
* ZHA-MAP (https://github.com/zha-ng/zha-map)

# Home Devices

## Network

* pfSense router (Protectli box)
* Netgear GS752TPP 48-port gigabit switch with PoE+
* 2x Netgear GS108PEv3 8-port gigabit switch with POE
* Access points
  * 3x UniFi UAP-AP-AC-Pro
  * 1x UniFi UAP-AP-AC-LR (connected via wireless uplink from the garage, the house has CAT-6 in every room except bathrooms)

## Thermostats

* Nest Learning Thermostat 2nd Generation
* Nest Learning Thermostat 3rd Generation

## Lights/Fans

Lights/fans with smart lights are always on: I removed the switch and spliced the wires so the only way to turn them off is at the circuit breaker. Smart lights/fans are controlled with Lutron Pico remotes mounted on the wall to look like a regular switch (it's easier than adding/expanding a wall box and running wire.)

* Lutron Caseta Smart Bridge Pro (L-BDGPRO2-WH)
* PD-FSQN-WH fan speed controls: inside fans that are wired with their own hot wire for the fan
* PD-6WCL-WH dimmer: most lights that don't have smart bulbs
* PD-5NE-WH ELV dimmer switch: one fancy LED light I have that requires it
* PD-6ANS-WH switch: used for bathroom exhaust fans
* Pico remotes
  * PJ2-4B 4-button: trigger Node-RED automations (I put cheap P-touch labels on the buttons to identify them)
  * PJ2-3BRL-WH-L01R 5-button with light engraving: trigger Node-RED for smart lights *or* as second switches within the Caseta system
  * PJ2-3BRL-WH-F01R 5-button with fan engraving: trigger Node-RED for Zigbee fans
* Zigbee
  * Wink Enabled Ceiling Fan Remote Control: used for fans that only have a single hot wire for the fan and lights
  * Philips Hue: connected via DeCONZ
  * Sengled: connected via DeCONZ
* Z-wave
  * HomeSeer HS-FLS100+ Floodlight Sensors: used to trigger automations for yard lights (these are all run by HA) and as a smart switch to turn the lights on
  * HomeSeer HS-FC200+ Fan Controller: in a weatherproof box controlling my outdoor pergola fans
  * HomeSeer HS-WD200+ Wall Dimmer: in the same box for the pergola lights
  * Honeywell 39354 on/off wall switch: basement light switch
* LIFX (wifi)

## Smart Plugs

* TP-Link HS110 (wifi)
* Zigbee
  * Sylvania 79551: mostly used to strengthen my ZHA and DeCONZ networks, but some are used for smart control
* Z-wave
  * Aeon Labs DSC06106

## Locks

* August Pro 3rd Gen: connected with z-wave and the August (cloud) integration as backup

## Security/Other Sensors

* Abode: connected to HA by the cloud integration and HomeKit
* Zigbee
  * CentraLite 3326-L motion sensor
  * CentraLite 3305-G motion sensor
  * CentraLite 3320-L door sensor
  * Aqara humidity sensor
* Z-Wave
  * HomeSeer HS-FLS100+ Floodlight Sensors: used to trigger automations for yard lights (these are all run by HA) and as a smart switch to turn the lights on
  * HomeSeer HSM200 Multi-Sensor: mostly used as a range extender

## Media

* Sonos
* Logitech Harmony remote
* Onkyo TX-RZ830

## Other

* RainMachine Pro 16
