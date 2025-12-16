import { createHooks } from 'hookable';

const HasElementTags = [
  "base",
  "meta",
  "link",
  "style",
  "script",
  "noscript"
];
const ValidHeadTags = [
  "title",
  "titleTemplate",
  "base",
  "htmlAttrs",
  "bodyAttrs",
  "meta",
  "link",
  "style",
  "script",
  "noscript"
];
const TagConfigKeys = ["tagPosition", "tagPriority", "tagDuplicateStrategy"];

function normaliseTag(tagName, input) {
  const tag = { tag: tagName, props: {} };
  if (tagName === "title" || tagName === "titleTemplate") {
    tag.children = input;
    return tag;
  }
  tag.props = normaliseProps({ ...input });
  ["children", "innerHtml", "innerHTML"].forEach((key) => {
    if (typeof tag.props[key] !== "undefined") {
      tag.children = tag.props[key];
      delete tag.props[key];
    }
  });
  Object.keys(tag.props).filter((k) => TagConfigKeys.includes(k)).forEach((k) => {
    tag[k] = tag.props[k];
    delete tag.props[k];
  });
  if (typeof tag.props.class === "object" && !Array.isArray(tag.props.class)) {
    tag.props.class = Object.keys(tag.props.class).filter((k) => tag.props.class[k]);
  }
  if (Array.isArray(tag.props.class))
    tag.props.class = tag.props.class.join(" ");
  if (tag.props.content && Array.isArray(tag.props.content)) {
    return tag.props.content.map((v, i) => {
      const newTag = { ...tag, props: { ...tag.props } };
      newTag.props.content = v;
      newTag.key = `${tag.props.name || tag.props.property}:${i}`;
      return newTag;
    });
  }
  return tag;
}
function normaliseProps(props) {
  for (const k in props) {
    if (String(props[k]) === "true") {
      props[k] = "";
    } else if (String(props[k]) === "false") {
      delete props[k];
    }
  }
  return props;
}

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

const tagWeight = (tag) => {
  if (typeof tag.tagPriority === "number")
    return tag.tagPriority;
  switch (tag.tag) {
    case "base":
      return -1;
    case "title":
      return 1;
    case "meta":
      if (tag.props.charset)
        return -2;
      if (tag.props["http-equiv"] === "content-security-policy")
        return 0;
      return 10;
    default:
      return 10;
  }
};
const sortTags = (aTag, bTag) => {
  return tagWeight(aTag) - tagWeight(bTag);
};

const UniqueTags = ["base", "title", "titleTemplate", "bodyAttrs", "htmlAttrs"];
const ArrayMetaProperties = [
  "og:image",
  "og:video",
  "og:audio",
  "og:locale:alternate",
  "video:actor",
  "video:director",
  "video:writer",
  "video:tag",
  "article:author",
  "article:tag",
  "book:tag",
  "book:author",
  "music:album",
  "music:musician"
];
function tagDedupeKey(tag) {
  const { props, tag: tagName } = tag;
  if (UniqueTags.includes(tagName))
    return tagName;
  if (tagName === "link" && props.rel === "canonical")
    return "canonical";
  if (props.charset)
    return "charset";
  const name = ["id"];
  if (tagName === "meta")
    name.push(...["name", "property", "http-equiv"]);
  for (const n of name) {
    if (typeof props[n] !== "undefined") {
      const val = String(props[n]);
      if (ArrayMetaProperties.findIndex((p) => val.startsWith(p)) !== -1)
        return false;
      return `${tagName}:${n}:${val}`;
    }
  }
  return false;
}

const renderTitleTemplate = (template, title) => {
  if (template == null)
    return title || null;
  if (typeof template === "function")
    return template(title);
  return template.replace("%s", title ?? "");
};
function resolveTitleTemplateFromTags(tags) {
  const titleTemplateIdx = tags.findIndex((i) => i.tag === "titleTemplate");
  const titleIdx = tags.findIndex((i) => i.tag === "title");
  if (titleIdx !== -1 && titleTemplateIdx !== -1) {
    const newTitle = renderTitleTemplate(
      tags[titleTemplateIdx].children,
      tags[titleIdx].children
    );
    if (newTitle !== null) {
      tags[titleIdx].children = newTitle || tags[titleIdx].children;
    } else {
      delete tags[titleIdx];
    }
  } else if (titleTemplateIdx !== -1) {
    const newTitle = renderTitleTemplate(
      tags[titleTemplateIdx].children
    );
    if (newTitle !== null) {
      tags[titleTemplateIdx].children = newTitle;
      tags[titleTemplateIdx].tag = "title";
    }
  }
  if (titleTemplateIdx !== -1) {
    delete tags[titleTemplateIdx];
  }
  return tags.filter(Boolean);
}

