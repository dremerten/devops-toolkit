<script setup lang="ts">
import { useStyleStore } from '@/stores/style.store';

const styleStore = useStyleStore();
const { isMenuCollapsed, isSmallScreen } = toRefs(styleStore);
const siderPosition = computed(() => (isSmallScreen.value ? 'absolute' : 'static'));
const siderWidth = computed(() => (isSmallScreen.value ? 320 : 240));
const siderStyle = computed(() => (isSmallScreen.value
  ? {
      boxShadow: '0 20px 60px rgba(0,0,0,0.45)',
      height: 'calc(100vh - 32px)',
      top: '32px',
    }
  : {}));
const collapsedState = computed(() => (isSmallScreen.value ? true : isMenuCollapsed.value));
</script>

<template>
  <n-layout has-sider>
    <n-layout-sider
      bordered
      collapse-mode="width"
      :collapsed-width="0"
      :width="siderWidth"
      :collapsed="collapsedState"
      :show-trigger="false"
      :native-scrollbar="false"
      :position="siderPosition"
      :class="{ 'mobile-sider': isSmallScreen }"
      :style="siderStyle"
    >
      <slot name="sider" />
    </n-layout-sider>
    <n-layout class="content">
      <slot name="content" />
      <div v-show="isSmallScreen && !collapsedState" class="overlay" @click="isMenuCollapsed = true" />
    </n-layout>
  </n-layout>
</template>

<style lang="less" scoped>
.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #00000080;
  cursor: pointer;
  z-index: 1300;
}

:global(html:not(.dark)) .overlay {
  background-color: rgba(15, 23, 42, 0.18);
}

.content {
  position: relative;
  min-height: 100vh;
  // background-color: #f1f5f9;
  ::v-deep(.n-layout-scroll-container) {
    padding: 26px;
  }
}

.n-layout {
  height: 100vh;
}

::v-deep(.n-layout-sider) {
  background: rgba(10, 15, 24, 0.92);
  border-right: 1px solid rgba(148, 163, 184, 0.16);
  backdrop-filter: blur(16px);
}

.mobile-sider {
  border-right: none;
  border-bottom: 1px solid rgba(148, 163, 184, 0.2);
}

:global(.mobile-sider.n-layout-sider--absolute) {
  position: fixed !important;
  inset: 32px 0 auto 0;
  width: calc(100% - 24px) !important;
  max-width: 420px;
  margin: 0 auto;
  border-radius: 18px;
  overflow: hidden;
  z-index: 1400;
  transition: transform 0.32s ease, opacity 0.32s ease;
}

:global(.mobile-sider.n-layout-sider--absolute.n-layout-sider--collapsed) {
  transform: translateX(-110%);
  opacity: 0;
  pointer-events: none;
}

:global(.mobile-sider.n-layout-sider--absolute):not(.n-layout-sider--collapsed) {
  transform: translateX(0);
  opacity: 1;
  pointer-events: auto;
}

:global(html:not(.dark)) ::v-deep(.n-layout-sider) {
  background: rgba(255, 255, 255, 0.95);
  border-right: 1px solid rgba(15, 23, 42, 0.12);
  backdrop-filter: blur(16px);
}

::v-deep(.n-layout) {
  background: transparent;
}

@media (max-width: 700px) {
  .content {
    ::v-deep(.n-layout-scroll-container) {
      padding: 16px;
    }
  }
}
</style>
