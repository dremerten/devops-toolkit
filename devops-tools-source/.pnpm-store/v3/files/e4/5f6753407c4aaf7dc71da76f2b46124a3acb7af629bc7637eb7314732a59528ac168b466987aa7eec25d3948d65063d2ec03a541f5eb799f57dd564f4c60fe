import { EscapeNode } from './escape.js';
import { CODE_MAPPING } from './escape-util.js';
/**
 * CharsetEscape nodes are for escape sequences inside of character sets. They
 * differ from other Escape nodes in that `\b` matches a backspace character
 * instead of a word boundary.
 */
export class CharsetEscapeNode extends EscapeNode {
    constructor() {
        super(...arguments);
        this.mapping = Object.assign(Object.assign({}, CODE_MAPPING), { b: ['backspace', 0x08, true] });
    }
}
//# sourceMappingURL=charset-escape.js.map