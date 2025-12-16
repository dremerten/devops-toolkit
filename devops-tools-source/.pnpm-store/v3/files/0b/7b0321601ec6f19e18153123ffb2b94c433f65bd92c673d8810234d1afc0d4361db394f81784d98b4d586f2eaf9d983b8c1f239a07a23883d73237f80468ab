import { resolveUnref } from '@vueuse/shared';
import { unref, version, getCurrentInstance, inject, nextTick, ref, watchEffect, watch, onBeforeUnmount } from 'vue';
import { getActiveHead, createHead as createHead$1, defineHeadPlugin } from 'unhead';
export * from '@unhead/dom';

function resolveUnrefHeadInput(ref) {
  const root = resolveUnref(ref);
  if (!ref || !root)
    return root;
  if (Array.isArray(root))
    return root.map(resolveUnrefHeadInput);
  if (typeof root === "object") {
    return Object.fromEntries(
      Object.entries(root).map(([key, value]) => {
        if (key === "titleTemplate" || key.startsWith("on"))
          return [key, unref(value)];
        return [key, resolveUnrefHeadInput(value)];
      })
    );
  }
  return root;
}
function asArray(value) {
  return Array.isArray(value) ? value : [value];
}

const Vue3 = version.startsWith("3");
const IsBrowser = typeof window !== "undefined";

const headSymbol = "usehead";
function injectHead() {
  return getCurrentInstance() && inject(headSymbol) || getActiveHead();
}
function createHead(options = {}) {
  const plugins = [
    VueReactiveUseHeadPlugin(),
    ...options?.plugins || []
  ];
  const head = createHead$1({
    ...options,
    domDelayFn: (fn) => setTimeout(() => nextTick(() => fn()), 10),
    plugins
  });
  head.install = (app) => {
    if (Vue3) {
      app.config.globalProperties.$unhead = head;
      app.provide(headSymbol, head);
    }
  };
  return head;
}

const VueHeadMixin = {
  created() {
    const instance = getCurrentInstance();
    if (!instance)
      return;
    const options = instance.type;
    if (!options || !("head" in options))
      return;
    const source = typeof options.head === "function" ? () => options.head() : options.head;
    useHead(source);
  }
};

const VueReactiveUseHeadPlugin = () => {
  return defineHeadPlugin({
    hooks: {
      "entries:resolve": function(ctx) {
        for (const entry of ctx.entries)
          entry.input = resolveUnrefHeadInput(entry.input);
      }
    }
  });
};

const Vue2ProvideUnheadPlugin = function(_Vue, head) {
  _Vue.mixin({
    beforeCreate() {
      const options = this.$options;
      const origProvide = options.provide;
      options.provide = function() {
        let origProvideResult;
        if (typeof origProvide === "function")
          origProvideResult = origProvide.call(this);
        else
          origProvideResult = origProvide || {};
        return {
          ...origProvideResult,
          [headSymbol]: head
        };
      };
    }
  });
};

function unpackToArray(input, options) {
  const unpacked = [];
  const kFn = options.resolveKeyData || ((ctx) => ctx.key);
  const vFn = options.resolveValueData || ((ctx) => ctx.value);
  for (const [k, v] of Object.entries(input)) {
    unpacked.push(...(Array.isArray(v) ? v : [v]).map((i) => {
      const ctx = { key: k, value: i };
      const val = vFn(ctx);
      if (typeof val === "object")
        return unpackToArray(val, options);
      if (Array.isArray(val))
        return val;
      return {
        [typeof options.key === "function" ? options.key(ctx) : options.key]: kFn(ctx),
        [typeof options.value === "function" ? options.value(ctx) : options.value]: val
      };
    }).flat());
  }
  return unpacked;
}

function unpackToString(value, options) {
  return Object.entries(value).map(([key, value2]) => {
    if (typeof value2 === "object")
      value2 = unpackToString(value2, options);
    if (options.resolve) {
      const resolved = options.resolve({ key, value: value2 });
      if (resolved)
        return resolved;
    }
    if (typeof value2 === "number")
      value2 = value2.toString();
    if (typeof value2 === "string" && options.wrapValue) {
      value2 = value2.replace(new RegExp(options.wrapValue, "g"), `\\${options.wrapValue}`);
      value2 = `${options.wrapValue}${value2}${options.wrapValue}`;
    }
    return `${key}${options.keyValueSeparator || ""}${value2}`;
  }).join(options.entrySeparator || "");
}

const MetaPackingSchema = {
  robots: {
    unpack: {
      keyValueSeparator: ":"
    }
  },
  contentSecurityPolicy: {
    unpack: {
      keyValueSeparator: " ",
      entrySeparator: "; "
    },
    metaKey: "http-equiv"
  },
  fbAppId: {
    keyValue: "fb:app_id",
    metaKey: "property"
  },
  msapplicationTileImage: {
    keyValue: "msapplication-TileImage"
  },
  msapplicationTileColor: {
    keyValue: "msapplication-TileColor"
  },
  msapplicationConfig: {
    keyValue: "msapplication-Config"
  },
  charset: {
    metaKey: "charset"
  },
  contentType: {
    metaKey: "http-equiv"
  },
  defaultStyle: {
    metaKey: "http-equiv"
  },
  xUaCompatible: {
    metaKey: "http-equiv"
  },
  refresh: {
    metaKey: "http-equiv"
  }
};
function resolveMetaKeyType(key) {
  return PropertyPrefixKeys.test(key) ? "property" : MetaPackingSchema[key]?.metaKey || "name";
}

