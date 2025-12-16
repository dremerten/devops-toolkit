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
exports.RootNode = void 0;
var node_1 = require("./node");
var regexp_1 = require("./regexp");
var FLAG_LABELS = {
    i: 'Ignore Case',
    g: 'Global',
    m: 'Multiline',
    y: 'Sticky',
    u: 'Unicode',
};
var RootNode = /** @class */ (function (_super) {
    __extends(RootNode, _super);
    function RootNode(metadata, state) {
        var _this = _super.call(this, metadata, state) || this;
        _this.regexp = new regexp_1.RegexpNode(_this.metadata.regexp, _this);
        return _this;
    }
    Object.defineProperty(RootNode.prototype, "flags", {
        get: function () {
            return this.metadata.flags;
        },
        enumerable: false,
        configurable: true
    });
    RootNode.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () {
            var chars, flags, flagText, box, margin;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        chars = [];
                        this.flags.text.split('').forEach(function (c) {
                            if (!chars.includes(c)) {
                                chars.push(c);
                            }
                        });
                        flags = chars
                            .sort()
                            .map(function (flag) { return FLAG_LABELS[flag]; });
                        if (flags.length > 0) {
                            flagText = this.container.text("Flags: ".concat(flags.join(', ')));
                        }
                        // Render the content of the regular expression.
                        return [4 /*yield*/, this.regexp.render(this.container.group())
                            // Move rendered regexp to account for flag label and to allow for
                            // decorative elements.
                        ];
                    case 1:
                        // Render the content of the regular expression.
                        _a.sent();
                        // Move rendered regexp to account for flag label and to allow for
                        // decorative elements.
                        if (flagText) {
                            this.regexp.translate(10, flagText.bbox().height);
                        }
                        else {
                            this.regexp.translate(10, 0);
                        }
                        box = this.regexp.bbox();
                        margin = 10;
                        // Render decorative elements.
                        this.container.path("M".concat(box.ax, ",").concat(box.ay, "H0M").concat(box.ax2, ",").concat(box.ay, "H").concat(box.x2 + 10));
                        this.container.circle(10).center(0, box.ay);
                        this.container.circle(10).center(box.x2 + margin, box.ay);
                        return [2 /*return*/];
                }
            });
        });
    };
    return RootNode;
}(node_1.Node));
exports.RootNode = RootNode;
//# sourceMappingURL=root.js.map