const DedupesTagsPlugin = (options) => {
  options = options || {};
  const dedupeKeys = options.dedupeKeys || ["hid", "vmid", "key"];
  return defineHeadPlugin({
    hooks: {
      "tag:normalise": function({ tag }) {
        dedupeKeys.forEach((key) => {
          if (tag.props[key]) {
            tag.key = tag.props[key];
            delete tag.props[key];
          }
        });
        const dedupe = tag.key ? `${tag.tag}:${tag.key}` : tagDedupeKey(tag);
        if (dedupe)
          tag._d = dedupe;
      },
      "tags:resolve": function(ctx) {
        const deduping = {};
        ctx.tags.forEach((tag) => {
          let dedupeKey = tag._d || tag._p;
          const dupedTag = deduping[dedupeKey];
          if (dupedTag) {
            let strategy = tag?.tagDuplicateStrategy;
            if (!strategy && (tag.tag === "htmlAttrs" || tag.tag === "bodyAttrs"))
              strategy = "merge";
            if (strategy === "merge") {
              const oldProps = dupedTag.props;
              ["class", "style"].forEach((key) => {
                if (tag.props[key] && oldProps[key]) {
                  if (key === "style" && !oldProps[key].endsWith(";"))
                    oldProps[key] += ";";
                  tag.props[key] = `${oldProps[key]} ${tag.props[key]}`;
                }
              });
              deduping[dedupeKey].props = {
                ...oldProps,
                ...tag.props
              };
              return;
            } else if (tag._e === dupedTag._e) {
              dedupeKey = tag._d = `${dedupeKey}:${tag._p}`;
            }
            const propCount = Object.keys(tag.props).length;
            if ((propCount === 0 || propCount === 1 && typeof tag.props["data-h-key"] !== "undefined") && !tag.children) {
              delete deduping[dedupeKey];
              return;
            }
          }
          deduping[dedupeKey] = tag;
        });
        ctx.tags = Object.values(deduping);
      }
    }
  });
};

const SortTagsPlugin = () => {
  return defineHeadPlugin({
    hooks: {
      "tags:resolve": (ctx) => {
        const tagIndexForKey = (key) => ctx.tags.find((tag) => tag._d === key)?._p;
        for (const tag of ctx.tags) {
          if (!tag.tagPriority || typeof tag.tagPriority === "number")
            continue;
          const modifiers = [{ prefix: "before:", offset: -1 }, { prefix: "after:", offset: 1 }];
          for (const { prefix, offset } of modifiers) {
            if (tag.tagPriority.startsWith(prefix)) {
              const key = tag.tagPriority.replace(prefix, "");
              const index = tagIndexForKey(key);
              if (typeof index !== "undefined")
                tag._p = index + offset;
            }
          }
        }
        ctx.tags.sort((a, b) => a._p - b._p).sort(sortTags);
      }
    }
  });
};

const TitleTemplatePlugin = () => {
  return defineHeadPlugin({
    hooks: {
      "tags:resolve": (ctx) => {
        ctx.tags = resolveTitleTemplateFromTags(ctx.tags);
      }
    }
  });
};

const DeprecatedTagAttrPlugin = () => {
  return defineHeadPlugin({
    hooks: {
      "tag:normalise": function({ tag }) {
        if (typeof tag.props.body !== "undefined") {
          tag.tagPosition = "bodyClose";
          delete tag.props.body;
        }
      }
    }
  });
};

const IsBrowser = typeof window !== "undefined";

const ProvideTagHashPlugin = () => {
  return defineHeadPlugin({
    hooks: {
      "tag:normalise": (ctx) => {
        const { tag, entry } = ctx;
        if (!HasElementTags.includes(tag.tag))
          return;
        const isBrowser = IsBrowser || getActiveHead()?.resolvedOptions?.document;
        if (!isBrowser && entry._m === "server" && tag.key)
          tag.props["data-h-key"] = tag._d;
      }
    }
  });
};

