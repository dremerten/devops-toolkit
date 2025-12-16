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
exports.MatchNode = void 0;
var svg_js_1 = require("@svgdotjs/svg.js");
var node_1 = require("./node");
var match_fragment_1 = require("./match-fragment");
var util_1 = require("./util");
/**
 * Match nodes are used for the parts of a regular expression between `|`
 * symbols. Optional `^` and `$` symbols are also allowed at the beginning and
 * end of the Match.
 */
var MatchNode = /** @class */ (function (_super) {
    __extends(MatchNode, _super);
    function MatchNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        var parts = _this.metadata.parts;
        // Merged list of MatchFragments to be rendered.
        _this.fragments = [];
        var fragments = _this.fragments;
        parts.elements.forEach(function (node) {
            var last = fragments[fragments.length - 1];
            var frag = new match_fragment_1.MatchFragment(node, _this);
            if (last && last.canMerge && frag.canMerge) {
                // Merged the content of `node` into `last` when possible.
                ;
                last.content.merge(frag.content);
            }
            else {
                // `node` cannot be merged with the previous node, so it is added to
                // the list of parts.
                fragments.push(frag);
            }
        });
        // When there is only one part, then proxy to the part.
        if (fragments.length === 1) {
            _this.proxy = fragments[0];
        }
        return _this;
    }
    Object.defineProperty(MatchNode.prototype, "anchor", {
        /**
         * Default anchor is overridden to attach the left point of the anchor to
         * the first element, and the right point to the last element.
         */
        get: function () {
            var start = (0, util_1.normalizeBBox)(this.start.bbox());
            var end = (0, util_1.normalizeBBox)(this.end.bbox());
            var matrix = this.container.matrix();
            var p1 = new svg_js_1.Point(start.ax, start.ay).transform(matrix);
            var p2 = new svg_js_1.Point(end.ax2, end.ay).transform(matrix);
            return {
                ax: p1.x,
                ax2: p2.x,
                ay: p1.y,
            };
        },
        enumerable: false,
        configurable: true
    });
    MatchNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var items;
            var _this = this;
            return __generator(this, function (_a) {
                items = this.fragments.map(function (frag) {
                    return frag.render(_this.container.group());
                });
                // Handle the situation where a regular expression of `()` is rendered.
                // This leads to a Match node with no fragments. Something must be rendered
                // so that the anchor can be calculated based on it.
                //
                // Furthermore, the content rendered must have height and width or else the
                // anchor calculations fail.
                if (items.length === 0) {
                    items.push(this.container.group().path('M0,0h10'));
                }
                return [2 /*return*/, Promise.all(items).then(function (frags) {
                        // Find SVG elements to be used when calculating the anchor.
                        _this.start = frags[0];
                        _this.end = frags[frags.length - 1];
                        (0, util_1.spaceHorizontal)(frags, 10);
                        // Add lines between each item.
                        _this.container.path(_this.connectorPaths(frags).join('')).back();
                    })];
            });
        });
    };
    /**
     * Returns an array of SVG path strings between each item.
     */
    MatchNode.prototype.connectorPaths = function (nodes) {
        var prev = (0, util_1.normalizeBBox)(nodes[0].bbox());
        var next;
        return nodes.slice(1).map(function (node) {
            next = (0, util_1.normalizeBBox)(node.bbox());
            var path = "M".concat(prev.ax2, ",").concat(prev.ay, "H").concat(next.ax);
            prev = next;
            return path;
        });
    };
    return MatchNode;
}(node_1.Node));
exports.MatchNode = MatchNode;
//# sourceMappingURL=match.js.map