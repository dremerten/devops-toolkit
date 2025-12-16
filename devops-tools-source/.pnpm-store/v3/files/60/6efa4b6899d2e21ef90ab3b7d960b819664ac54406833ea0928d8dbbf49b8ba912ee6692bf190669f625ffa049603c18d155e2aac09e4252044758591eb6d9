var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { bboxWithTransform, normalizeBBox, tick } from './util';
export class Node {
    constructor(metadata, parent) {
        this.metadata = metadata;
        this.state = parent instanceof Node ? parent.state : parent;
    }
    get type() {
        return this.metadata.type;
    }
    get text() {
        return this.metadata.text;
    }
    get offset() {
        return this.metadata.offset;
    }
    get elements() {
        return this.metadata.elements;
    }
    get anchor() {
        return {};
    }
    getAnchor() {
        if (this.proxy) {
            return this.proxy.getAnchor();
        }
        return this.anchor;
    }
    /**
     * Returns the bounding box of the container with the anchor included
     */
    bbox() {
        const bbox = bboxWithTransform(this.container);
        const anchor = this.getAnchor();
        return Object.assign(normalizeBBox(bbox), anchor);
    }
    translate(tx, ty) {
        return this.container.translate(tx, ty);
    }
    /**
     * Returns a Promise that will be resolved with the provided value. If the
     * render is cancelled before the Promise is resolved, then an exception will
     * be thrown to halt any rendering.
     * @param value Value to resolve the returned promise with.
     * @returns A Promise resolved with the provided value.
     */
    defer(value) {
        return __awaiter(this, void 0, void 0, function* () {
            yield tick();
            if (this.state.cancelRender) {
                throw new Error('Render cancelled');
            }
            return value;
        });
    }
    /**
     * Render this node.
     * @param container Optional element to render this node into. A container
     * must be specified, but if it has already been set, then it does not
     * need to be provided to render.
     */
    render(container) {
        return __awaiter(this, void 0, void 0, function* () {
            if (container) {
                this.container = container;
                this.container.addClass(this.type);
            }
            // For nodes that proxy to a child node, just render the child.
            if (this.proxy) {
                return this.proxy.render(this.container);
            }
            this.state.inc();
            yield this.renderNode();
            this.state.dec();
            return this;
        });
    }
    renderNode() {
        return __awaiter(this, void 0, void 0, function* () { });
    }
    /**
     * Renders a label centered within a rectangle which can be styled.
     * @param text String or array of strings to render as a label.
     * @returns A Promise which will be resolved with the SVG group the rect and
     * text are rendered in.
     */
    renderLabel(text, options = {}) {
        return __awaiter(this, void 0, void 0, function* () {
            const group = this.container.group().addClass('label');
            const rect = group.rect();
            const label = this.renderText(group, text);
            if (options.className) {
                group.addClass(options.className);
            }
            yield this.defer();
            const bbox = label.bbox();
            const margin = 5;
            label.translate(margin, bbox.height / 2 + 2 * margin);
            rect.attr({
                width: bbox.width + 2 * margin,
                height: bbox.height + 2 * margin,
            });
            if (options.round) {
                rect.attr({ rx: options.round, ry: options.round });
            }
            return group;
        });
    }
    /**
     * Renders a labeled box around another SVG element.
     * @param text String or array of strings to label the box with.
     * @param content SVG element to wrap in the box.
     * @param padding Pixels of padding to place between the content and the box.
     */
    renderLabeledBox(text, content, padding = 0) {
        return __awaiter(this, void 0, void 0, function* () {
            const label = this.renderText(this.container, text);
            const rect = this.container.rect().attr({ rx: 3, ry: 3 });
            label.addClass(`${this.type}-label`).back();
            rect.addClass(`${this.type}-box`).back();
            yield this.defer();
            const labelBox = label.bbox();
            const contentBox = content.bbox();
            const boxWidth = Math.max(contentBox.width + padding * 2, labelBox.width);
            const boxHeight = contentBox.height + padding * 2;
            label.translate(0, labelBox.height);
            rect.translate(0, labelBox.height).attr({
                width: boxWidth,
                height: boxHeight,
            });
            content.translate(boxWidth / 2 - contentBox.cx, labelBox.height + padding);
        });
    }
    renderText(container, text) {
        const lines = Array.isArray(text) ? text : [text];
        return container.text((block) => {
            lines.forEach((line) => block.tspan(line));
        });
    }
}
//# sourceMappingURL=node.js.map