"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.processUlimitOption = exports.processNetworkOption = exports.processStorageOption = exports.processLoggingOption = exports.processOptionWithArgs = exports.processBoolean = exports.notImplementedInCompose = exports.notYetImplemented = void 0;
var types_1 = require("./types");
var set_value_1 = __importDefault(require("set-value"));
var getValue = function (value, opt) {
    if (typeof value === 'string') {
        if (opt.multiValue) {
            if (opt.composeType !== undefined && /^\-?\d+$/.test(value)) {
                try {
                    return opt.composeType === 'int' ? [parseInt(value)] : [parseFloat(value)];
                }
                catch (e) {
                    return [value];
                }
            }
            return [value];
        }
        if (opt.composeType !== undefined && /^\-?\d+$/.test(value)) {
            try {
                return opt.composeType === 'int' ? parseInt(value) : parseFloat(value);
            }
            catch (e) {
                return value;
            }
        }
    }
    return value;
};
var notYetImplemented = function (opt) {
    return {
        type: types_1.MessageType.notImplemented,
        value: "The option \"--".concat(opt.name).concat(opt.short !== undefined ? '/-' + opt.short : '', "\" is not yet implemented."),
    };
};
exports.notYetImplemented = notYetImplemented;
var notImplementedInCompose = function (opt) {
    return {
        type: types_1.MessageType.notTranslatable,
        value: "The option \"--".concat(opt.name).concat(opt.short !== undefined ? '/-' + opt.short : '', "\" could not be translated to docker-compose.yml."),
    };
};
exports.notImplementedInCompose = notImplementedInCompose;
var processBoolean = function (opt) {
    var valueToSet = {};
    (0, set_value_1.default)(valueToSet, opt.path, true);
    return { path: opt.path, value: valueToSet, multiValue: opt.multiValue, additionalObject: undefined };
};
exports.processBoolean = processBoolean;
var processOptionWithArgs = function (opt, value) {
    var val = getValue(value, opt);
    var valueToSet = {};
    (0, set_value_1.default)(valueToSet, opt.path, val);
    return { path: opt.path, value: valueToSet, multiValue: opt.multiValue, additionalObject: undefined };
};
exports.processOptionWithArgs = processOptionWithArgs;
var processLoggingOption = function (opt, value) {
    var _a;
    var val = value.split('=');
    return (0, exports.processOptionWithArgs)(opt, (_a = {}, _a[val[0]] = val[1], _a));
};
exports.processLoggingOption = processLoggingOption;
var processStorageOption = function (opt, value) {
    var _a;
    var val = value.split('=');
    return (0, exports.processOptionWithArgs)(opt, (_a = {}, _a[val[0]] = val[1], _a));
};
exports.processStorageOption = processStorageOption;
var processNetworkOption = function (opt, value) {
    var _a, _b;
    var result = (0, exports.processOptionWithArgs)(opt, (_a = {}, _a[value] = {}, _a));
    // We have to return the networks block as additional object too
    result.additionalObject = {
        networks: (_b = {}, _b[value] = {}, _b),
    };
    return result;
};
exports.processNetworkOption = processNetworkOption;
var processUlimitOption = function (opt, value) {
    var _a, _b;
    var parts = value.match(/(?<type>[^=]+)=(?<hardLimit>[^:]+)(:(?<softLimit>\S+))?/);
    if (parts !== null) {
        if (parts.length === 5) {
            if (parts.groups.softLimit === undefined) {
                return (0, exports.processOptionWithArgs)(opt, (_a = {},
                    _a[parts.groups.type] = parseInt(parts.groups.hardLimit),
                    _a));
            }
            return (0, exports.processOptionWithArgs)(opt, (_b = {},
                _b[parts.groups.type] = {
                    hard: parseInt(parts.groups.hardLimit),
                    soft: parseInt(parts.groups.softLimit),
                },
                _b));
        }
    }
    return {
        type: types_1.MessageType.errorDuringConversion,
        value: "The option \"--".concat(opt.name).concat(opt.short !== undefined ? '/-' + opt.short : '', "\" could not be translated to docker-compose.yml. The not translatable value was \"").concat(value, "\""),
    };
};
exports.processUlimitOption = processUlimitOption;
//# sourceMappingURL=callbacks.js.map