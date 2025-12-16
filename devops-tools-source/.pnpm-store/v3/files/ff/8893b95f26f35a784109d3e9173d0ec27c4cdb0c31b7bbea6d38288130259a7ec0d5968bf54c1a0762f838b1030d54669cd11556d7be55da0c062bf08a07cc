var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __values = (this && this.__values) || function(o) {
    var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
    if (m) return m.call(o);
    if (o && typeof o.length === "number") return {
        next: function () {
            if (o && i >= o.length) o = void 0;
            return { value: o && o[i++], done: !o };
        }
    };
    throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
};
var __read = (this && this.__read) || function (o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
};
var _this = this;
import Lexer from 'flex-js';
import { getOption } from './options';
import { MessageType, OptionType, ParseResult } from './types';
import { isResult } from './util';
import { normalize } from './cidr';
import set from 'set-value';
var SHORT_OPT_STATE = 'short-opt';
var LONG_OPT_STATE = 'long-opt';
var WAITING_FOR_ARGUMENT_STATE = 'waiting-for-arg';
var IMAGE_FOUND_STATE = 'image-found';
var QUOTED_STRING = 'quoted';
var ParserDto = /** @class */ (function (_super) {
    __extends(ParserDto, _super);
    function ParserDto() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.lexer = new Lexer();
        _this.lastOpt = undefined;
        return _this;
    }
    ParserDto.prototype.asParseResult = function () {
        var parseResult = new ParseResult();
        parseResult.serviceName = this.serviceName;
        parseResult.properties = this.properties;
        parseResult.messages = this.messages;
        parseResult.additionalComposeObjects = this.additionalComposeObjects;
        return parseResult;
    };
    return ParserDto;
}(ParseResult));
var Pattern = {
    DOCKER_CMD: /docker (run|create)/,
    STRING: /[^="][^"'\s\t\r\n]+/,
    LONG_OPT_VALUE: /[a-z][a-z0-9\-]+/,
    IMAGE_NAME: /(?:(?=[^:\/]{1,253})(?!-)[a-zA-Z0-9-]{1,63}(?<!-)(?:\.(?!-)[a-zA-Z0-9-]{1,63}(?<!-))*(?::[0-9]{1,5})?\/)?((?![._-])(?:[a-z0-9._-]*)(?<![._-])(?:\/(?![._-])[a-z0-9._-]*(?<![._-]))*)(?::(?![.-])[a-zA-Z0-9_.-]{1,128})?/,
    QUOTE_CHAR: /"/,
    LONG_OPT: /--/,
    SHORT_OPT: /-/,
    CHAR: /./,
    WS: /\s+/,
    WS_OR_EQUALS: /{WS}|=/,
};
var prepareInput = function (input) {
    return input.replace(/'/g, '"');
};
var processOption = function (parserDto) {
    var opt = getOption(parserDto.lexer.text);
    parserDto.lastOpt = opt;
    if (opt === undefined) {
        parserDto.messages.push({
            type: MessageType.errorDuringConversion,
            value: "Unknown option: ".concat(parserDto.lexer.text),
        });
    }
    else {
        if (opt.type === OptionType.withArgs) {
            parserDto.lexer.pushState(WAITING_FOR_ARGUMENT_STATE);
        }
        else {
            var result = opt.action.call(_this, opt, parserDto.lexer);
            if (result !== undefined) {
                if (isResult(result)) {
                    parserDto.properties.push(result);
                    if (result.additionalObject !== undefined) {
                        parserDto.additionalComposeObjects.push(result.additionalObject);
                    }
                }
                else {
                    parserDto.messages.push(result);
                }
            }
        }
    }
};
var processArgument = function (value, parserDto) {
    if (parserDto.lastOpt === undefined) {
        parserDto.messages.push({
            type: MessageType.errorDuringConversion,
            value: "Error while parsing. Got option value '".concat(value, "' 'but no option the value belongs to."),
        });
        return;
    }
    var result = parserDto.lastOpt.action.call(_this, parserDto.lastOpt, value, parserDto.lexer);
    if (result !== undefined) {
        if (isResult(result)) {
            parserDto.properties.push(result);
            if (result.additionalObject !== undefined) {
                parserDto.additionalComposeObjects.push(result.additionalObject);
            }
        }
        else {
            parserDto.messages.push(result);
        }
    }
};
var prepareLexer = function (debug) {
    var e_1, _a;
    var parserDto = new ParserDto();
    var lexer = parserDto.lexer;
    var properties = parserDto.properties;
    // options
    lexer.setIgnoreCase(false);
    lexer.setDebugEnabled(debug);
    // states
    lexer.addState(QUOTED_STRING, true);
    lexer.addState(SHORT_OPT_STATE, true);
    lexer.addState(LONG_OPT_STATE, true);
    lexer.addState(WAITING_FOR_ARGUMENT_STATE, true);
    lexer.addState(IMAGE_FOUND_STATE, true);
    try {
        // definitions
        for (var _b = __values(Object.entries(Pattern)), _c = _b.next(); !_c.done; _c = _b.next()) {
            var _d = __read(_c.value, 2), name = _d[0], regexp = _d[1];
            lexer.addDefinition(name, regexp);
        }
    }
    catch (e_1_1) { e_1 = { error: e_1_1 }; }
    finally {
        try {
            if (_c && !_c.done && (_a = _b.return)) _a.call(_b);
        }
        finally { if (e_1) throw e_1.error; }
    }
    // rules
    // Commands always begin with "docker run" or "docker create"
    lexer.addRule(Pattern.DOCKER_CMD);
    // ignore Whitespaces
    lexer.addRule(Pattern.WS);
    // Recognize short options
    lexer.addRule(Pattern.SHORT_OPT, function (lexer) { return lexer.begin(SHORT_OPT_STATE); });
    // Recognize long options
    lexer.addRule(Pattern.LONG_OPT, function (lexer) { return lexer.begin(LONG_OPT_STATE); });
    // Handle quoted strings
    var str = '';
    lexer.addStateRule(WAITING_FOR_ARGUMENT_STATE, Pattern.QUOTE_CHAR, function (lexer) { return lexer.pushState(QUOTED_STRING); });
    lexer.addStateRule(QUOTED_STRING, Pattern.QUOTE_CHAR, function (lexer) {
        lexer.popState();
        var token = str;
        str = '';
        if (lexer.state == WAITING_FOR_ARGUMENT_STATE) {
            processArgument(token, parserDto);
            lexer.begin(Lexer.STATE_INITIAL);
        }
    });
    lexer.addStateRule(QUOTED_STRING, /[^\n\"]+/, function (lexer) {
        str += lexer.text;
    });
    // Rules to process short options
    lexer.addStateRule(SHORT_OPT_STATE, Pattern.WS, function (lexer) { return lexer.begin(Lexer.STATE_INITIAL); });
    lexer.addStateRule(SHORT_OPT_STATE, Pattern.CHAR, function () { return processOption(parserDto); });
    // Rules to process long options
    lexer.addStateRule(LONG_OPT_STATE, Pattern.LONG_OPT_VALUE, function () { return processOption(parserDto); });
    lexer.addStateRule(LONG_OPT_STATE, Pattern.WS, function (lexer) { return lexer.begin(Lexer.STATE_INITIAL); });
    // Process the arguments for an option
    lexer.addStateRule(WAITING_FOR_ARGUMENT_STATE, Pattern.WS_OR_EQUALS);
    lexer.addStateRule(WAITING_FOR_ARGUMENT_STATE, Pattern.STRING, function (lexer) {
        processArgument(lexer.text.trim(), parserDto);
        lexer.begin(Lexer.STATE_INITIAL);
    });
    lexer.addStateRule(WAITING_FOR_ARGUMENT_STATE, Pattern.CHAR, function () {
        parserDto.messages.push({
            type: MessageType.errorDuringConversion,
            // @ts-ignore
            value: "The option \"--".concat(parserDto.lastOpt.name).concat(
            // @ts-ignore
            parserDto.lastOpt.short !== undefined ? '/-' + parserDto.lastOpt.short : '', "\""),
        });
    });
    // Recognize image
    lexer.addStateRule(Lexer.STATE_INITIAL, Pattern.IMAGE_NAME, function (lexer) {
        lexer.begin(IMAGE_FOUND_STATE);
        var imageName = lexer.text;
        parserDto.serviceName = getServiceName(imageName);
        var valueToSet = {};
        set(valueToSet, 'image', imageName);
        properties.push({
            path: 'image',
            value: valueToSet,
            multiValue: false,
            additionalObject: undefined,
        });
    });
    // Get docker command
    lexer.addStateRule(IMAGE_FOUND_STATE, / .*/, function (lexer) {
        var valueToSet = {};
        set(valueToSet, 'command', lexer.text.trim());
        properties.push({
            path: 'command',
            value: valueToSet,
            multiValue: false,
            additionalObject: undefined,
        });
        lexer.terminate();
    });
    return parserDto;
};
var tokenize = function (lexer, input) {
    lexer.setSource(input);
    lexer.lexAll();
};
var postProcessNetworkOption = function (dto) {
    var _a;
    var network = dto.properties.find(function (result) { return result.path === 'networks'; });
    var networkName = 'default';
    if (network !== undefined) {
        // @ts-ignore
        networkName = Object.keys(network.value['networks'])[0];
        // custom network name present
        var networkRelatedProperties_1 = dto.properties.filter(function (result) { return result.path.startsWith('networks') && result.path !== 'networks'; });
        networkRelatedProperties_1.forEach(function (result) {
            // @ts-ignore
            var obj = result.value['networks'];
            // @ts-ignore
            Object.defineProperty(obj, networkName, Object.getOwnPropertyDescriptor(obj, 'default'));
            delete obj['default'];
        });
    }
    var specificIpAddresses = [];
    var networkRelatedProperties = dto.properties.filter(function (result) { return result.path.startsWith('networks') && result.path !== 'networks'; });
    networkRelatedProperties.forEach(function (result) {
        if (result.path.includes('ipv4_address')) {
            // @ts-ignore
            specificIpAddresses.push(result.value.networks[networkName].ipv4_address + '/24');
        }
        if (result.path.includes('ipv6_address')) {
            // @ts-ignore
            specificIpAddresses.push(result.value.networks[networkName].ipv6_address + '/64');
        }
    });
    if (specificIpAddresses.length > 0) {
        var additionalNetworkConfig_1 = {
            networks: (_a = {},
                _a[networkName] = {
                    driver: 'default',
                    config: [],
                },
                _a),
        };
        specificIpAddresses.forEach(function (address) {
            // @ts-ignore
            additionalNetworkConfig_1.networks[networkName].config.push({ subnet: getCidr(address) });
        });
        dto.additionalComposeObjects.push(additionalNetworkConfig_1);
    }
};
var getCidr = function (ip) {
    return normalize("".concat(ip));
};
var getServiceName = function (image) {
    var name = image.includes('/') ? image.split('/')[1] : image;
    name = name.includes(':') ? name.split(':')[0] : name;
    return name;
};
export var parse = function (command, debug) {
    var preparedInput = prepareInput(command);
    var parserDto = prepareLexer(debug);
    tokenize(parserDto.lexer, preparedInput);
    postProcessNetworkOption(parserDto);
    return parserDto.asParseResult();
};
//# sourceMappingURL=parser.js.map