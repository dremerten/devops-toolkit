<script setup lang="ts">
import { useStorage } from '@vueuse/core';
import { useThemeVars } from 'naive-ui';
import { RouterLink, useRoute } from 'vue-router';
import MenuIconItem from './MenuIconItem.vue';
import type { Tool, ToolCategory } from '@/tools/tools.types';

const props = withDefaults(defineProps<{ toolsByCategory?: ToolCategory[] }>(), { toolsByCategory: () => [] });
const { toolsByCategory } = toRefs(props);
const route = useRoute();

const makeLabel = (tool: Tool) => () => h(RouterLink, { to: tool.path }, { default: () => tool.name });
const makeIcon = (tool: Tool) => () => h(MenuIconItem, { tool });

const collapsedCategories = useStorage<Record<string, boolean>>(
  'menu-tool-option:collapsed-categories',
  {},
  undefined,
  {
    deep: true,
    serializer: {
      read: v => (v ? JSON.parse(v) : null),
      write: v => JSON.stringify(v),
    },
  },
);

function toggleCategoryCollapse({ name }: { name: string }) {
  collapsedCategories.value[name] = !collapsedCategories.value[name];
}

const menuOptions = computed(() =>
  toolsByCategory.value.map(({ name, components }) => ({
    name,
    // Default to collapsed (true) if not explicitly set in storage
    isCollapsed: collapsedCategories.value[name] !== undefined ? collapsedCategories.value[name] : true,
    tools: components.map(tool => ({
      label: makeLabel(tool),
      icon: makeIcon(tool),
      key: tool.path,
    })),
  })),
);

const themeVars = useThemeVars();
</script>

<template>
  <div v-for="{ name, tools, isCollapsed } of menuOptions" :key="name">
    <div
      class="category-header"
      :class="{ 'category-collapsed': isCollapsed }"
      @click="toggleCategoryCollapse({ name })"
    >
      <span class="chevron-icon" :class="{ 'rotate-0': isCollapsed, 'rotate-90': !isCollapsed }">
        <icon-mdi-chevron-right />
      </span>

      <span class="category-name">
        {{ name }}
      </span>
    </div>

    <n-collapse-transition :show="!isCollapsed">
      <div class="menu-wrapper">
        <div class="toggle-bar" @click="toggleCategoryCollapse({ name })" />

        <n-menu
          class="menu"
          :value="route.path"
          :collapsed-width="64"
          :collapsed-icon-size="22"
          :options="tools"
          :indent="8"
          :default-expand-all="true"
        />
      </div>
    </n-collapse-transition>
  </div>
</template>

<style scoped lang="less">
.category-header {
  margin-left: 8px;
  margin-top: 16px;
  display: flex;
  align-items: center;
  cursor: pointer;
  padding: 10px 14px;
  border-radius: 10px;
  transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  opacity: 0.85;
  user-select: none;
  background-color: transparent;

  &:hover {
    opacity: 1;
    background-color: rgba(255, 255, 255, 0.08);
    transform: translateX(3px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  }

  &.category-collapsed {
    opacity: 0.65;
  }

  .chevron-icon {
    font-size: 15px;
    line-height: 1;
    opacity: 0.7;
    transition: all 0.35s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    display: flex;
    align-items: center;
    color: rgba(255, 255, 255, 0.8);
  }

  .category-name {
    margin-left: 10px;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
  }

  &:active {
    transform: translateX(4px) scale(0.99);
  }
}

.menu-wrapper {
  display: flex;
  flex-direction: row;
  .menu {
    flex: 1;
    margin-bottom: 8px;

    ::v-deep(.n-menu-item-content) {
      border-radius: 10px;
      margin: 2px 8px;
      padding-left: 12px;
      transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
      font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
      font-size: 14px;

      &:hover {
        background-color: rgba(255, 255, 255, 0.06) !important;
        transform: translateX(2px);
      }

      &::before {
        left: 8px;
        right: 8px;
        border-radius: 10px;
      }

      &.n-menu-item-content--selected {
        background-color: rgba(255, 255, 255, 0.12) !important;
        font-weight: 500;
      }
    }
  }

  .toggle-bar {
    width: 20px;
    opacity: 0.08;
    transition: opacity 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    position: relative;
    cursor: pointer;

    &::before {
      width: 2px;
      height: 100%;
      content: ' ';
      background: linear-gradient(
        180deg,
        rgba(255, 255, 255, 0.1) 0%,
        rgba(255, 255, 255, 0.2) 50%,
        rgba(255, 255, 255, 0.1) 100%
      );
      border-radius: 2px;
      position: absolute;
      top: 0;
      left: 12px;
    }

    &:hover {
      opacity: 0.25;
    }
  }
}
</style>
