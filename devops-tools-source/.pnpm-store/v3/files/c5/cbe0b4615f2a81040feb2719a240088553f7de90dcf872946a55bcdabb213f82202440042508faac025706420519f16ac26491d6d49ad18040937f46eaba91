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
exports.SubexpNode = void 0;
var svg_js_1 = require("@svgdotjs/svg.js");
var node_1 = require("./node");
var regexp_1 = require("./regexp");
var LABEL_MAP = {
    '?:': '',
    '?=': 'positive lookahead',
    '?!': 'negative lookahead',
};
/**
 * Subexp nodes are for expressions inside of parenthesis. It is rendered as a
 * labeled box around t he contained expression if a label is required.
 */
var SubexpNode = /** @class */ (function (_super) {
    __extends(SubexpNode, _super);
    function SubexpNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        _this.capture = metadata.capture;
        _this.regexp = new regexp_1.RegexpNode(metadata.regexp, _this);
        // If there is no need for a label, then proxy to the nested regexp.
        if (_this.capture.text === '?:') {
            _this.proxy = _this.regexp;
        }
        return _this;
    }
    Object.defineProperty(SubexpNode.prototype, "anchor", {
        get: function () {
            var box = this.regexp.bbox();
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
    SubexpNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var label;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        label = this.label();
                        // Render the contained regexp.
                        return [4 /*yield*/, this.regexp.render(this.container.group())
                            // Create the labeled box around the regexp.
                        ];
                    case 1:
                        // Render the contained regexp.
                        _a.sent();
                        // Create the labeled box around the regexp.
                        return [4 /*yield*/, this.renderLabeledBox(label, this.regexp, 10)];
                    case 2:
                        // Create the labeled box around the regexp.
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    /**
     * Returns the label for the subexpression
     */
    SubexpNode.prototype.label = function () {
        var ret = LABEL_MAP[this.capture.text];
        if (ret) {
            return ret;
        }
        this.state.groupCounter += 1;
        return "group #".concat(this.state.groupCounter);
    };
    return SubexpNode;
}(node_1.Node));
exports.SubexpNode = SubexpNode;
//# sourceMappingURL=subexp.js.map