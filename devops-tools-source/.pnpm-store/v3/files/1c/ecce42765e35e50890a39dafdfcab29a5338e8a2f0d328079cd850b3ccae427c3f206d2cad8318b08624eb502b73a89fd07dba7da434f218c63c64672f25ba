'use strict';

const utilities = require('./utilities.cjs');
const variants$1 = require('./variants.cjs');
const core = require('@unocss/core');

const regexCache = {};
const calcMaxWidthBySize = (size) => {
  const value = size.match(/^-?[0-9]+\.?[0-9]*/)?.[0] || "";
  const unit = size.slice(value.length);
  const maxWidth = parseFloat(value) - 0.1;
  return Number.isNaN(maxWidth) ? size : `${maxWidth}${unit}`;
};
const variantBreakpoints = {
  match(matcher, context) {
    const variantEntries = Object.entries(utilities.resolveBreakpoints(context) ?? {}).map(([point, size], idx) => [point, size, idx]);
    for (const [point, size, idx] of variantEntries) {
      if (!regexCache[point])
        regexCache[point] = new RegExp(`^((?:[al]t-)?${point}[:-])`);
      const match = matcher.match(regexCache[point]);
      if (!match)
        continue;
      const [, pre] = match;
      const m = matcher.slice(pre.length);
      if (m === "container")
        continue;
      const isLtPrefix = pre.startsWith("lt-");
      const isAtPrefix = pre.startsWith("at-");
      let order = 1e3;
      if (isLtPrefix) {
        order -= idx + 1;
        return {
          matcher: m,
          parent: [`@media (max-width: ${calcMaxWidthBySize(size)})`, order]
        };
      }
      order += idx + 1;
      if (isAtPrefix && idx < variantEntries.length - 1) {
        return {
          matcher: m,
          parent: [`@media (min-width: ${size}) and (max-width: ${calcMaxWidthBySize(variantEntries[idx + 1][1])})`, order]
        };
      }
      return {
        matcher: m,
        parent: [`@media (min-width: ${size})`, order]
      };
    }
  },
  autocomplete: "(at-|lt-|)$breakpoints:"
};

const scopeMatcher = (strict, name, template) => {
  const re = strict ? new RegExp(`^${name}(?:-\\[(.+?)\\])[:-]`) : new RegExp(`^${name}(?:-\\[(.+?)\\])?[:-]`);
  return (matcher) => {
    const match = matcher.match(re);
    if (match) {
      return {
        matcher: matcher.slice(match[0].length),
        selector: (s) => template.replace("&&-s", s).replace("&&-c", match[1] ?? "*")
      };
    }
  };
};
const variantCombinators = [
  scopeMatcher(false, "all", "&&-s &&-c"),
  scopeMatcher(false, "children", "&&-s>&&-c"),
  scopeMatcher(false, "next", "&&-s+&&-c"),
  scopeMatcher(false, "sibling", "&&-s+&&-c"),
  scopeMatcher(false, "siblings", "&&-s~&&-c"),
  scopeMatcher(true, "group", "&&-c &&-s"),
  scopeMatcher(true, "parent", "&&-c>&&-s"),
  scopeMatcher(true, "previous", "&&-c+&&-s"),
  scopeMatcher(true, "peer", "&&-c~&&-s")
];

const variantPrint = variants$1.variantParentMatcher("print", "@media print");
const variantCustomMedia = (matcher, { theme }) => {
  const match = matcher.match(/^media-([_\d\w]+)[:-]/);
  if (match) {
    const media = theme.media?.[match[1]] ?? `(--${match[1]})`;
    return {
      matcher: matcher.slice(match[0].length),
      parent: `@media ${media}`
    };
  }
};

const variantColorsMediaOrClass = (options = {}) => {
  if (options?.dark === "class") {
    return [
      variants$1.variantMatcher("dark", (input) => `.dark $$ ${input}`),
      variants$1.variantMatcher("light", (input) => `.light $$ ${input}`)
    ];
  }
  return [
    variants$1.variantParentMatcher("dark", "@media (prefers-color-scheme: dark)"),
    variants$1.variantParentMatcher("light", "@media (prefers-color-scheme: light)")
  ];
};

