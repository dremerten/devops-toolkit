'use strict';

const vue = require('@unhead/vue');
const ssr = require('@unhead/ssr');
const vue$1 = require('vue');

function createHead(initHeadObject) {
  const head = vue.createHead();
  const legacyHead = {
    headTags() {
      return head.resolveTags();
    },
    addHeadObjs(input, options) {
      return head.push(input, options);
    },
    updateDOM(document, force) {
      if (force)
        vue.renderDOMHead(head, { document });
      else
        vue.debouncedRenderDOMHead(head, { delayFn: (fn) => setTimeout(() => fn(), 50), document });
    }
  };
  head.headTags = legacyHead.headTags;
  head.addHeadObjs = legacyHead.addHeadObjs;
  head.updateDOM = legacyHead.updateDOM;
  if (initHeadObject)
    head.push(initHeadObject);
  return head;
}

const HeadVuePlugin = vue.Vue2ProvideUnheadPlugin;
const renderHeadToString = (head) => ssr.renderSSRHead(head);

const Vue2 = vue$1.version.startsWith("2.");
const IsBrowser = typeof window !== "undefined";

const addVNodeToHeadObj = (node, obj) => {
  const nodeType = Vue2 ? node.tag : node.type;
  const type = nodeType === "html" ? "htmlAttrs" : nodeType === "body" ? "bodyAttrs" : nodeType;
  if (typeof type !== "string" || !(type in obj))
    return;
  const nodeData = Vue2 ? node.data : node;
  const props = (Vue2 ? nodeData.attrs : node.props) || {};
  if (Vue2) {
    if (nodeData.staticClass)
      props.class = nodeData.staticClass;
    if (nodeData.staticStyle)
      props.style = Object.entries(nodeData.staticStyle).map(([key, value]) => `${key}:${value}`).join(";");
  }
  if (node.children) {
    const childrenAttr = Vue2 ? "text" : "children";
    props.children = Array.isArray(node.children) ? node.children[0][childrenAttr] : node[childrenAttr];
  }
  if (Array.isArray(obj[type]))
    obj[type].push(props);
  else if (type === "title")
    obj.title = props.children;
  else
    obj[type] = props;
};
const vnodesToHeadObj = (nodes) => {
  const obj = {
    title: void 0,
    htmlAttrs: void 0,
    bodyAttrs: void 0,
    base: void 0,
    meta: [],
    link: [],
    style: [],
    script: [],
    noscript: []
  };
  for (const node of nodes) {
    if (typeof node.type === "symbol" && Array.isArray(node.children)) {
      for (const childNode of node.children)
        addVNodeToHeadObj(childNode, obj);
    } else {
      addVNodeToHeadObj(node, obj);
    }
  }
  return obj;
};
const Head = /* @__PURE__ */ vue$1.defineComponent({
  name: "Head",
  setup(_, { slots }) {
    const head = vue.injectHead();
    const obj = vue$1.ref({});
    const entry = head.push(obj);
    if (IsBrowser) {
      vue$1.onBeforeUnmount(() => {
        entry.dispose();
      });
    }
    return () => {
      vue$1.watchEffect(() => {
        if (!slots.default)
          return;
        entry.patch(vnodesToHeadObj(slots.default()));
      });
      return null;
    };
  }
});

exports.VueHeadMixin = vue.VueHeadMixin;
exports.useHead = vue.useHead;
exports.useServerHead = vue.useServerHead;
exports.Head = Head;
exports.HeadVuePlugin = HeadVuePlugin;
exports.createHead = createHead;
exports.renderHeadToString = renderHeadToString;
