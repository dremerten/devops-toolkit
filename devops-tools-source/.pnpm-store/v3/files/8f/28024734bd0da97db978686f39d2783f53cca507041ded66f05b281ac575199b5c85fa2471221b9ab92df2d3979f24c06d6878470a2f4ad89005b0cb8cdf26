"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.listSupportedOptions = exports.composerize = void 0;
var parser_1 = require("./parser");
var types_1 = require("./types");
var YAML = __importStar(require("yamljs"));
var deepmerge_ts_1 = require("deepmerge-ts");
var options_1 = require("./options");
var createComposeObjectStructure = function (parseResult, composeVersion) {
    var _a;
    var composeSpecification = {};
    composeSpecification = (0, deepmerge_ts_1.deepmerge)(composeSpecification, {
        version: (Math.floor(composeVersion * 10) / 10).toString(),
        services: (_a = {},
            _a[parseResult.serviceName] = {},
            _a),
    });
    var service = {};
    parseResult.properties.forEach(function (result) { return (service = (0, deepmerge_ts_1.deepmerge)(result.value, service)); });
    // @ts-ignore
    composeSpecification['services'][parseResult.serviceName] = service;
    if (parseResult.additionalComposeObjects !== undefined) {
        parseResult.additionalComposeObjects.forEach(function (obj) { return (composeSpecification = (0, deepmerge_ts_1.deepmerge)(composeSpecification, obj)); });
    }
    return composeSpecification;
};
/**
 *
 * @param command
 * @param composeVersion
 * @param debug
 */
var composerize = function (command, composeVersion, debug) {
    if (composeVersion === void 0) { composeVersion = 3.9; }
    if (debug === void 0) { debug = false; }
    var parseResult = (0, parser_1.parse)(command, debug);
    if (debug) {
        console.log('Parse result:');
        console.log(JSON.stringify(parseResult, null, 2));
    }
    var composeSpecification = createComposeObjectStructure(parseResult, composeVersion);
    return new types_1.ComposerizeResult(YAML.stringify(composeSpecification, 9, 4), parseResult.messages);
};
exports.composerize = composerize;
/**
 * Function to return all the supported (=currently implemented) options with their corresponding docker-compose equivalent.
 */
var listSupportedOptions = function () {
    return (0, options_1.getSupportedOptions)();
};
exports.listSupportedOptions = listSupportedOptions;
//# sourceMappingURL=composerize.js.map