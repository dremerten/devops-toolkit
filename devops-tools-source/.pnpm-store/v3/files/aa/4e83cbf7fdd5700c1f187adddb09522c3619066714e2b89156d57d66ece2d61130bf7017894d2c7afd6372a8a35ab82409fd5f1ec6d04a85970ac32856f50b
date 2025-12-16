var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { CODE_MAPPING, getCodeData, toHex } from './escape-util';
import { Node } from './node';
/**
 * Escape nodes are used for escape sequences. It is rendered as a label
 * with the description of the escape and the numeric code it matches when
 * appropriate.
 */
export class EscapeNode extends Node {
    constructor(metadata, parent) {
        super(metadata, parent);
        this.mapping = CODE_MAPPING;
        const esc = metadata.esc;
        this.code = esc.code.text;
        this.arg = esc.arg.text;
        // Retrieves the label, ordinal value, an flag to control adding hex value
        // from the escape code mappings
        const ret = getCodeData(this.mapping, this.code, this.arg);
        this.label = ret[0];
        this.ordinal = ret[1];
        const hex = ret[2];
        // When requested, add hex code to the label.
        if (hex) {
            this.label = `${this.label} ${toHex(this.ordinal)}`;
        }
    }
    renderNode() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.renderLabel(this.label, { round: 3 });
        });
    }
}
//# sourceMappingURL=escape.js.map