"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.normalize = void 0;
var ip_cidr_1 = __importDefault(require("ip-cidr"));
//const IPCIDR = require('ip-cidr');
var abbreviate = function (a) {
    a = a.replace(/0000/g, 'g');
    a = a.replace(/\:000/g, ':');
    a = a.replace(/\:00/g, ':');
    a = a.replace(/\:0/g, ':');
    a = a.replace(/g/g, '0');
    a = a.replace(/^0*/, '');
    var sections = a.split(/\:/g);
    var zPreviousFlag = false;
    var zeroStartIndex = -1;
    var zeroLength = 0;
    var zStartIndex = -1;
    var zLength = 0;
    for (var i = 0; i < 8; ++i) {
        var section = sections[i];
        var zFlag = section === '0';
        if (zFlag && !zPreviousFlag) {
            zStartIndex = i;
        }
        if (!zFlag && zPreviousFlag) {
            zLength = i - zStartIndex;
        }
        if (zLength > 1 && zLength > zeroLength) {
            zeroStartIndex = zStartIndex;
            zeroLength = zLength;
        }
        zPreviousFlag = section === '0';
    }
    if (zPreviousFlag) {
        zLength = 8 - zStartIndex;
    }
    if (zLength > 1 && zLength > zeroLength) {
        zeroStartIndex = zStartIndex;
        zeroLength = zLength;
    }
    //console.log(zeroStartIndex, zeroLength);
    //console.log(sections);
    if (zeroStartIndex >= 0 && zeroLength > 1) {
        sections.splice(zeroStartIndex, zeroLength, 'g');
    }
    //console.log(sections);
    a = sections.join(':');
    //console.log(a);
    a = a.replace(/\:g\:/g, '::');
    a = a.replace(/\:g/g, '::');
    a = a.replace(/g\:/g, '::');
    a = a.replace(/g/g, '::');
    //console.log(a);
    return a;
};
var normalize = function (address) {
    if (ip_cidr_1.default.isValidCIDR(address)) {
        var cidr = new ip_cidr_1.default(address);
        var start = cidr.start();
        if (!cidr.addressStart.v4) {
            start = abbreviate(start);
        }
        return start + cidr.addressStart.subnet;
    }
    return '';
};
exports.normalize = normalize;
//# sourceMappingURL=cidr.js.map