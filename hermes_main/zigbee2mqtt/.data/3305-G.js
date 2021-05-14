// 3305-G
// CentraLite

const fz = require('zigbee-herdsman-converters/converters/fromZigbee');
const tz = require('zigbee-herdsman-converters/converters/toZigbee');
const exposes = require('zigbee-herdsman-converters/lib/exposes');
const reporting = require('zigbee-herdsman-converters/lib/reporting');
const extend = require('zigbee-herdsman-converters/lib/extend');
const e = exposes.presets;
const ea = exposes.access;

const definition = {
    zigbeeModel: ['3305-G'],
    model: '3305-G',
    vendor: 'CentraLite',
    description: 'Motion sensor (2014 model)',
    fromZigbee: [fz.temperature, fz.ias_occupancy_alarm_2, fz.battery],
    toZigbee: [],
    meta: {battery: {voltageToPercentage: '3V_2500'}},
    configure: async (device, coordinatorEndpoint, logger) => {
        const endpoint = device.getEndpoint(1);
        await reporting.bind(endpoint, coordinatorEndpoint, ['msTemperatureMeasurement', 'genPowerCfg']);
        await reporting.temperature(endpoint);
        await reporting.batteryVoltage(endpoint);
    },
    exposes: [e.temperature(), e.occupancy(), e.battery_low(), e.tamper(), e.battery()],
};

module.exports = definition;