const PatchDomOnEntryUpdatesPlugin = (options) => {
  return defineHeadPlugin({
    hooks: {
      "entries:updated": function(head) {
        if (typeof options?.document === "undefined" && typeof window === "undefined")
          return;
        let delayFn = options?.delayFn;
        if (!delayFn && typeof requestAnimationFrame !== "undefined")
          delayFn = requestAnimationFrame;
        import('@unhead/dom').then(({ debouncedRenderDOMHead }) => {
          debouncedRenderDOMHead(head, { document: options?.document || window.document, delayFn });
        });
      }
    }
  });
};

const EventHandlersPlugin = () => {
  const stripEventHandlers = (tag) => {
    const props = {};
    const eventHandlers = {};
    Object.entries(tag.props).forEach(([key, value]) => {
      if (key.startsWith("on") && typeof value === "function")
        eventHandlers[key] = value;
      else
        props[key] = value;
    });
    return { props, eventHandlers };
  };
  return defineHeadPlugin({
    hooks: {
      "ssr:render": function(ctx) {
        ctx.tags = ctx.tags.map((tag) => {
          tag.props = stripEventHandlers(tag).props;
          return tag;
        });
      },
      "dom:beforeRenderTag": function(ctx) {
        const { props, eventHandlers } = stripEventHandlers(ctx.tag);
        if (!Object.keys(eventHandlers).length)
          return;
        ctx.tag.props = props;
        ctx.tag._eventHandlers = eventHandlers;
      },
      "dom:renderTag": function(ctx) {
        const $el = ctx.$el;
        if (!ctx.tag._eventHandlers || !$el)
          return;
        Object.entries(ctx.tag._eventHandlers).forEach(([k, value]) => {
          const sdeKey = `${ctx.tag._d || ctx.tag._p}:${k}`;
          const eventName = k.slice(2).toLowerCase();
          const handler = value;
          $el?.addEventListener(eventName, handler);
          ctx.entry._sde[sdeKey] = () => {
            $el.removeEventListener(eventName, handler);
          };
          delete ctx.queuedSideEffects[sdeKey];
        });
      }
    }
  });
};

function asArray(value) {
  return Array.isArray(value) ? value : [value];
}

let activeHead;
const setActiveHead = (head) => activeHead = head;
const getActiveHead = () => activeHead;

function useHead(input, options = {}) {
  const head = getActiveHead();
  const isBrowser = IsBrowser || head.resolvedOptions?.document;
  if (options.mode === "server" && isBrowser || options.mode === "client" && !isBrowser)
    return;
  head.push(input, options);
}
const useTagTitle = (title) => {
  useHead({ title });
};
const useTagBase = (base) => {
  useHead({ base });
};
const useTagMeta = (meta) => {
  useHead({ meta: asArray(meta) });
};
const useTagMetaFlat = (meta) => {
  useTagMeta(unpackMeta(meta));
};
const useTagLink = (link) => {
  useHead({ link: asArray(link) });
};
const useTagScript = (script) => {
  useHead({ script: asArray(script) });
};
const useTagStyle = (style) => {
  useHead({ style: asArray(style) });
};
const useTagNoscript = (noscript) => {
  useHead({ noscript: asArray(noscript) });
};
const useHtmlAttrs = (attrs) => {
  useHead({ htmlAttrs: attrs });
};
const useBodyAttrs = (attrs) => {
  useHead({ bodyAttrs: attrs });
};
const useTitleTemplate = (titleTemplate) => {
  useHead({ titleTemplate });
};

function useServerHead(input, options = {}) {
  useHead(input, { ...options, mode: "server" });
}
const useServerTagTitle = (title) => {
  useServerHead({ title });
};
const useServerTagBase = (base) => {
  useServerHead({ base });
};
const useServerTagMeta = (meta) => {
  useServerHead({ meta: asArray(meta) });
};
const useServerTagMetaFlat = (meta) => {
  useServerTagMeta(unpackMeta(meta));
};
const useServerTagLink = (link) => {
  useServerHead({ link: asArray(link) });
};
const useServerTagScript = (script) => {
  useServerHead({ script: asArray(script) });
};
const useServerTagStyle = (style) => {
  useServerHead({ style: asArray(style) });
};
const useServerTagNoscript = (noscript) => {
  useServerHead({ noscript: asArray(noscript) });
};
const useServerHtmlAttrs = (attrs) => {
  useServerHead({ htmlAttrs: attrs });
};
const useServerBodyAttrs = (attrs) => {
  useServerHead({ bodyAttrs: attrs });
};
const useServerTitleTemplate = (titleTemplate) => {
  useServerHead({ titleTemplate });
};

