/**
 * State tracking for an in-progress parse and render
 */
export class State {
    constructor(options = {}) {
        this.groupCounter = 0;
        this.cancelRender = false;
        this.warnings = [];
        this.renderCounter = 0;
        this.maxCounter = 0;
        this.options = options;
    }
    update(value) {
        if (value > this.renderCounter) {
            this.maxCounter = value;
        }
        this.renderCounter = value;
        if (this.maxCounter && !this.cancelRender) {
            const onChange = this.options.onChange;
            if (onChange) {
                const progress = 100 - Math.round((100 * this.renderCounter) / this.maxCounter);
                onChange({ progress });
            }
        }
    }
    inc() {
        this.update(this.renderCounter + 1);
    }
    dec() {
        this.update(this.renderCounter - 1);
    }
}
//# sourceMappingURL=state.js.map