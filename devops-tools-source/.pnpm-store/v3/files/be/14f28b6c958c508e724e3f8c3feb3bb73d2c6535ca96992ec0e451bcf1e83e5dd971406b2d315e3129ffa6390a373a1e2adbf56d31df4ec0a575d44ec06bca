import IPCIDR from 'ip-cidr';
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
export var normalize = function (address) {
    if (IPCIDR.isValidCIDR(address)) {
        var cidr = new IPCIDR(address);
        var start = cidr.start();
        if (!cidr.addressStart.v4) {
            start = abbreviate(start);
        }
        return start + cidr.addressStart.subnet;
    }
    return '';
};
//# sourceMappingURL=cidr.js.map