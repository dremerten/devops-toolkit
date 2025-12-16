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
Object.defineProperty(exports, "__esModule", { value: true });
exports.RepeatNode = void 0;
var node_1 = require("./node");
function formatTimes(times) {
    if (times === 1) {
        return 'once';
    }
    return "".concat(times, " times");
}
/**
 * Repeat nodes are for the various repetition syntaxes (`a*`, `a+`, `a?`, and
 * `a{1,3}`). It is not rendered directly, but contains data used for the
 * rendering of MatchFragment nodes.
 */
var RepeatNode = /** @class */ (function (_super) {
    __extends(RepeatNode, _super);
    function RepeatNode(metadata, parent) {
        var _this = _super.call(this, metadata, parent) || this;
        var spec = metadata.spec;
        var greedy = metadata.greedy;
        var _a = spec ? spec.specific() : { min: -1, max: -2 }, min = _a.min, max = _a.max;
        _this.greedy = greedy == null || greedy.text === '';
        _this.hasSkip = min === 0;
        _this.hasLoop = max === -1 || max > 1;
        _this.min = min;
        _this.max = max;
        return _this;
    }
    RepeatNode.prototype.getContentOffset = function () {
        // Translation to apply to content to be repeated to account for the loop
        // and skip lines.
        if (this.hasSkip) {
            return { x: 15, y: 10 };
        }
        if (this.hasLoop) {
            return { x: 10, y: 0 };
        }
        return { x: 0, y: 0 };
    };
    // Label to place of loop path to indicate the number of times that path
    // may be followed.
    RepeatNode.prototype.getLabel = function () {
        var min = this.min;
        var max = this.max;
        if (min === max) {
            if (min === 0) {
                return undefined;
            }
            return formatTimes(min - 1);
        }
        if (min <= 1 && max >= 2) {
            return "at most ".concat(formatTimes(max - 1));
        }
        if (min >= 2) {
            if (max === -1) {
                return "".concat(min - 1, "+ times");
            }
            return "".concat(min - 1, "\u2026").concat(formatTimes(max - 1));
        }
    };
    // Tooltip to place of loop path label to provide further details.
    RepeatNode.prototype.getTooltip = function () {
        var min = this.min;
        var max = this.max;
        var repeatCount;
        if (min === max) {
            if (min === 0) {
                repeatCount = undefined;
            }
            else {
                repeatCount = formatTimes(min);
            }
        }
        else if (min <= 1 && max >= 2) {
            repeatCount = "at most ".concat(formatTimes(max));
        }
        else if (min >= 2) {
            if (max === -1) {
                repeatCount = "".concat(min, "+ times");
            }
            else {
                repeatCount = "".concat(min, "\u2026").concat(formatTimes(max));
            }
        }
        return repeatCount ? "repeats ".concat(repeatCount, " in total") : repeatCount;
    };
    // Returns the path spec to render the line that skips over the content for
    // fragments that are optionally matched.
    RepeatNode.prototype.skipPath = function (box) {
        var paths = [];
        if (this.hasSkip) {
            var vert = Math.max(0, box.ay - box.y - 10);
            var horiz = box.width - 10;
            paths.push("M0,".concat(box.ay, "q10,0 10,-10v").concat(-vert, "q0,-10 10,-10h").concat(horiz, "q10,0 10,10v").concat(vert, "q0,10 10,10"));
            // When the repeat is not greedy, the skip path gets a preference arrow.
            if (!this.greedy) {
                paths.push("M10,".concat(box.ay - 15, "l5,5m-5,-5l-5,5"));
            }
        }
        return paths;
    };
    // Returns the path spec to render the line that repeats the content for
    // fragments that are matched more than once.
    RepeatNode.prototype.loopPath = function (box) {
        var paths = [];
        if (this.hasLoop) {
            var vert = box.y2 - box.ay - 10;
            paths.push("M".concat(box.x, ",").concat(box.ay, "q-10,0 -10,10v").concat(vert, "q0,10 10,10h").concat(box.width, "q10,0 10,-10v").concat(-vert, "q0,-10 -10,-10"));
            // When the repeat is greedy, the loop path gets the preference arrow.
            if (this.greedy) {
                paths.push("M".concat(box.x2 + 10, ",").concat(box.ay + 15, "l5,-5m-5,5l-5,-5"));
            }
        }
        return paths;
    };
    return RepeatNode;
}(node_1.Node));
exports.RepeatNode = RepeatNode;
//# sourceMappingURL=repeat.js.map