const variantLanguageDirections = [
  variants$1.variantMatcher("rtl", (input) => `[dir="rtl"] $$ ${input}`),
  variants$1.variantMatcher("ltr", (input) => `[dir="ltr"] $$ ${input}`)
];

const variantSelector = {
  match(matcher) {
    const match = matcher.match(/^selector-\[(.+?)\][:-]/);
    if (match) {
      return {
        matcher: matcher.slice(match[0].length),
        selector: () => match[1]
      };
    }
  }
};
const variantLayer = {
  match(matcher) {
    const match = matcher.match(/^layer-([_\d\w]+)[:-]/);
    if (match) {
      return {
        matcher: matcher.slice(match[0].length),
        layer: match[1]
      };
    }
  }
};
const variantScope = {
  match(matcher) {
    const match = matcher.match(/^scope-([_\d\w]+)[:-]/);
    if (match) {
      return {
        matcher: matcher.slice(match[0].length),
        selector: (s) => `.${match[1]} $$ ${s}`
      };
    }
  }
};
const variantImportant = {
  match(matcher) {
    const match = matcher.match(/^(important[:-]|!)/);
    if (match) {
      return {
        matcher: matcher.slice(match[0].length),
        body: (body) => {
          body.forEach((v) => {
            if (v[1])
              v[1] += " !important";
          });
          return body;
        }
      };
    }
  },
  autocomplete: "(important)"
};
const variantNegative = {
  match(matcher) {
    if (matcher.startsWith("-")) {
      return {
        matcher: matcher.slice(1),
        body: (body) => {
          body.forEach((v) => {
            if (v[0].startsWith("--un-scale") || v[1]?.toString() === "0")
              return;
            v[1] = v[1]?.toString().replace(/[0-9.]+(?:[a-z]+|%)?/, (i) => `-${i}`);
          });
          return body;
        }
      };
    }
  }
};

