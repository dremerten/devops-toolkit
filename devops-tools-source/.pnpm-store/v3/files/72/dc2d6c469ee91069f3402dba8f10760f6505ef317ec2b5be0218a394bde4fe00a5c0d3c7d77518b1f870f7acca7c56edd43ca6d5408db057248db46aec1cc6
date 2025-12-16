import { MatchNode } from './match';
import { Node } from './node';
import { Metadata } from './types';
export declare class RegexpNode extends Node {
    readonly matches: MatchNode[];
    readonly proxy?: MatchNode | null;
    constructor(metadata: Metadata, parent: Node);
    renderNode(): Promise<void>;
    /**
     * Returns an array of SVG path strings to draw the vertical lines on the
     * left and right of the node.
     * @param containerBox Bounding box of the container.
     * @param match Match node that the line will be drawn to.
     */
    private makeSide;
    /**
     * Returns an array of SVG path strings to draw the curves from the
     * sidelines up to the anchor of the match node.
     * @param containerBox Bounding box of the container.
     * @param match Match node that the line will be drawn to.
     */
    private makeCurve;
    /**
     * Returns an array of SVG path strings to draw the connection from the
     * curve to match node.
     * @param containerBox Bounding box of the container.
     * @param match Match node that the line will be drawn to.
     */
    private makeConnector;
}
