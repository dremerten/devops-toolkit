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
import { LiteralNode } from './literal';
import { spaceHorizontal } from './util';
/**
 * CharsetRange nodes are used for `[a-z]` regular expression syntax. The two
 * literal or escape nodes are rendered with a hyphen between them.
 */
export class CharsetRangeNode extends Node {
    constructor(metadata, parent) {
        super(metadata, parent);
        this.first = new LiteralNode(metadata.first, this);
        this.last = new LiteralNode(metadata.last, this);
        // Report invalid expression when extents of the range are out of order.
        if (this.first.order > this.last.order) {
            throw new Error(`Range out of order in character class: ${this.text}`);
        }
    }
    renderNode() {
        return __awaiter(this, void 0, void 0, function* () {
            const contents = [this.first, this.container.text('-'), this.last];
            // Render the nodes of the range.
            yield Promise.all([
                this.first.render(this.container.group()),
                this.last.render(this.container.group()),
            ]);
            // Space the nodes and hyphen horizontally.
            spaceHorizontal(contents, 5);
        });
    }
}
//# sourceMappingURL=charset-range.js.map