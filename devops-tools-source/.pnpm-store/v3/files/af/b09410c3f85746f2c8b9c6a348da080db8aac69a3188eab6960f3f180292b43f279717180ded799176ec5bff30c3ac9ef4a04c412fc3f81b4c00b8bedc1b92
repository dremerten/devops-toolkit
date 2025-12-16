var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import parser from '@regexper/parser';
import { SVG } from '@svgdotjs/svg.js';
import { style } from './style';
import { RootNode } from './root';
import { State } from './state';
import { getExtensions } from './extensions.js';
export function render(regex, container, options = {}) {
    return __awaiter(this, void 0, void 0, function* () {
        const state = new State(options);
        const extensions = getExtensions();
        const regexString = typeof regex === 'string' ? regex : regex.toString();
        const tree = parser.parse(regexString, { types: extensions });
        const root = new RootNode(tree, state);
        const svg = SVG(container);
        svg
            .defs()
            .style()
            .add(document.createTextNode(style));
        yield root.render(svg.group());
        const bbox = root.bbox();
        root.translate(10 - bbox.x, 10 - bbox.y);
        svg.size(bbox.width + 20, bbox.height + 20);
        return root;
    });
}
//# sourceMappingURL=index.js.map