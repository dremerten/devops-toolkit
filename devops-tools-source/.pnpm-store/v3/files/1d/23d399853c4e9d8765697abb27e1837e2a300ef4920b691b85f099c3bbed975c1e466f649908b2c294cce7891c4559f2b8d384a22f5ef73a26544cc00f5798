export declare type Options = {
    onChange?: (status: {
        progress: number;
    }) => void;
};
/**
 * State tracking for an in-progress parse and render
 */
export declare class State {
    /**
     * Tracks the number of capture groups in the expression
     */
    groupCounter: number;
    /**
     * Cancels the in-progress render when set to true
     */
    cancelRender: boolean;
    /**
     * Warnings that have been generated while rendering
     */
    readonly warnings: string[];
    private readonly options;
    private renderCounter;
    private maxCounter;
    constructor(options?: Options);
    private update;
    inc(): void;
    dec(): void;
}
