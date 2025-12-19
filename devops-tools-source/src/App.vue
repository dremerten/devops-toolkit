<script setup lang="ts">
import { RouterView, useRoute } from 'vue-router';
import { NGlobalStyle, NMessageProvider, NNotificationProvider, darkTheme, lightTheme } from 'naive-ui';
import { darkThemeOverrides, lightThemeOverrides } from './themes';
import { getEnvThemeOverrides } from './utils/env-colors';
import { layouts } from './layouts';
import { useStyleStore } from './stores/style.store';

const route = useRoute();
const layout = computed(() => route?.meta?.layout ?? layouts.base);
const styleStore = useStyleStore();

const theme = computed(() => (styleStore.isDarkTheme ? darkTheme : lightTheme));

// Recompute theme on every render to ensure runtime environment detection works
const themeOverrides = computed(() => {
  const envOverrides = getEnvThemeOverrides();
  const baseOverrides = styleStore.isDarkTheme ? darkThemeOverrides : lightThemeOverrides;
  return {
    ...baseOverrides,
    ...envOverrides,
  };
});

const { locale } = useI18n();

syncRef(
  locale,
  useStorage('locale', locale),
);
</script>

<template>
  <n-config-provider :theme="theme" :theme-overrides="themeOverrides">
    <NGlobalStyle />
    <NMessageProvider placement="bottom">
      <NNotificationProvider placement="bottom-right">
        <component :is="layout">
          <RouterView />
        </component>
      </NNotificationProvider>
    </NMessageProvider>
  </n-config-provider>
</template>

<style>
body {
  min-height: 100%;
  margin: 0;
  padding: 0;
}

html {
  height: 100%;
  margin: 0;
  padding: 0;
}

* {
  box-sizing: border-box;
}
</style>
