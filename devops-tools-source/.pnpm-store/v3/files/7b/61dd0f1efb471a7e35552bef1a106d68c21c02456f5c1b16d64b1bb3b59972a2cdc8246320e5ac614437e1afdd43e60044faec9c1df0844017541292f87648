import Lexer from 'flex-js';
/**
 * The result of a conversion. The result contains the docker-compose.yml and
 * additional {@link Message}s.
 */
export declare class ComposerizeResult {
    constructor(yaml: string, messages: Array<Message>);
    yaml: string;
    messages: Array<Message>;
}
/**
 * A docker option which is supported by this library with it's corresponding docker-compose equivalent.
 */
export declare class SupportedOption {
    constructor(dockerOption: string, composeEquivalent: string, shortOption?: string);
    dockerOption: string;
    composeEquivalent: string;
}
/**
 * The type of a returned {@link Message}.
 */
export declare enum MessageType {
    notImplemented = "notImplemented",
    notTranslatable = "notTranslatable",
    errorDuringConversion = "errorDuringConversion"
}
/**
 * A message which could be returned.
 */
export interface Message {
    type: MessageType;
    value: string;
}
/**
 * @internal
 */
export declare class ParseResult {
    serviceName: string;
    properties: Array<CallbackResult>;
    messages: Array<Message>;
    additionalComposeObjects: Array<object>;
}
/**
 * @internal
 */
export type LexerActionCallback = (option: Option, value?: any, lexer?: Lexer) => CallbackResult | Message | undefined;
/**
 * @internal
 */
export interface CallbackResult {
    path: string;
    value: object;
    multiValue: boolean;
    additionalObject: object | undefined;
}
/**
 * @internal
 */
export declare enum OptionType {
    flag = 0,
    withArgs = 1
}
/**
 * @internal
 */
export interface Options {
    [name: string]: Option;
}
/**
 * @internal
 */
export interface Option {
    name: string;
    short?: string;
    path: string;
    type: OptionType;
    multiValue: boolean;
    composeType?: string;
    action: LexerActionCallback;
}
