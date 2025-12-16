"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.OptionType = exports.ParseResult = exports.MessageType = exports.SupportedOption = exports.ComposerizeResult = void 0;
/**
 * The result of a conversion. The result contains the docker-compose.yml and
 * additional {@link Message}s.
 */
var ComposerizeResult = /** @class */ (function () {
    function ComposerizeResult(yaml, messages) {
        this.yaml = yaml;
        this.messages = messages;
    }
    return ComposerizeResult;
}());
exports.ComposerizeResult = ComposerizeResult;
/**
 * A docker option which is supported by this library with it's corresponding docker-compose equivalent.
 */
var SupportedOption = /** @class */ (function () {
    function SupportedOption(dockerOption, composeEquivalent, shortOption) {
        this.dockerOption = dockerOption;
        this.composeEquivalent = composeEquivalent;
        if (shortOption !== undefined) {
            this.dockerOption += '/' + shortOption;
        }
    }
    return SupportedOption;
}());
exports.SupportedOption = SupportedOption;
/**
 * The type of a returned {@link Message}.
 */
var MessageType;
(function (MessageType) {
    MessageType["notImplemented"] = "notImplemented";
    MessageType["notTranslatable"] = "notTranslatable";
    MessageType["errorDuringConversion"] = "errorDuringConversion";
})(MessageType = exports.MessageType || (exports.MessageType = {}));
/**
 * @internal
 */
var ParseResult = /** @class */ (function () {
    function ParseResult() {
        this.serviceName = '';
        this.properties = [];
        this.messages = [];
        this.additionalComposeObjects = [];
    }
    return ParseResult;
}());
exports.ParseResult = ParseResult;
/**
 * @internal
 */
var OptionType;
(function (OptionType) {
    OptionType[OptionType["flag"] = 0] = "flag";
    OptionType[OptionType["withArgs"] = 1] = "withArgs";
})(OptionType = exports.OptionType || (exports.OptionType = {}));
//# sourceMappingURL=types.js.map