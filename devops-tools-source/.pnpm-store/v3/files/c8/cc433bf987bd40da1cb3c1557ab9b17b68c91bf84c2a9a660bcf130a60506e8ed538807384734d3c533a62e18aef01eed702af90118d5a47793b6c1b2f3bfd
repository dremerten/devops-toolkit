import { Node } from './node';
import { MatchFragment } from './match-fragment';
import { Metadata } from './types';
import { RegexpNode } from './regexp';
/**
 * Match nodes are used for the parts of a regular expression between `|`
 * symbols. Optional `^` and `$` symbols are also allowed at the beginning and
 * end of the Match.
 */
export declare class MatchNode extends Node {
    readonly fragments: MatchFragment[];
    readonly proxy: MatchFragment | null;
    start: Node;
    end: Node;
    constructor(metadata: Metadata, parent: RegexpNode);
    /**
     * Default anchor is overridden to attach the left point of the anchor to
     * the first element, and the right point to the last element.
     */
    protected get anchor(): {
        ax: number;
        ax2: number;
        ay: number;
    };
    renderNode(): Promise<void>;
    /**
     * Returns an array of SVG path strings between each item.
     */
    private connectorPaths;
}