const TagEntityBits = 10;

function normaliseEntryTags(e) {
  return Object.entries(e.input).filter(([k, v]) => typeof v !== "undefined" && ValidHeadTags.includes(k)).map(
    ([k, value]) => asArray(value).map((props) => asArray(normaliseTag(k, props)))
  ).flat(3).map((t, i) => {
    t._e = e._i;
    t._p = (e._i << TagEntityBits) + i;
    return t;
  });
}

function createHead(options = {}) {
  let entries = [];
  let _sde = {};
  let _eid = 0;
  const hooks = createHooks();
  if (options?.hooks)
    hooks.addHooks(options.hooks);
  options.plugins = [
    DeprecatedTagAttrPlugin(),
    DedupesTagsPlugin(),
    SortTagsPlugin(),
    TitleTemplatePlugin(),
    EventHandlersPlugin(),
    ProvideTagHashPlugin(),
    PatchDomOnEntryUpdatesPlugin({ document: options?.document, delayFn: options?.domDelayFn }),
    ...options?.plugins || []
  ];
  options.plugins.forEach((p) => p.hooks && hooks.addHooks(p.hooks));
  const triggerUpdateHook = () => hooks.callHook("entries:updated", head);
  const head = {
    resolvedOptions: options,
    _popSideEffectQueue() {
      const sde = { ..._sde };
      _sde = {};
      return sde;
    },
    headEntries() {
      return entries;
    },
    get hooks() {
      return hooks;
    },
    push(input, options2) {
      const activeEntry = {
        _i: _eid++,
        input,
        _sde: {}
      };
      if (options2?.mode)
        activeEntry._m = options2?.mode;
      entries.push(activeEntry);
      triggerUpdateHook();
      const queueSideEffects = (e) => {
        _sde = { ..._sde, ...e._sde || {} };
        e._sde = {};
        triggerUpdateHook();
      };
      return {
        dispose() {
          entries = entries.filter((e) => {
            if (e._i !== activeEntry._i)
              return true;
            queueSideEffects(e);
            return false;
          });
        },
        patch(input2) {
          entries = entries.map((e) => {
            if (e._i === activeEntry._i) {
              queueSideEffects(e);
              activeEntry.input = e.input = input2;
              activeEntry._i = e._i = _eid++;
            }
            return e;
          });
        }
      };
    },
    async resolveTags() {
      const resolveCtx = { tags: [], entries: [...entries] };
      await hooks.callHook("entries:resolve", resolveCtx);
      for (const entry of resolveCtx.entries) {
        for (const tag of normaliseEntryTags(entry)) {
          const tagCtx = { tag, entry };
          await hooks.callHook("tag:normalise", tagCtx);
          resolveCtx.tags.push(tagCtx.tag);
        }
      }
      await hooks.callHook("tags:resolve", resolveCtx);
      return resolveCtx.tags;
    }
  };
  head.hooks.callHook("init", head);
  setActiveHead(head);
  return head;
}

function defineHeadPlugin(plugin) {
  return plugin;
}

export { DedupesTagsPlugin, DeprecatedTagAttrPlugin, EventHandlersPlugin, PatchDomOnEntryUpdatesPlugin, ProvideTagHashPlugin, SortTagsPlugin, TitleTemplatePlugin, activeHead, asArray, createHead, defineHeadPlugin, getActiveHead, normaliseEntryTags, setActiveHead, useBodyAttrs, useHead, useHtmlAttrs, useServerBodyAttrs, useServerHead, useServerHtmlAttrs, useServerTagBase, useServerTagLink, useServerTagMeta, useServerTagMetaFlat, useServerTagNoscript, useServerTagScript, useServerTagStyle, useServerTagTitle, useServerTitleTemplate, useTagBase, useTagLink, useTagMeta, useTagMetaFlat, useTagNoscript, useTagScript, useTagStyle, useTagTitle, useTitleTemplate };
