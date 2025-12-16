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
exports.LiteralNode = void 0;
var node_1 = require("./node");
/**
 * Literal nodes are for plain strings in the regular expression. They are
 * rendered as labels with the value of the literal quoted.
 */
var LiteralNode = /** @class */ (function (_super) {
    __extends(LiteralNode, _super);
    function LiteralNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        var literal = metadata.literal;
        _this.label = literal.text;
        // Order value of the literal for use in CharsetRangeNode.
        _this.order = _this.label.charCodeAt(0);
        return _this;
    }
    LiteralNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var text, g, spans;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        text = ['\u201c', this.label, '\u201d'];
                        return [4 /*yield*/, this.renderLabel(text, { round: 3 })];
                    case 1:
                        g = _a.sent();
                        spans = g.find('tspan');
                        // The quote marks get some styling to lighten their color so they are
                        // distinct from the actual literal value.
                        spans[0].addClass('quote');
                        spans[2].addClass('quote');
                        return [2 /*return*/];
                }
            });
        });
    };
    /**
     * Merges this literal with another. Literals come back as single characters
     * during parsing, and must be post-processed into multi-character literals
     * for rendering. This processing is done in MatchNode.
     */
    LiteralNode.prototype.merge = function (other) {
        this.label += other.label;
    };
    return LiteralNode;
}(node_1.Node));
exports.LiteralNode = LiteralNode;
//# sourceMappingURL=literal.js.map