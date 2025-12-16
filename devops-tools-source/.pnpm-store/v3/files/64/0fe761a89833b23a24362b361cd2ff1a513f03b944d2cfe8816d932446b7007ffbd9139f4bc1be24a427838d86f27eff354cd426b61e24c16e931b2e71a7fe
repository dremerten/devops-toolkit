import { MaybeComputedRef, MaybeRef } from '@vueuse/shared';
export { MaybeComputedRef } from '@vueuse/shared';
import * as _unhead_schema from '@unhead/schema';
import { Title as Title$1, TitleTemplate as TitleTemplate$1, EntryAugmentation, Base as Base$1, Link as Link$1, Meta as Meta$1, Style as Style$1, Script as Script$1, Noscript as Noscript$1, DataKeys, SchemaAugmentations, DefinedValueOrEmptyObject, MergeHead, BaseHtmlAttr, MaybeArray, BaseBodyAttr, Unhead, CreateHeadOptions, HeadEntryOptions, MetaFlatInput } from '@unhead/schema';
export { ActiveHeadEntry, Head, HeadEntryOptions, HeadTag, MergeHead, Unhead } from '@unhead/schema';
import { Plugin } from 'vue';
export * from '@unhead/dom';

declare type MaybeComputedRefEntries<T> = MaybeComputedRef<T> | {
    [key in keyof T]?: MaybeComputedRef<T[key]>;
};
declare type Arrayable<T> = T | Array<T>;

interface HtmlAttr extends Omit<BaseHtmlAttr, 'class'> {
    /**
     * The class global attribute is a space-separated list of the case-sensitive classes of the element.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/class
     */
    class?: MaybeArray<MaybeComputedRef<string>> | Record<string, MaybeComputedRef<boolean>>;
}
interface BodyAttr extends Omit<BaseBodyAttr, 'class'> {
    /**
     * The class global attribute is a space-separated list of the case-sensitive classes of the element.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/class
     */
    class?: MaybeArray<MaybeComputedRef<string>> | Record<string, MaybeComputedRef<boolean>>;
}
declare type Title = MaybeComputedRef<Title$1>;
declare type TitleTemplate = MaybeRef<TitleTemplate$1> | ((title?: string) => TitleTemplate$1);
declare type Base<E extends EntryAugmentation = {}> = MaybeComputedRef<MaybeComputedRefEntries<Base$1<E>>>;
declare type Link<E extends EntryAugmentation = {}> = MaybeComputedRefEntries<Link$1<E>>;
declare type Meta<E extends EntryAugmentation = {}> = MaybeComputedRefEntries<Meta$1<E>>;
declare type Style<E extends EntryAugmentation = {}> = MaybeComputedRefEntries<Style$1<E>>;
declare type Script<E extends EntryAugmentation = {}> = MaybeComputedRefEntries<Script$1<E>>;
declare type Noscript<E extends EntryAugmentation = {}> = MaybeComputedRefEntries<Noscript$1<E>>;
declare type HtmlAttributes<E extends EntryAugmentation = {}> = MaybeComputedRef<MaybeComputedRefEntries<HtmlAttr & DataKeys & SchemaAugmentations['htmlAttrs'] & DefinedValueOrEmptyObject<E>>>;
declare type BodyAttributes<E extends EntryAugmentation = {}> = MaybeComputedRef<MaybeComputedRefEntries<BodyAttr & DataKeys & SchemaAugmentations['bodyAttrs'] & DefinedValueOrEmptyObject<E>>>;
interface ReactiveHead<E extends MergeHead = MergeHead> {
    /**
     * The <title> HTML element defines the document's title that is shown in a browser's title bar or a page's tab.
     * It only contains text; tags within the element are ignored.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/title
     */
    title?: Title;
    /**
     * Generate the title from a template.
     */
    titleTemplate?: TitleTemplate;
    /**
     * The <base> HTML element specifies the base URL to use for all relative URLs in a document.
     * There can be only one <base> element in a document.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base
     */
    base?: Base<E['base']>;
    /**
     * The <link> HTML element specifies relationships between the current document and an external resource.
     * This element is most commonly used to link to stylesheets, but is also used to establish site icons
     * (both "favicon" style icons and icons for the home screen and apps on mobile devices) among other things.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#attr-as
     */
    link?: MaybeComputedRef<Link<E['link']>[]>;
    /**
     * The <meta> element represents metadata that cannot be expressed in other HTML elements, like <link> or <script>.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta
     */
    meta?: MaybeComputedRef<Meta<E['meta']>[]>;
    /**
     * The <style> HTML element contains style information for a document, or part of a document.
     * It contains CSS, which is applied to the contents of the document containing the <style> element.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/style
     */
    style?: MaybeComputedRef<Style<E['style']>[]>;
    /**
     * The <script> HTML element is used to embed executable code or data; this is typically used to embed or refer to JavaScript code.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script
     */
    script?: MaybeComputedRef<Script<E['script']>[]>;
    /**
     * The <noscript> HTML element defines a section of HTML to be inserted if a script type on the page is unsupported
     * or if scripting is currently turned off in the browser.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/noscript
     */
    noscript?: MaybeComputedRef<Noscript<E['noscript']>[]>;
    /**
     * Attributes for the <html> HTML element.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/html
     */
    htmlAttrs?: HtmlAttributes<E['htmlAttrs']>;
    /**
     * Attributes for the <body> HTML element.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/body
     */
    bodyAttrs?: BodyAttributes<E['bodyAttrs']>;
}
declare type UseHeadInput<T extends MergeHead = {}> = MaybeComputedRef<ReactiveHead<T>>;

