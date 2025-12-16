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
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CharsetEscapeNode = void 0;
var escape_js_1 = require("./escape.js");
var escape_util_js_1 = require("./escape-util.js");
/**
 * CharsetEscape nodes are for escape sequences inside of character sets. They
 * differ from other Escape nodes in that `\b` matches a backspace character
 * instead of a word boundary.
 */
var CharsetEscapeNode = /** @class */ (function (_super) {
    __extends(CharsetEscapeNode, _super);
    function CharsetEscapeNode() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.mapping = __assign(__assign({}, escape_util_js_1.CODE_MAPPING), { b: ['backspace', 0x08, true] });
        return _this;
    }
    return CharsetEscapeNode;
}(escape_js_1.EscapeNode));
exports.CharsetEscapeNode = CharsetEscapeNode;
//# sourceMappingURL=charset-escape.js.map