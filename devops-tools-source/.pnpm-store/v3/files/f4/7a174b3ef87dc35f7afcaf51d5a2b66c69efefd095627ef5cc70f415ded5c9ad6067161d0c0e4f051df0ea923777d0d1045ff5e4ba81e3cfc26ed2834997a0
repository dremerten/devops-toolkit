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
export { ComposerizeResult };
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
export { SupportedOption };
/**
 * The type of a returned {@link Message}.
 */
export var MessageType;
(function (MessageType) {
    MessageType["notImplemented"] = "notImplemented";
    MessageType["notTranslatable"] = "notTranslatable";
    MessageType["errorDuringConversion"] = "errorDuringConversion";
})(MessageType || (MessageType = {}));
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
export { ParseResult };
/**
 * @internal
 */
export var OptionType;
(function (OptionType) {
    OptionType[OptionType["flag"] = 0] = "flag";
    OptionType[OptionType["withArgs"] = 1] = "withArgs";
})(OptionType || (OptionType = {}));
//# sourceMappingURL=types.js.map