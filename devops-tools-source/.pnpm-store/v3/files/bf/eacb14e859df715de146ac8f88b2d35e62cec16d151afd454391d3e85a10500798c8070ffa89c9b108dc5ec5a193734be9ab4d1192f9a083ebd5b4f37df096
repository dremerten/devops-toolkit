import { Node } from './node';
import { LiteralNode } from './literal';
import { Metadata } from './types';
/**
 * CharsetRange nodes are used for `[a-z]` regular expression syntax. The two
 * literal or escape nodes are rendered with a hyphen between them.
 */
export declare class CharsetRangeNode extends Node {
    readonly first: LiteralNode;
    readonly last: LiteralNode;
    constructor(metadata: Metadata, parent: Node);
    renderNode(): Promise<void>;
}
