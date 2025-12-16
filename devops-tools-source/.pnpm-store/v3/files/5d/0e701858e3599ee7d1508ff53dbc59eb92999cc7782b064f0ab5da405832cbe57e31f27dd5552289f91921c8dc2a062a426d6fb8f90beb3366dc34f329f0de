import { Node } from './node';
import { RegexpNode } from './regexp';
import { Metadata } from './types';
/**
 * Subexp nodes are for expressions inside of parenthesis. It is rendered as a
 * labeled box around t he contained expression if a label is required.
 */
export declare class SubexpNode extends Node {
    readonly capture: Metadata;
    readonly regexp: RegexpNode;
    readonly proxy: RegexpNode | null;
    constructor(metadata: Metadata, parent: Node);
    protected get anchor(): {
        ax: number;
        ax2: number;
        ay: number;
    };
    renderNode(): Promise<void>;
    /**
     * Returns the label for the subexpression
     */
    private label;
}