function unpackMeta(input) {
  return unpackToArray(input, {
    key({ key }) {
      return resolveMetaKeyType(key);
    },
    value({ key }) {
      return key === "charset" ? "charset" : "content";
    },
    resolveKeyData({ key }) {
      return MetaPackingSchema[key]?.keyValue || fixKeyCase(key);
    },
    resolveValueData({ value, key }) {
      if (typeof value === "object") {
        const definition = MetaPackingSchema[key];
        if (key === "refresh")
          return `${value.seconds};url=${value.url}`;
        return unpackToString(
          changeKeyCasingDeep(value),
          {
            entrySeparator: ", ",
            keyValueSeparator: "=",
            resolve({ value: value2, key: key2 }) {
              if (typeof value2 === "boolean")
                return `${key2}`;
            },
            ...definition?.unpack
          }
        );
      }
      return typeof value === "number" ? value.toString() : value;
    }
  });
}

const PropertyPrefixKeys = /^(og|twitter|fb)/;
function fixKeyCase(key) {
  key = key.replace(/([A-Z])/g, "-$1").toLowerCase();
  if (PropertyPrefixKeys.test(key)) {
    key = key.replace("secure-url", "secure_url").replace(/-/g, ":");
  }
  return key;
}
function changeKeyCasingDeep(input) {
  if (Array.isArray(input)) {
    return input.map((entry) => changeKeyCasingDeep(entry));
  }
  if (typeof input !== "object" || Array.isArray(input))
    return input;
  const output = {};
  for (const [key, value] of Object.entries(input))
    output[fixKeyCase(key)] = changeKeyCasingDeep(value);
  return output;
}

function clientUseHead(input, options = {}) {
  const head = injectHead();
  const vm = getCurrentInstance();
  if (!vm) {
    head.push(input, options);
    return;
  }
  const resolvedInput = ref({});
  watchEffect(() => {
    resolvedInput.value = resolveUnrefHeadInput(input);
  });
  let entry;
  watch(resolvedInput, (e) => {
    if (!entry)
      entry = head.push(e, options);
    else
      entry.patch(e);
  }, { immediate: true });
  onBeforeUnmount(() => {
    entry?.dispose();
  });
}

function serverUseHead(input, options = {}) {
  const head = injectHead();
  head.push(input, options);
}

function useServerHead(input, options = {}) {
  useHead(input, { ...options, mode: "server" });
}
const useServerTagTitle = (title) => useServerHead({ title });
const useServerTitleTemplate = (titleTemplate) => useServerHead({ titleTemplate });
const useServerTagMeta = (meta) => useServerHead({ meta: asArray(meta) });
const useServerTagMetaFlat = (meta) => {
  const input = ref({});
  watchEffect(() => {
    input.value = unpackMeta(resolveUnrefHeadInput(meta));
  });
  return useServerHead({ meta: input });
};
const useServerTagLink = (link) => useServerHead({ link: asArray(link) });
const useServerTagScript = (script) => useServerHead({ script: asArray(script) });
const useServerTagStyle = (style) => useServerHead({ style: asArray(style) });
const useServerTagNoscript = (noscript) => useServerHead({ noscript: asArray(noscript) });
const useServerTagBase = (base) => useServerHead({ base });
const useServerHtmlAttrs = (attrs) => useServerHead({ htmlAttrs: attrs });
const useServerBodyAttrs = (attrs) => useHead({ bodyAttrs: attrs });

function useHead(input, options = {}) {
  const head = injectHead();
  const isBrowser = IsBrowser || head.resolvedOptions?.document;
  if (options.mode === "server" && isBrowser || options.mode === "client" && !isBrowser)
    return;
  IsBrowser ? clientUseHead(input, options) : serverUseHead(input, options);
}
const useTagTitle = (title) => useHead({ title });
const useTitleTemplate = (titleTemplate) => useHead({ titleTemplate });
const useTagMeta = (meta) => useHead({ meta: asArray(meta) });
const useTagMetaFlat = (meta) => {
  const input = ref({});
  watchEffect(() => {
    input.value = unpackMeta(resolveUnrefHeadInput(meta));
  });
  return useHead({ meta: input });
};
const useTagLink = (link) => useHead({ link: asArray(link) });
const useTagScript = (script) => useHead({ script: asArray(script) });
const useTagStyle = (style) => useHead({ style: asArray(style) });
const useTagNoscript = (noscript) => useHead({ noscript: asArray(noscript) });
const useTagBase = (base) => useHead({ base });
const useHtmlAttrs = (attrs) => useHead({ htmlAttrs: attrs });
const useBodyAttrs = (attrs) => useHead({ bodyAttrs: attrs });

export { Vue2ProvideUnheadPlugin, VueHeadMixin, VueReactiveUseHeadPlugin, asArray, createHead, headSymbol, injectHead, resolveUnrefHeadInput, useBodyAttrs, useHead, useHtmlAttrs, useServerBodyAttrs, useServerHead, useServerHtmlAttrs, useServerTagBase, useServerTagLink, useServerTagMeta, useServerTagMetaFlat, useServerTagNoscript, useServerTagScript, useServerTagStyle, useServerTagTitle, useServerTitleTemplate, useTagBase, useTagLink, useTagMeta, useTagMetaFlat, useTagNoscript, useTagScript, useTagStyle, useTagTitle, useTitleTemplate };
