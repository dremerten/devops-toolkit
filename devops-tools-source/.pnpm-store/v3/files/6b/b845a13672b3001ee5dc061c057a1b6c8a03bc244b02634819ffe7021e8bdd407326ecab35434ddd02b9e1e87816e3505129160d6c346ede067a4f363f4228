import { Node } from './node';
import { Metadata } from './types';
/**
 * Literal nodes are for plain strings in the regular expression. They are
 * rendered as labels with the value of the literal quoted.
 */
export declare class LiteralNode extends Node {
    label: string;
    readonly order: number;
    constructor(metadata: Metadata, parent: Node);
    renderNode(): Promise<void>;
    /**
     * Merges this literal with another. Literals come back as single characters
     * during parsing, and must be post-processed into multi-character literals
     * for rendering. This processing is done in MatchNode.
     */
    merge(other: LiteralNode): void;
}
