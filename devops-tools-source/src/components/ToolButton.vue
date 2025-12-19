<script setup lang="ts">
import type { Tool } from '@/tools';

defineProps<{
  tool: Tool
  icon?: string
}>();

const emit = defineEmits<{
  click: []
}>();
</script>

<template>
  <div class="tool-button" @click="emit('click')">
    <div class="tool-icon-container">
      <i :class="`twa twa-${icon}`" />
    </div>
    <div class="tool-name">
      {{ tool.name }}
    </div>
  </div>
</template>

<style scoped lang="less">
.tool-button {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 16px;
  border-radius: 12px;
  background-color: #f5f5f5;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  text-align: center;

  &:hover {
    transform: translateY(-4px);
    background-color: #e9e9e9;
  }

  .tool-icon-container {
    font-size: 48px;
    margin-bottom: 12px;
  }

  .tool-name {
    font-size: 14px;
    font-weight: 500;
    color: #333;
  }
}
</style>
