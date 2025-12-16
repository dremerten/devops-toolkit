import { Node } from './node';
import { RegexpNode } from './regexp';
import { State } from './state';
import { Metadata } from './types';
export declare class RootNode extends Node {
    readonly regexp: RegexpNode;
    get flags(): Metadata;
    constructor(metadata: Metadata, state: State);
    renderNode(): Promise<void>;
}
