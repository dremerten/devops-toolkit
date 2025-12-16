<script setup lang="ts">
import { detectEnvironment } from '@/utils/runtime-env';
import { getEnvColorScheme, getEnvBadgeStyle } from '@/utils/env-colors';

const envColors = computed(() => getEnvColorScheme());
const envDisplay = computed(() => {
  const env = detectEnvironment();
  if (env === 'production') return 'PROD';
  if (env === 'staging') return 'STAGING';
  if (env === 'qa') return 'QA';
  if (env === 'development') return 'DEV';
  return null;
});

const badgeStyle = computed(() => getEnvBadgeStyle());
</script>

<template>
  <div v-if="envDisplay" class="env-badge" :style="badgeStyle">
    {{ envDisplay }}
  </div>
</template>

<style lang="less" scoped>
.env-badge {
  padding: 4px 12px;
  border-radius: 6px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.5px;
  border: 1px solid;
  color: #fff;
  display: inline-block;
  white-space: nowrap;
  transition: all 0.2s ease;

  &:hover {
    transform: scale(1.05);
    filter: brightness(1.1);
  }
}
</style>
