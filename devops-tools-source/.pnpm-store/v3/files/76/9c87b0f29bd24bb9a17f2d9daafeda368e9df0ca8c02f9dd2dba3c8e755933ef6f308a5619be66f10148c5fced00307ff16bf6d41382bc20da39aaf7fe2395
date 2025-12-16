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
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MatchFragment = void 0;
var svg_js_1 = require("@svgdotjs/svg.js");
var node_1 = require("./node");
var anchor_1 = require("./anchor");
var any_character_1 = require("./any-character");
var charset_1 = require("./charset");
var escape_1 = require("./escape");
var literal_1 = require("./literal");
var repeat_1 = require("./repeat");
var subexp_1 = require("./subexp");
/**
 * MatchFragment are part of a MatchNode followed by an optional RepeatNode.
 * If no repeat is applied, then rendering is proxied to the content node.
 */
var MatchFragment = /** @class */ (function (_super) {
    __extends(MatchFragment, _super);
    function MatchFragment(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        _this.content = _this.createContentNode();
        _this.repeat = new repeat_1.RepeatNode(metadata.repeat, _this);
        if (!_this.repeat.hasLoop && !_this.repeat.hasSkip) {
            // For fragments without a skip or loop, rendering is proxied to the
            // content. Also set flag indicating that contents can be merged if
            // the content is a literal node.
            _this.canMerge = _this.content.type === 'literal';
            _this.proxy = _this.content;
        }
        else {
            // Fragments that have skip or loop lines cannot be merged with others.
            _this.canMerge = false;
        }
        return _this;
    }
    MatchFragment.prototype.createContentNode = function () {
        var metadata = this.metadata.content;
        var type = metadata.type;
        var Ctor = type === 'anchor'
            ? anchor_1.AnchorNode
            : type === 'subexp'
                ? subexp_1.SubexpNode
                : type === 'charset'
                    ? charset_1.CharsetNode
                    : type === 'any-character'
                        ? any_character_1.AnyCharacterNode
                        : type === 'escape'
                            ? escape_1.EscapeNode
                            : type === 'literal'
                                ? literal_1.LiteralNode
                                : null;
        if (Ctor) {
            return new Ctor(metadata, this);
        }
        throw new Error("Unknow match fragment type: \"".concat(type, "\""));
    };
    Object.defineProperty(MatchFragment.prototype, "anchor", {
        get: function () {
            // Default anchor is overridden to apply an transforms from the fragment
            // to its content's anchor. Essentially, the fragment inherits the anchor
            // of its content.
            var box = this.content.bbox();
            var matrix = this.container.matrix();
            var p1 = new svg_js_1.Point(box.ax, box.ay).transform(matrix);
            var p2 = new svg_js_1.Point(box.ax2, box.ay).transform(matrix);
            return {
                ax: p1.x,
                ax2: p2.x,
                ay: p1.y,
            };
        },
        enumerable: false,
        configurable: true
    });
    MatchFragment.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var _a, x, y, box, paths;
            return __generator(this, function (_b) {
                switch (_b.label) {
                    case 0: return [4 /*yield*/, this.content.render(this.container.group())
                        // Contents must be transformed based on the repeat that is applied.
                    ];
                    case 1:
                        _b.sent();
                        _a = this.repeat.getContentOffset(), x = _a.x, y = _a.y;
                        this.content.translate(x, y);
                        box = this.content.bbox();
                        paths = __spreadArray(__spreadArray([], this.repeat.skipPath(box), true), this.repeat.loopPath(box), true);
                        this.container.path(paths.join('')).back();
                        this.renderLoopLabel();
                        return [2 /*return*/];
                }
            });
        });
    };
    /**
     * Renders label for the loop path indicating how many times the content may
     * be matched.
     */
    MatchFragment.prototype.renderLoopLabel = function () {
        var labelStr = this.repeat.getLabel();
        var tooltipStr = this.repeat.getTooltip();
        if (labelStr) {
            var label = this.container.text(labelStr).addClass('repeat-label');
            var labelBox = label.bbox();
            var box = this.bbox();
            if (tooltipStr) {
                var tooltip = (0, svg_js_1.create)('title');
                this.container.text(tooltipStr).addTo(tooltip);
                label.add(tooltip);
            }
            label.translate(box.x2 - labelBox.width - (this.repeat.hasSkip ? 5 : 0), box.y2 + labelBox.height);
        }
    };
    return MatchFragment;
}(node_1.Node));
exports.MatchFragment = MatchFragment;
//# sourceMappingURL=match-fragment.js.map