import { Node } from './node';
import { AnchorNode } from './anchor';
import { AnyCharacterNode } from './any-character';
import { CharsetNode } from './charset';
import { EscapeNode } from './escape';
import { LiteralNode } from './literal';
import { MatchNode } from './match';
import { RepeatNode } from './repeat';
import { SubexpNode } from './subexp';
import { Metadata } from './types';
/**
 * MatchFragment are part of a MatchNode followed by an optional RepeatNode.
 * If no repeat is applied, then rendering is proxied to the content node.
 */
export declare class MatchFragment extends Node {
    /**
     * Then content of the fragment
     */
    readonly content: AnchorNode | SubexpNode | CharsetNode | AnyCharacterNode | EscapeNode | LiteralNode;
    /**
     * The repetition rule for the fragment
     */
    readonly repeat: RepeatNode;
    readonly proxy: Node | null;
    readonly canMerge: boolean;
    constructor(metadata: Metadata, parent: MatchNode);
    private createContentNode;
    protected get anchor(): {
        ax: number;
        ax2: number;
        ay: number;
    };
    renderNode(): Promise<void>;
    /**
     * Renders label for the loop path indicating how many times the content may
     * be matched.
     */
    private renderLoopLabel;
}
