import { Box, Element } from '@svgdotjs/svg.js';
import { Node } from './node';
import { BBox } from './types';
export declare function bboxWithTransform(node: Element): Box;
/**
 * Creates a Promise that will be resolved after a specified delay.
 * @param ms Time in milliseconds to wait before resolving promise.
 */
export declare function wait(ms: number): Promise<unknown>;
/**
 * Creates a Promise that will be resolved after 0 milliseconds. This is used
 * to create a short delay that allows the browser to address any pending tasks
 * while the JavaScript VM is not active.
 */
export declare function tick(): Promise<unknown>;
export declare function normalizeBBox(box: Box | BBox): BBox;
/**
 * Positions a collection of nodes with their axis points aligned along a
 * horizontal line. This leads to the nodes being spaced horizontally and
 * effectively centered vertically.
 * @param nodes Array of nodes to be positioned
 * @param padding Number of pixels to leave between items
 */
export declare function spaceHorizontal(nodes: (Node | Element)[], padding: number): void;
/**
 * Positions a collection of nodes centered horizontally in a vertical stack.
 * @param nodes Array of nodes to be positioned
 * @param padding Number of pixels to leave between items
 */
export declare function spaceVertical(nodes: (Node | Element)[], padding: number): void;