const PseudoClasses = Object.fromEntries([
  "any-link",
  "link",
  "visited",
  "target",
  ["open", "[open]"],
  "hover",
  "active",
  "focus-visible",
  "focus-within",
  "focus",
  "autofill",
  "enabled",
  "disabled",
  "read-only",
  "read-write",
  "placeholder-shown",
  "default",
  "checked",
  "indeterminate",
  "valid",
  "invalid",
  "in-range",
  "out-of-range",
  "required",
  "optional",
  "root",
  "empty",
  ["even-of-type", ":nth-of-type(even)"],
  ["even", ":nth-child(even)"],
  ["odd-of-type", ":nth-of-type(odd)"],
  ["odd", ":nth-child(odd)"],
  "first-of-type",
  ["first", ":first-child"],
  "last-of-type",
  ["last", ":last-child"],
  "only-child",
  "only-of-type"
].map(core.toArray));
const PseudoElements = Object.fromEntries([
  "placeholder",
  "before",
  "after",
  "first-letter",
  "first-line",
  "selection",
  "marker",
  ["file", "::file-selector-button"]
].map(core.toArray));
const PseudoClassFunctions = [
  "not",
  "is",
  "where",
  "has"
];
const PseudoElementsStr = Object.keys(PseudoElements).join("|");
const PseudoClassesStr = Object.keys(PseudoClasses).join("|");
const PseudoClassFunctionsStr = PseudoClassFunctions.join("|");
const PartClassesRE = /(part-\[(.+)]:)(.+)/;
const PseudoElementsRE = new RegExp(`^(${PseudoElementsStr})[:-]`);
const PseudoClassesRE = new RegExp(`^(${PseudoClassesStr})[:-]`);
const PseudoClassFunctionsRE = new RegExp(`^(${PseudoClassFunctionsStr})-(${PseudoClassesStr})[:-]`);
const sortValue = (pseudo) => {
  if (pseudo === "active")
    return 1;
};
const taggedPseudoClassMatcher = (tag, parent, combinator) => {
  const re = new RegExp(`^${tag}-((?:(${PseudoClassFunctionsStr})-)?(${PseudoClassesStr}))[:-]`);
  const rawRe = new RegExp(`^${core.escapeRegExp(parent)}:`);
  return (input) => {
    const match = input.match(re);
    if (match) {
      let pseudo = PseudoClasses[match[3]] || `:${match[3]}`;
      if (match[2])
        pseudo = `:${match[2]}(${pseudo})`;
      return {
        matcher: input.slice(match[0].length),
        selector: (s) => rawRe.test(s) ? s.replace(rawRe, `${parent}${pseudo}:`) : `${parent}${pseudo}${combinator}${s}`,
        sort: sortValue(match[3])
      };
    }
  };
};
const variantPseudoElements = {
  match: (input) => {
    const match = input.match(PseudoElementsRE);
    if (match) {
      const pseudo = PseudoElements[match[1]] || `::${match[1]}`;
      return {
        matcher: input.slice(match[0].length),
        selector: (s) => `${s}${pseudo}`
      };
    }
  },
  autocomplete: `(${PseudoElementsStr}):`
};
const variantPseudoClasses = {
  match: (input) => {
    const match = input.match(PseudoClassesRE);
    if (match) {
      const pseudo = PseudoClasses[match[1]] || `:${match[1]}`;
      return {
        matcher: input.slice(match[0].length),
        selector: (s) => `${s}${pseudo}`,
        sort: sortValue(match[1])
      };
    }
  },
  multiPass: true,
  autocomplete: `(${PseudoClassesStr}):`
};
const variantPseudoClassFunctions = {
  match: (input) => {
    const match = input.match(PseudoClassFunctionsRE);
    if (match) {
      const fn = match[1];
      const pseudo = PseudoClasses[match[2]] || `:${match[2]}`;
      return {
        matcher: input.slice(match[0].length),
        selector: (s) => `${s}:${fn}(${pseudo})`
      };
    }
  },
  multiPass: true,
  autocomplete: `(${PseudoClassFunctionsStr})-(${PseudoClassesStr}):`
};
const variantTaggedPseudoClasses = (options = {}) => {
  const attributify = !!options?.attributifyPseudo;
  return [
    {
      match: taggedPseudoClassMatcher("group", attributify ? '[group=""]' : ".group", " "),
      multiPass: true
    },
    {
      match: taggedPseudoClassMatcher("peer", attributify ? '[peer=""]' : ".peer", "~"),
      multiPass: true
    },
    {
      match: taggedPseudoClassMatcher("parent", attributify ? '[parent=""]' : ".parent", ">"),
      multiPass: true
    },
    {
      match: taggedPseudoClassMatcher("previous", attributify ? '[previous=""]' : ".previous", "+"),
      multiPass: true
    }
  ];
};
const partClasses = {
  match: (input) => {
    const match = input.match(PartClassesRE);
    if (match) {
      const part = `part(${match[2]})`;
      return {
        matcher: input.slice(match[1].length),
        selector: (s) => `${s}::${part}`
      };
    }
  },
  multiPass: true
};

const variants = (options) => [
  variantSelector,
  variantLayer,
  variantNegative,
  variantImportant,
  variantPrint,
  variantCustomMedia,
  variantBreakpoints,
  ...variantCombinators,
  variantPseudoClasses,
  variantPseudoClassFunctions,
  ...variantTaggedPseudoClasses(options),
  variantPseudoElements,
  partClasses,
  ...variantColorsMediaOrClass(options),
  ...variantLanguageDirections,
  variantScope
];

exports.partClasses = partClasses;
exports.variantBreakpoints = variantBreakpoints;
exports.variantColorsMediaOrClass = variantColorsMediaOrClass;
exports.variantCombinators = variantCombinators;
exports.variantCustomMedia = variantCustomMedia;
exports.variantImportant = variantImportant;
exports.variantLanguageDirections = variantLanguageDirections;
exports.variantLayer = variantLayer;
exports.variantNegative = variantNegative;
exports.variantPrint = variantPrint;
exports.variantPseudoClassFunctions = variantPseudoClassFunctions;
exports.variantPseudoClasses = variantPseudoClasses;
exports.variantPseudoElements = variantPseudoElements;
exports.variantScope = variantScope;
exports.variantSelector = variantSelector;
exports.variantTaggedPseudoClasses = variantTaggedPseudoClasses;
exports.variants = variants;
