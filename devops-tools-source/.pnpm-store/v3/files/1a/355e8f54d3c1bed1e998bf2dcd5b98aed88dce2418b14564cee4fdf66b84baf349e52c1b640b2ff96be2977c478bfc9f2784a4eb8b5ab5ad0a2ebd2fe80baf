var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Node } from './node';
import { RegexpNode } from './regexp';
const FLAG_LABELS = {
    i: 'Ignore Case',
    g: 'Global',
    m: 'Multiline',
    y: 'Sticky',
    u: 'Unicode',
};
export class RootNode extends Node {
    constructor(metadata, state) {
        super(metadata, state);
        this.regexp = new RegexpNode(this.metadata.regexp, this);
    }
    get flags() {
        return this.metadata.flags;
    }
    renderNode() {
        return __awaiter(this, void 0, void 0, function* () {
            const chars = [];
            this.flags.text.split('').forEach((c) => {
                if (!chars.includes(c)) {
                    chars.push(c);
                }
            });
            const flags = chars
                .sort()
                .map((flag) => FLAG_LABELS[flag]);
            // Render a label for any flags that have been set of the expression.
            let flagText;
            if (flags.length > 0) {
                flagText = this.container.text(`Flags: ${flags.join(', ')}`);
            }
            // Render the content of the regular expression.
            yield this.regexp.render(this.container.group());
            // Move rendered regexp to account for flag label and to allow for
            // decorative elements.
            if (flagText) {
                this.regexp.translate(10, flagText.bbox().height);
            }
            else {
                this.regexp.translate(10, 0);
            }
            const box = this.regexp.bbox();
            const margin = 10;
            // Render decorative elements.
            this.container.path(`M${box.ax},${box.ay}H0M${box.ax2},${box.ay}H${box.x2 + 10}`);
            this.container.circle(10).center(0, box.ay);
            this.container.circle(10).center(box.x2 + margin, box.ay);
        });
    }
}
//# sourceMappingURL=root.js.map