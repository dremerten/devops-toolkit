import { MessageType } from './types';
import set from 'set-value';
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
export var notYetImplemented = function (opt) {
    return {
        type: MessageType.notImplemented,
        value: "The option \"--".concat(opt.name).concat(opt.short !== undefined ? '/-' + opt.short : '', "\" is not yet implemented."),
    };
};
export var notImplementedInCompose = function (opt) {
    return {
        type: MessageType.notTranslatable,
        value: "The option \"--".concat(opt.name).concat(opt.short !== undefined ? '/-' + opt.short : '', "\" could not be translated to docker-compose.yml."),
    };
};
export var processBoolean = function (opt) {
    var valueToSet = {};
    set(valueToSet, opt.path, true);
    return { path: opt.path, value: valueToSet, multiValue: opt.multiValue, additionalObject: undefined };
};
export var processOptionWithArgs = function (opt, value) {
    var val = getValue(value, opt);
    var valueToSet = {};
    set(valueToSet, opt.path, val);
    return { path: opt.path, value: valueToSet, multiValue: opt.multiValue, additionalObject: undefined };
};
export var processLoggingOption = function (opt, value) {
    var _a;
    var val = value.split('=');
    return processOptionWithArgs(opt, (_a = {}, _a[val[0]] = val[1], _a));
};
export var processStorageOption = function (opt, value) {
    var _a;
    var val = value.split('=');
    return processOptionWithArgs(opt, (_a = {}, _a[val[0]] = val[1], _a));
};
export var processNetworkOption = function (opt, value) {
    var _a, _b;
    var result = processOptionWithArgs(opt, (_a = {}, _a[value] = {}, _a));
    // We have to return the networks block as additional object too
    result.additionalObject = {
        networks: (_b = {}, _b[value] = {}, _b),
    };
    return result;
};
export var processUlimitOption = function (opt, value) {
    var _a, _b;
    var parts = value.match(/(?<type>[^=]+)=(?<hardLimit>[^:]+)(:(?<softLimit>\S+))?/);
    if (parts !== null) {
        if (parts.length === 5) {
            if (parts.groups.softLimit === undefined) {
                return processOptionWithArgs(opt, (_a = {},
                    _a[parts.groups.type] = parseInt(parts.groups.hardLimit),
                    _a));
            }
            return processOptionWithArgs(opt, (_b = {},
                _b[parts.groups.type] = {
                    hard: parseInt(parts.groups.hardLimit),
                    soft: parseInt(parts.groups.softLimit),
                },
                _b));
        }
    }
    return {
        type: MessageType.errorDuringConversion,
        value: "The option \"--".concat(opt.name).concat(opt.short !== undefined ? '/-' + opt.short : '', "\" could not be translated to docker-compose.yml. The not translatable value was \"").concat(value, "\""),
    };
};
//# sourceMappingURL=callbacks.js.map