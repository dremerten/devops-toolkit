import { HeadTag, MergeHead, MaybeComputedRef, ReactiveHead } from '@unhead/vue';
export { Unhead, VueHeadMixin, useHead, useServerHead } from '@unhead/vue';
import * as _unhead_schema from '@unhead/schema';
import { HeadEntryOptions, ActiveHeadEntry, Unhead, Head as Head$1 } from '@unhead/schema';
import * as vue from 'vue';
import { Plugin } from 'vue';

interface LegacyHeadClient<T> {
    headTags: () => Promise<HeadTag[]>;
    addHeadObjs: (objs: T, options?: HeadEntryOptions) => ActiveHeadEntry<T>;
    updateDOM: (document?: Document, force?: boolean) => void;
}
declare type UseHeadInput<T extends MergeHead> = MaybeComputedRef<ReactiveHead<T>>;
declare type VueUseHead<T extends MergeHead = {}> = Unhead<UseHeadInput<T>> & LegacyHeadClient<UseHeadInput<T>> & Plugin;
declare function createHead<T extends MergeHead = {}>(initHeadObject?: Head$1<T>): VueUseHead<T>;

declare const HeadVuePlugin: Plugin;
declare const renderHeadToString: <T extends MergeHead = {}>(head: VueUseHead<T>) => Promise<_unhead_schema.SSRHeadPayload>;
declare type HeadObjectPlain = Head$1;
declare type HeadObject = ReactiveHead;

declare const Head: vue.DefineComponent<{}, () => null, {}, {}, {}, vue.ComponentOptionsMixin, vue.ComponentOptionsMixin, {}, string, vue.VNodeProps & vue.AllowedComponentProps & vue.ComponentCustomProps, Readonly<vue.ExtractPropTypes<{}>>, {}>;

export { Head, HeadObject, HeadObjectPlain, HeadVuePlugin, LegacyHeadClient, UseHeadInput, VueUseHead, createHead, renderHeadToString };
