import { parse } from './parser';
import { ComposerizeResult } from './types';
import * as YAML from 'yamljs';
import { deepmerge } from 'deepmerge-ts';
import { getSupportedOptions } from './options';
var createComposeObjectStructure = function (parseResult, composeVersion) {
    var _a;
    var composeSpecification = {};
    composeSpecification = deepmerge(composeSpecification, {
        version: (Math.floor(composeVersion * 10) / 10).toString(),
        services: (_a = {},
            _a[parseResult.serviceName] = {},
            _a),
    });
    var service = {};
    parseResult.properties.forEach(function (result) { return (service = deepmerge(result.value, service)); });
    // @ts-ignore
    composeSpecification['services'][parseResult.serviceName] = service;
    if (parseResult.additionalComposeObjects !== undefined) {
        parseResult.additionalComposeObjects.forEach(function (obj) { return (composeSpecification = deepmerge(composeSpecification, obj)); });
    }
    return composeSpecification;
};
/**
 *
 * @param command
 * @param composeVersion
 * @param debug
 */
export var composerize = function (command, composeVersion, debug) {
    if (composeVersion === void 0) { composeVersion = 3.9; }
    if (debug === void 0) { debug = false; }
    var parseResult = parse(command, debug);
    if (debug) {
        console.log('Parse result:');
        console.log(JSON.stringify(parseResult, null, 2));
    }
    var composeSpecification = createComposeObjectStructure(parseResult, composeVersion);
    return new ComposerizeResult(YAML.stringify(composeSpecification, 9, 4), parseResult.messages);
};
/**
 * Function to return all the supported (=currently implemented) options with their corresponding docker-compose equivalent.
 */
export var listSupportedOptions = function () {
    return getSupportedOptions();
};
//# sourceMappingURL=composerize.js.map