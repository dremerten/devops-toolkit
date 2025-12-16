import * as _unhead_schema from '@unhead/schema';
import { Head, HeadEntryOptions, ActiveHeadEntry, Title, Base, Meta, MetaFlatInput, Link, Script, Style, Noscript, HtmlAttributes, BodyAttributes, TitleTemplate, Unhead, CreateHeadOptions, HeadPlugin, HeadEntry, HeadTag } from '@unhead/schema';
import { RenderDomHeadOptions } from '@unhead/dom';

interface DedupesTagsPluginOptions {
    dedupeKeys?: string[];
}
declare const DedupesTagsPlugin: (options?: DedupesTagsPluginOptions) => _unhead_schema.HeadPlugin;

declare const SortTagsPlugin: () => _unhead_schema.HeadPlugin;

declare const TitleTemplatePlugin: () => _unhead_schema.HeadPlugin;

declare const DeprecatedTagAttrPlugin: () => _unhead_schema.HeadPlugin;

declare const ProvideTagHashPlugin: () => _unhead_schema.HeadPlugin;

interface TriggerDomPatchingOnUpdatesPluginOptions extends RenderDomHeadOptions {
    delayFn?: (fn: () => void) => void;
}
declare const PatchDomOnEntryUpdatesPlugin: (options?: TriggerDomPatchingOnUpdatesPluginOptions) => _unhead_schema.HeadPlugin;

/**
 * Supports DOM event handlers (i.e `onload`) as functions.
 *
 * When SSR we need to strip out these values. On CSR we
 */
declare const EventHandlersPlugin: () => _unhead_schema.HeadPlugin;

declare type Arrayable<T> = T | Array<T>;
declare function asArray<T>(value: Arrayable<T>): T[];

declare function useHead<T extends Head>(input: T, options?: HeadEntryOptions): ActiveHeadEntry<T> | void;
declare const useTagTitle: (title: Title) => void;
declare const useTagBase: (base: Base) => void;
declare const useTagMeta: (meta: Arrayable<Meta>) => void;
declare const useTagMetaFlat: (meta: MetaFlatInput) => void;
declare const useTagLink: (link: Arrayable<Link>) => void;
declare const useTagScript: (script: Arrayable<Script>) => void;
declare const useTagStyle: (style: Arrayable<Style>) => void;
declare const useTagNoscript: (noscript: Arrayable<Noscript>) => void;
declare const useHtmlAttrs: (attrs: HtmlAttributes) => void;
declare const useBodyAttrs: (attrs: BodyAttributes) => void;
declare const useTitleTemplate: (titleTemplate: TitleTemplate) => void;

declare function useServerHead<T extends Head>(input: T, options?: HeadEntryOptions): ActiveHeadEntry<T> | void;
declare const useServerTagTitle: (title: Title) => void;
declare const useServerTagBase: (base: Base) => void;
declare const useServerTagMeta: (meta: Arrayable<Meta>) => void;
declare const useServerTagMetaFlat: (meta: MetaFlatInput) => void;
declare const useServerTagLink: (link: Arrayable<Link>) => void;
declare const useServerTagScript: (script: Arrayable<Script>) => void;
declare const useServerTagStyle: (style: Arrayable<Style>) => void;
declare const useServerTagNoscript: (noscript: Arrayable<Noscript>) => void;
declare const useServerHtmlAttrs: (attrs: HtmlAttributes) => void;
declare const useServerBodyAttrs: (attrs: BodyAttributes) => void;
declare const useServerTitleTemplate: (titleTemplate: TitleTemplate) => void;

declare let activeHead: Unhead<any> | undefined;
declare const setActiveHead: <T extends Unhead<_unhead_schema.Head<_unhead_schema.SchemaAugmentations>>>(head: T | undefined) => T | undefined;
declare const getActiveHead: <T extends Unhead<_unhead_schema.Head<_unhead_schema.SchemaAugmentations>>>() => T;

declare function createHead<T extends {} = Head>(options?: CreateHeadOptions): Unhead<T>;

declare function defineHeadPlugin(plugin: HeadPlugin): HeadPlugin;

declare function normaliseEntryTags<T extends {} = Head>(e: HeadEntry<T>): HeadTag[];

export { Arrayable, DedupesTagsPlugin, DedupesTagsPluginOptions, DeprecatedTagAttrPlugin, EventHandlersPlugin, PatchDomOnEntryUpdatesPlugin, ProvideTagHashPlugin, SortTagsPlugin, TitleTemplatePlugin, activeHead, asArray, createHead, defineHeadPlugin, getActiveHead, normaliseEntryTags, setActiveHead, useBodyAttrs, useHead, useHtmlAttrs, useServerBodyAttrs, useServerHead, useServerHtmlAttrs, useServerTagBase, useServerTagLink, useServerTagMeta, useServerTagMetaFlat, useServerTagNoscript, useServerTagScript, useServerTagStyle, useServerTagTitle, useServerTitleTemplate, useTagBase, useTagLink, useTagMeta, useTagMetaFlat, useTagNoscript, useTagScript, useTagStyle, useTagTitle, useTitleTemplate };
