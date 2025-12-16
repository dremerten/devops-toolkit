import { G, Svg } from '@svgdotjs/svg.js';
import { State } from './state';
import { BBox, Metadata } from './types';
export declare abstract class Node implements Metadata {
    readonly metadata: Metadata;
    readonly state: State;
    get type(): string;
    get text(): string;
    get offset(): number;
    get elements(): Metadata[];
    readonly proxy?: Node | null;
    container: G | Svg;
    constructor(metadata: Metadata, parent: Node | State);
    protected get anchor(): {
        ax: number;
        ax2: number;
        ay: number;
    } | {
        ay: number;
    } | Record<string, never>;
    getAnchor(): {
        ax: number;
        ax2: number;
        ay: number;
    } | {
        ay: number;
    } | Record<string, never>;
    /**
     * Returns the bounding box of the container with the anchor included
     */
    bbox(): BBox;
    translate(tx: number, ty: number): G | Svg;
    /**
     * Returns a Promise that will be resolved with the provided value. If the
     * render is cancelled before the Promise is resolved, then an exception will
     * be thrown to halt any rendering.
     * @param value Value to resolve the returned promise with.
     * @returns A Promise resolved with the provided value.
     */
    defer<T>(value?: T): Promise<T | undefined>;
    /**
     * Render this node.
     * @param container Optional element to render this node into. A container
     * must be specified, but if it has already been set, then it does not
     * need to be provided to render.
     */
    render(container: G | Svg): Promise<Node>;
    renderNode(): Promise<void>;
    /**
     * Renders a label centered within a rectangle which can be styled.
     * @param text String or array of strings to render as a label.
     * @returns A Promise which will be resolved with the SVG group the rect and
     * text are rendered in.
     */
    renderLabel(text: string | string[], options?: {
        round?: number;
        className?: string;
    }): Promise<G>;
    /**
     * Renders a labeled box around another SVG element.
     * @param text String or array of strings to label the box with.
     * @param content SVG element to wrap in the box.
     * @param padding Pixels of padding to place between the content and the box.
     */
    renderLabeledBox(text: string | string[], content: Node | G, padding?: number): Promise<void>;
    renderText(container: G | Svg, text: string | string[]): import("@svgdotjs/svg.js").Text;
}
