'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

const twitterCompatibility = {
  "og:description": "twitter:description",
  "og:title": "twitter:title",
  "og:image": "twitter:image",
  "og:image:url": "twitter:image",
  "og:image:alt": "twitter:image:alt"
};
function pickTwitterCompatibleMetadata({ existingMeta, twitterMeta }) {
  return existingMeta.filter(({ key }) => key in twitterCompatibility && twitterMeta.find((tm) => tm.key === twitterCompatibility[key]) === void 0).map(({ key, value }) => ({ key: twitterCompatibility[key] ?? key, value }));
}

const isObject = (v) => typeof v === "object" && !Array.isArray(v) && v !== null && !(v instanceof Date);
const toSnakeCase = (s) => s.split(":").map(toSnakeCaseStrict).join(":");
const toSnakeCaseStrict = (s) => s.match(/[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+/g)?.map((x) => x.toLowerCase()).join("_") ?? "";

function generateMetaForType({ title, flatMetadata, type }) {
  if (flatMetadata.length === 0)
    return [];
  return [`<!-- ${title} -->`, ...buildMetaStrings({ flatMetadata, type })];
}
function generateMeta({ twitter: twitterMetadataRaw, ...ogMetadataRaw }, { indentation = 0, indentWith = "  ", generateTwitterCompatibleMeta = false } = {}) {
  const ogMetadataFlat = flattenMetadata(ogMetadataRaw, { basePrefix: "og" });
  const twitterMetadataFlat = flattenMetadata(twitterMetadataRaw, { basePrefix: "twitter" });
  const metaStringGroups = [
    generateMetaForType({
      title: "og meta",
      flatMetadata: ogMetadataFlat,
      type: "property"
    }),
    generateMetaForType({
      title: "twitter meta",
      flatMetadata: [
        ...twitterMetadataFlat,
        ...generateTwitterCompatibleMeta ? pickTwitterCompatibleMetadata({ existingMeta: ogMetadataFlat, twitterMeta: twitterMetadataFlat }) : []
      ],
      type: "name"
    })
  ];
  const metaGroups = metaStringGroups.filter((group) => group && group.length > 0).map((group) => group.map((str) => indentWith.repeat(indentation) + str).join("\n"));
  return metaGroups.join("\n\n");
}
function stringifyValue(value) {
  if (value instanceof Date) {
    return value.toISOString();
  }
  return String(value);
}
function flattenMetadata(metadata, { separator = ":", basePrefix = "" } = {}) {
  const acc = [];
  const walk = (node, prefix = "") => {
    if (node === void 0 || node === "")
      return;
    if (isObject(node)) {
      for (const [key, value] of Object.entries(node)) {
        const prefixedKey = [prefix, toSnakeCase(key)].filter(Boolean).join(separator);
        walk(value, prefixedKey);
      }
    } else if (Array.isArray(node)) {
      for (const value of node) {
        walk(value, prefix);
      }
    } else {
      acc.push({ key: prefix, value: stringifyValue(node) });
    }
  };
  walk(metadata, basePrefix);
  return acc;
}
function metaToString({ flatMetadata: { key, value }, type }) {
  return `<meta ${type.trim()}="${key.trim()}" value="${value.trim()}" />`;
}
function buildMetaStrings({ flatMetadata, type }) {
  return flatMetadata.map((flatMetadata2) => metaToString({ flatMetadata: flatMetadata2, type }));
}

exports.generateMeta = generateMeta;
