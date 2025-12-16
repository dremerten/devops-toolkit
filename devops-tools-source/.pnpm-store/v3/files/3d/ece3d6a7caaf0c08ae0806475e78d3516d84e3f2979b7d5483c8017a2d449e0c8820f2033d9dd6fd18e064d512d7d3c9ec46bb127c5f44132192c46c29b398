import { G } from '@svgdotjs/svg.js';
import { CharsetEscapeNode } from './charset-escape';
import { CharsetRangeNode } from './charset-range';
import { LiteralNode } from './literal';
import { Node } from './node';
import { Metadata } from './types';
/**
 * Charset nodes are used for `[abc1-9]` regular expression syntax. It is
 * rendered as a labeled box with each literal, escape, and range rendering
 * handled by the nested node(s).
 */
export declare class CharsetNode extends Node {
    readonly label: string;
    readonly parts: (CharsetRangeNode | CharsetEscapeNode | LiteralNode)[];
    partContainer: G;
    constructor(metadata: Metadata, parent: Node);
    protected get anchor(): {
        ay: number;
    };
    private createPartNode;
    renderNode(): Promise<void>;
}
