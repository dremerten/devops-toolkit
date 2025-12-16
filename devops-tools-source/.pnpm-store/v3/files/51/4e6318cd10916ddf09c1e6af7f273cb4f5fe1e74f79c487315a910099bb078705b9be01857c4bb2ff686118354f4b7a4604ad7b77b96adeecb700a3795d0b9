import { Code } from './escape-util';
import { Node } from './node';
import { Metadata } from './types';
/**
 * Escape nodes are used for escape sequences. It is rendered as a label
 * with the description of the escape and the numeric code it matches when
 * appropriate.
 */
export declare class EscapeNode extends Node {
    readonly mapping: {
        b: (string | number | boolean)[];
        B: (string | number | boolean)[];
        d: (string | number | boolean)[];
        D: (string | number | boolean)[];
        f: (string | number | boolean)[];
        n: (string | number | boolean)[];
        r: (string | number | boolean)[];
        s: (string | number | boolean)[];
        S: (string | number | boolean)[];
        t: (string | number | boolean)[];
        v: (string | number | boolean)[];
        w: (string | number | boolean)[];
        W: (string | number | boolean)[];
        1: (string | number | boolean)[];
        2: (string | number | boolean)[];
        3: (string | number | boolean)[];
        4: (string | number | boolean)[];
        5: (string | number | boolean)[];
        6: (string | number | boolean)[];
        7: (string | number | boolean)[];
        8: (string | number | boolean)[];
        9: (string | number | boolean)[];
        0(arg: string): (string | number | boolean)[];
        c(arg: string): (string | number | boolean)[];
        x(arg: string): (string | number | boolean)[];
        u(arg: string): (string | number | boolean)[];
    };
    /**
     * The escape code. For an escape such as `\b` it would be "b".
     */
    readonly code: Code;
    /**
     * The argument. For an escape such as `\xab` it would be "ab".
     */
    readonly arg: string;
    readonly label: string;
    readonly ordinal: number;
    constructor(metadata: Metadata, parent: Node);
    renderNode(): Promise<void>;
}
