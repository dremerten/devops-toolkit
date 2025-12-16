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
exports.CharsetRangeNode = void 0;
var node_1 = require("./node");
var literal_1 = require("./literal");
var util_1 = require("./util");
/**
 * CharsetRange nodes are used for `[a-z]` regular expression syntax. The two
 * literal or escape nodes are rendered with a hyphen between them.
 */
var CharsetRangeNode = /** @class */ (function (_super) {
    __extends(CharsetRangeNode, _super);
    function CharsetRangeNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        _this.first = new literal_1.LiteralNode(metadata.first, _this);
        _this.last = new literal_1.LiteralNode(metadata.last, _this);
        // Report invalid expression when extents of the range are out of order.
        if (_this.first.order > _this.last.order) {
            throw new Error("Range out of order in character class: ".concat(_this.text));
        }
        return _this;
    }
    CharsetRangeNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var contents;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        contents = [this.first, this.container.text('-'), this.last];
                        // Render the nodes of the range.
                        return [4 /*yield*/, Promise.all([
                                this.first.render(this.container.group()),
                                this.last.render(this.container.group()),
                            ])
                            // Space the nodes and hyphen horizontally.
                        ];
                    case 1:
                        // Render the nodes of the range.
                        _a.sent();
                        // Space the nodes and hyphen horizontally.
                        (0, util_1.spaceHorizontal)(contents, 5);
                        return [2 /*return*/];
                }
            });
        });
    };
    return CharsetRangeNode;
}(node_1.Node));
exports.CharsetRangeNode = CharsetRangeNode;
//# sourceMappingURL=charset-range.js.map