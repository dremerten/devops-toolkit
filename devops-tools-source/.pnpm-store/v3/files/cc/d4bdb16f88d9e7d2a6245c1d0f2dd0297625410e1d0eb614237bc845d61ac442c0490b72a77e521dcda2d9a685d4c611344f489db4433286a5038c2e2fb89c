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
/**
 * Literal nodes are for plain strings in the regular expression. They are
 * rendered as labels with the value of the literal quoted.
 */
export class LiteralNode extends Node {
    constructor(metadata, parent) {
        super(metadata, parent);
        const literal = metadata.literal;
        this.label = literal.text;
        // Order value of the literal for use in CharsetRangeNode.
        this.order = this.label.charCodeAt(0);
    }
    renderNode() {
        return __awaiter(this, void 0, void 0, function* () {
            const text = ['\u201c', this.label, '\u201d'];
            const g = yield this.renderLabel(text, { round: 3 });
            const spans = g.find('tspan');
            // The quote marks get some styling to lighten their color so they are
            // distinct from the actual literal value.
            spans[0].addClass('quote');
            spans[2].addClass('quote');
        });
    }
    /**
     * Merges this literal with another. Literals come back as single characters
     * during parsing, and must be post-processed into multi-character literals
     * for rendering. This processing is done in MatchNode.
     */
    merge(other) {
        this.label += other.label;
    }
}
//# sourceMappingURL=literal.js.map