declare function resolveUnrefHeadInput(ref: any): any;
declare function asArray<T>(value: Arrayable<T>): T[];

declare type VueHeadClient<T extends MergeHead> = Unhead<MaybeComputedRef<ReactiveHead<T>>> & Plugin;
declare const headSymbol = "usehead";
declare function injectHead<T extends MergeHead>(): VueHeadClient<T>;
declare function createHead<T extends MergeHead>(options?: Omit<CreateHeadOptions, 'domDelayFn'>): VueHeadClient<T>;

declare const VueHeadMixin: {
    created(): void;
};

declare const VueReactiveUseHeadPlugin: () => _unhead_schema.HeadPlugin;

declare const Vue2ProvideUnheadPlugin: Plugin;

declare function useServerHead<T extends MergeHead>(input: UseHeadInput<T>, options?: HeadEntryOptions): void;
declare const useServerTagTitle: (title: ReactiveHead['title']) => void;
declare const useServerTitleTemplate: (titleTemplate: ReactiveHead['titleTemplate']) => void;
declare const useServerTagMeta: (meta: Arrayable<Meta>) => void;
declare const useServerTagMetaFlat: (meta: MaybeComputedRefEntries<MetaFlatInput>) => void;
declare const useServerTagLink: (link: Arrayable<Link>) => void;
declare const useServerTagScript: (script: Arrayable<Script>) => void;
declare const useServerTagStyle: (style: Arrayable<Style>) => void;
declare const useServerTagNoscript: (noscript: Arrayable<Noscript>) => void;
declare const useServerTagBase: (base: ReactiveHead['base']) => void;
declare const useServerHtmlAttrs: (attrs: ReactiveHead['htmlAttrs']) => void;
declare const useServerBodyAttrs: (attrs: ReactiveHead['bodyAttrs']) => void;

declare function useHead<T extends MergeHead>(input: UseHeadInput<T>, options?: HeadEntryOptions): void;
declare const useTagTitle: (title: ReactiveHead['title']) => void;
declare const useTitleTemplate: (titleTemplate: ReactiveHead['titleTemplate']) => void;
declare const useTagMeta: (meta: Arrayable<Meta>) => void;
declare const useTagMetaFlat: (meta: MaybeComputedRefEntries<MetaFlatInput>) => void;
declare const useTagLink: (link: Arrayable<Link>) => void;
declare const useTagScript: (script: Arrayable<Script>) => void;
declare const useTagStyle: (style: Arrayable<Style>) => void;
declare const useTagNoscript: (noscript: Arrayable<Noscript>) => void;
declare const useTagBase: (base: ReactiveHead['base']) => void;
declare const useHtmlAttrs: (attrs: ReactiveHead['htmlAttrs']) => void;
declare const useBodyAttrs: (attrs: ReactiveHead['bodyAttrs']) => void;

export { Arrayable, Base, BodyAttributes, HtmlAttributes, Link, MaybeComputedRefEntries, Meta, Noscript, ReactiveHead, Script, Style, Title, TitleTemplate, UseHeadInput, Vue2ProvideUnheadPlugin, VueHeadClient, VueHeadMixin, VueReactiveUseHeadPlugin, asArray, createHead, headSymbol, injectHead, resolveUnrefHeadInput, useBodyAttrs, useHead, useHtmlAttrs, useServerBodyAttrs, useServerHead, useServerHtmlAttrs, useServerTagBase, useServerTagLink, useServerTagMeta, useServerTagMetaFlat, useServerTagNoscript, useServerTagScript, useServerTagStyle, useServerTagTitle, useServerTitleTemplate, useTagBase, useTagLink, useTagMeta, useTagMetaFlat, useTagNoscript, useTagScript, useTagStyle, useTagTitle, useTitleTemplate };
