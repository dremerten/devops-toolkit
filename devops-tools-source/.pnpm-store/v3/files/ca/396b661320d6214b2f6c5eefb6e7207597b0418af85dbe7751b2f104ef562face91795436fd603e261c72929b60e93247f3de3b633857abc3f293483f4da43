"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.State = void 0;
/**
 * State tracking for an in-progress parse and render
 */
var State = /** @class */ (function () {
    function State(options) {
        if (options === void 0) { options = {}; }
        this.groupCounter = 0;
        this.cancelRender = false;
        this.warnings = [];
        this.renderCounter = 0;
        this.maxCounter = 0;
        this.options = options;
    }
    State.prototype.update = function (value) {
        if (value > this.renderCounter) {
            this.maxCounter = value;
        }
        this.renderCounter = value;
        if (this.maxCounter && !this.cancelRender) {
            var onChange = this.options.onChange;
            if (onChange) {
                var progress = 100 - Math.round((100 * this.renderCounter) / this.maxCounter);
                onChange({ progress: progress });
            }
        }
    };
    State.prototype.inc = function () {
        this.update(this.renderCounter + 1);
    };
    State.prototype.dec = function () {
        this.update(this.renderCounter - 1);
    };
    return State;
}());
exports.State = State;
//# sourceMappingURL=state.js.map