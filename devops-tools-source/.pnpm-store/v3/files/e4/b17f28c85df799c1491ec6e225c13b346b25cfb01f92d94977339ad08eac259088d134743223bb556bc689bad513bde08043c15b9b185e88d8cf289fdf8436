import { Node } from './node';
import { BBox, Metadata } from './types';
export interface Repeat {
    specific(): {
        min: number;
        max: number;
    };
}
/**
 * Repeat nodes are for the various repetition syntaxes (`a*`, `a+`, `a?`, and
 * `a{1,3}`). It is not rendered directly, but contains data used for the
 * rendering of MatchFragment nodes.
 */
export declare class RepeatNode extends Node {
    readonly min: number;
    readonly max: number;
    readonly greedy: boolean;
    readonly hasSkip: boolean;
    readonly hasLoop: boolean;
    constructor(metadata: Metadata, parent: Node);
    getContentOffset(): {
        x: number;
        y: number;
    };
    getLabel(): string | undefined;
    getTooltip(): string | undefined;
    skipPath(box: BBox): string[];
    loopPath(box: BBox): string[];
}
