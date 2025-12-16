"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RepeatSpec = void 0;
/**
 * RepeatSpec nodes are used for `a{m,n}` regular expression syntax. It is not
 * rendered directly; it just indicates how many times the Repeat node loops.
 */
exports.RepeatSpec = {
    specific: function () {
        var min = this.min ? +this.min.text : this.exact ? +this.exact.text : 0;
        var max = this.max ? +this.max.text : this.exact ? +this.exact.text : -1;
        // Report invalid repeat when the minimum is larger than the maximum.
        if (min > max && max !== -1) {
            throw new Error("Numbers out of order: ".concat(this.text));
        }
        return {
            min: min,
            max: max,
        };
    },
};
//# sourceMappingURL=repeat-spec.js.map