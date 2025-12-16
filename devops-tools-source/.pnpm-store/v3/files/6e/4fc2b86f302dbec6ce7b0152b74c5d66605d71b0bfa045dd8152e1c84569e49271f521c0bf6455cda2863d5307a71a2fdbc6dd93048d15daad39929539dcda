"use strict";
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
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CharsetNode = void 0;
var svg_js_1 = require("@svgdotjs/svg.js");
var charset_escape_1 = require("./charset-escape");
var charset_range_1 = require("./charset-range");
var literal_1 = require("./literal");
var node_1 = require("./node");
var util_1 = require("./util");
/**
 * Charset nodes are used for `[abc1-9]` regular expression syntax. It is
 * rendered as a labeled box with each literal, escape, and range rendering
 * handled by the nested node(s).
 */
var CharsetNode = /** @class */ (function (_super) {
    __extends(CharsetNode, _super);
    function CharsetNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        var parts = metadata.parts;
        var invert = metadata.invert;
        // The label for the charset will be:
        // - "One of:" for charsets of the form: `[abc]`.
        // - "None of:" for charsets of the form: `[^abc]`.
        _this.label = invert.text === '^' ? 'None of:' : 'One of:';
        // Removes any duplicate parts from the charset. This is based on the type
        // and text value of the part, so `[aa]` will have only one item, but
        // `[a\x61]` will contain two since the first matches "a" and the second
        // matches 0x61 (even though both are an "a").
        var keys = [];
        var uniqs = [];
        parts.elements.forEach(function (part) {
            var key = "".concat(part.type, ":").concat(part.text);
            if (!keys.includes(key)) {
                keys.push(key);
                uniqs.push(part);
            }
        });
        _this.parts = uniqs.map(function (metadata) { return _this.createPartNode(metadata); });
        // Include a warning for charsets that attempt to match `\c` followed by
        // any character other than A-Z (case insensitive). Charsets like `[\c@]`
        // behave differently in different browsers. Some match the character
        // reference by the control charater escape, others match "\", "c", or "@",
        // and some do not appear to match anything.
        if (_this.text.match(/\\c[^a-zA-Z]/)) {
            _this.state.warnings.push("The character set \"".concat(_this.text, "\" contains the \\c escape followed by a character other than A-Z. This can lead to different behavior depending on browser. The representation here is the most common interpretation."));
        }
        return _this;
    }
    Object.defineProperty(CharsetNode.prototype, "anchor", {
        get: function () {
            // Default anchor is overridden to move it down so that it connects at
            // the middle of the box that wraps all of the charset parts, instead of
            // the middle of the container, which would take the label into account.
            var matrix = this.container.matrix();
            var bbox = (0, util_1.bboxWithTransform)(this.partContainer);
            var p = new svg_js_1.Point(0, bbox.cy).transform(matrix);
            return { ay: p.y };
        },
        enumerable: false,
        configurable: true
    });
    CharsetNode.prototype.createPartNode = function (metadata) {
        var type = metadata.type;
        var Ctor = type === 'charset-range'
            ? charset_range_1.CharsetRangeNode
            : type === 'charset-escape'
                ? charset_escape_1.CharsetEscapeNode
                : type === 'literal'
                    ? literal_1.LiteralNode
                    : null;
        if (Ctor) {
            return new Ctor(metadata, this);
        }
        throw new Error("Unknown node type: \"".concat(type, "\""));
    };
    CharsetNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var _this = this;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        this.partContainer = this.container.group();
                        // Renders each part of the charset into the part container.
                        return [4 /*yield*/, Promise.all(this.parts.map(function (part) { return part.render(_this.partContainer.group()); }))
                            // Space the parts of the charset vertically in the part container.
                        ];
                    case 1:
                        // Renders each part of the charset into the part container.
                        _a.sent();
                        // Space the parts of the charset vertically in the part container.
                        (0, util_1.spaceVertical)(this.parts, 5);
                        // Label the part container.
                        return [4 /*yield*/, this.renderLabeledBox(this.label, this.partContainer, 5)];
                    case 2:
                        // Label the part container.
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    return CharsetNode;
}(node_1.Node));
exports.CharsetNode = CharsetNode;
//# sourceMappingURL=charset.js.map