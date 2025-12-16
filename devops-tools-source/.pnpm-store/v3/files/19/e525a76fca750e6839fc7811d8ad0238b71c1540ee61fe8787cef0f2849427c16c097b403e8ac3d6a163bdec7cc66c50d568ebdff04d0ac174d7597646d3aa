var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Point } from '@svgdotjs/svg.js';
import { Node } from './node';
import { RegexpNode } from './regexp';
const LABEL_MAP = {
    '?:': '',
    '?=': 'positive lookahead',
    '?!': 'negative lookahead',
};
/**
 * Subexp nodes are for expressions inside of parenthesis. It is rendered as a
 * labeled box around t he contained expression if a label is required.
 */
export class SubexpNode extends Node {
    constructor(metadata, parent) {
        super(metadata, parent);
        this.capture = metadata.capture;
        this.regexp = new RegexpNode(metadata.regexp, this);
        // If there is no need for a label, then proxy to the nested regexp.
        if (this.capture.text === '?:') {
            this.proxy = this.regexp;
        }
    }
    get anchor() {
        const box = this.regexp.bbox();
        const matrix = this.container.matrix();
        const p1 = new Point(box.ax, box.ay).transform(matrix);
        const p2 = new Point(box.ax2, box.ay).transform(matrix);
        return {
            ax: p1.x,
            ax2: p2.x,
            ay: p1.y,
        };
    }
    renderNode() {
        return __awaiter(this, void 0, void 0, function* () {
            // **NOTE:** `this.label()` **MUST** be called here, and before
            // any child nodes are rendered. This is to keep the group numbers in the
            // correct order.
            const label = this.label();
            // Render the contained regexp.
            yield this.regexp.render(this.container.group());
            // Create the labeled box around the regexp.
            yield this.renderLabeledBox(label, this.regexp, 10);
        });
    }
    /**
     * Returns the label for the subexpression
     */
    label() {
        const ret = LABEL_MAP[this.capture.text];
        if (ret) {
            return ret;
        }
        this.state.groupCounter += 1;
        return `group #${this.state.groupCounter}`;
    }
}
//# sourceMappingURL=subexp.js.map