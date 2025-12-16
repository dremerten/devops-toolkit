import { createHead as createHead$1, renderDOMHead, debouncedRenderDOMHead, Vue2ProvideUnheadPlugin, injectHead } from '@unhead/vue';
export { VueHeadMixin, useHead, useServerHead } from '@unhead/vue';
import { renderSSRHead } from '@unhead/ssr';
import { version, defineComponent, ref, onBeforeUnmount, watchEffect } from 'vue';

function createHead(initHeadObject) {
  const head = createHead$1();
  const legacyHead = {
    headTags() {
      return head.resolveTags();
    },
    addHeadObjs(input, options) {
      return head.push(input, options);
    },
    updateDOM(document, force) {
      if (force)
        renderDOMHead(head, { document });
      else
        debouncedRenderDOMHead(head, { delayFn: (fn) => setTimeout(() => fn(), 50), document });
    }
  };
  head.headTags = legacyHead.headTags;
  head.addHeadObjs = legacyHead.addHeadObjs;
  head.updateDOM = legacyHead.updateDOM;
  if (initHeadObject)
    head.push(initHeadObject);
  return head;
}

const HeadVuePlugin = Vue2ProvideUnheadPlugin;
const renderHeadToString = (head) => renderSSRHead(head);

const Vue2 = version.startsWith("2.");
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
const Head = /* @__PURE__ */ defineComponent({
  name: "Head",
  setup(_, { slots }) {
    const head = injectHead();
    const obj = ref({});
    const entry = head.push(obj);
    if (IsBrowser) {
      onBeforeUnmount(() => {
        entry.dispose();
      });
    }
    return () => {
      watchEffect(() => {
        if (!slots.default)
          return;
        entry.patch(vnodesToHeadObj(slots.default()));
      });
      return null;
    };
  }
});

export { Head, HeadVuePlugin, createHead, renderHeadToString };
