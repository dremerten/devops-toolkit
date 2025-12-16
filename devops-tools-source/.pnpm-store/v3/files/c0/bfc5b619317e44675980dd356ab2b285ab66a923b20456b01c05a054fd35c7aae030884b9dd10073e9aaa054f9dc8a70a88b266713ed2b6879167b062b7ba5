interface SchemaObjFloat extends SchemaObjBase<number> {
    format: 'float';
}

interface SchemaObjInteger extends SchemaObjBase<number> {
    format: 'integer';
}

interface SchemaObjEnum extends SchemaObjBase<string> {
    format: 'enum';
    values: string[];
}

interface SchemaObjAny extends SchemaObjBase<unknown> {
    format: 'any';
}

interface SchemaObjString extends SchemaObjBase<string> {
    format: 'string';
}

interface SchemaObjBoolean extends SchemaObjBase<boolean> {
    format: 'boolean';
}

interface SchemaObjCustom extends SchemaObjBase<unknown> {
    format: 'custom';
    validate?: (value: unknown) => boolean;
    coerce?: (value: unknown) => unknown;
}

interface SchemaObjArray extends SchemaObjBase<string[]> {
    format: 'array';
}

declare type SchemaObj = SchemaObjInteger | SchemaObjEnum | SchemaObjFloat | SchemaObjAny | SchemaObjString | SchemaObjBoolean | SchemaObjCustom | SchemaObjArray;

interface SchemaObjBase<T> {
    doc?: string;
    default: T;
    env?: string;
}
declare type Schema = {
    [k: string]: Schema | SchemaObj;
};
declare type Config = {
    [k: string]: Config | unknown;
};
declare type TypeFromSchema<T> = {
    [P in keyof T]: T[P] extends SchemaObj ? T[P]['default'] : TypeFromSchema<T[P]>;
};
declare type Env = {
    [k: string]: number | string | boolean | undefined;
};
declare class Figue<T extends Schema> {
    private schema;
    private schemaFlat;
    private env;
    private config;
    constructor(schema: T);
    loadEnv(env: Env): this;
    loadConfig(config: Config): this;
    validate(): this;
    private getValue;
    getConfig(): TypeFromSchema<T>;
}
declare const figue: <T extends Schema>(schema: T) => Figue<T>;

export { Figue, Schema, figue };
