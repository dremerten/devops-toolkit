import _ from 'lodash';

const format$7 = {
  validate: (value) => _.isNumber(value) && !_.isNaN(value) && _.isFinite(value),
  coerce: (value) => _.isString(value) ? parseFloat(value) : value
};

const format$6 = {
  validate: (value) => _.isInteger(value),
  coerce: (value) => _.isString(value) ? parseInt(value) : value
};

const format$5 = {
  validate: (value, { values }) => _.isString(value) && values.includes(value),
  coerce: (value) => value.toString()
};

const format$4 = {
  validate: () => true,
  coerce: (value) => value
};

const format$3 = {
  validate: (value) => _.isString(value),
  coerce: (value) => value.toString()
};

const format$2 = {
  validate: () => true,
  coerce: (value) => _.isString(value) ? value.trim().toLowerCase() === "true" : Boolean(value)
};

const format$1 = {
  validate: (value, { validate }) => validate?.(value) ?? true,
  coerce: (value, { coerce }) => coerce?.(value) ?? value
};

const format = {
  validate: (value) => _.isArray(value) && value.every((item) => _.isString(item)),
  coerce: (value) => {
    if (!_.isString(value))
      return value;
    if (value === "")
      return [];
    return value.split(",");
  }
};

const formats = {
  integer: format$6,
  enum: format$5,
  float: format$7,
  any: format$4,
  string: format$3,
  boolean: format$2,
  custom: format$1,
  array: format
};

const isFalsyOrHasThrown = (cb) => {
  try {
    return !cb();
  } catch (e) {
    return true;
  }
};

function flattenSchema(schema, keys = []) {
  const acc = [];
  for (const [key, value] of Object.entries(schema)) {
    const valueHasFormat = Object.entries(value).some(([k, v]) => k === "format" && _.isString(v));
    const path = [...keys, key];
    if (_.isObject(value) && !valueHasFormat) {
      const childAcc = flattenSchema(value, path);
      acc.push(...childAcc);
    } else {
      acc.push({
        path,
        schema: value
      });
    }
  }
  return acc;
}
class Figue {
  constructor(schema) {
    this.schema = schema;
    this.env = {};
    this.schemaFlat = flattenSchema(schema);
  }
  loadEnv(env) {
    this.env = _.merge(this.env, env);
    return this;
  }
  loadConfig(config) {
    this.config = _.merge(this.config, config);
    return this;
  }
  validate() {
    const configValues = this.getConfig();
    const errors = [];
    for (const { path, schema } of this.schemaFlat) {
      const { format } = schema;
      const { validate } = formats[format] ?? {};
      if (!validate) {
        throw new Error(`[figue:invalid-format] The format '${format}' does not exist, valid formats are ${Object.keys(formats).join(", ")}.`);
      }
      const value = _.get(configValues, path);
      if (isFalsyOrHasThrown(() => validate(value, schema))) {
        errors.push(`[figue:validation-error] The key '${path}' does not comply with the format '${format}', received value ${JSON.stringify(value)}`);
      }
    }
    if (errors.length > 0) {
      throw new TypeError(errors.join("\n"));
    }
    return this;
  }
  getValue({ path, schema }) {
    const { coerce } = formats[schema.format] ?? {};
    if (!coerce) {
      throw new Error(`[figue:invalid-format] The format '${schema.format}' does not exist, valid formats are ${Object.keys(formats).join(", ")}.`);
    }
    const value = this.env[schema.env] ?? _.get(this.config, path) ?? schema.default;
    return coerce?.(value, schema) ?? value;
  }
  getConfig() {
    const config = this.schemaFlat.reduce((acc, { path, schema }) => {
      const value = this.getValue({ path, schema });
      _.set(acc, path, value);
      return acc;
    }, {});
    return config;
  }
}
const figue = (schema) => new Figue(schema);

export { Figue, figue };
