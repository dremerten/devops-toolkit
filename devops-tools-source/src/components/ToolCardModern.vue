<script setup lang="ts">
import { computed } from 'vue';
import ToolSilhouettes from './ToolSilhouettes.vue';
import type { Tool } from '@/tools';

const props = defineProps<{
  tool: Tool
  silhouetteType?: string
}>();

const emit = defineEmits<{
  click: []
}>();

// Map tool categories to silhouette types and colors
const getSilhouetteType = computed(() => {
  if (props.silhouetteType) {
    return props.silhouetteType;
  }

  const name = props.tool.name.toLowerCase();

  if (name.includes('key') || name.includes('rsa') || name.includes('generator')) {
    return 'key';
  }
  if (name.includes('hash') || name.includes('encrypt') || name.includes('bcrypt')) {
    return 'lock';
  }
  if (name.includes('json') || name.includes('yaml') || name.includes('xml') || name.includes('code')) {
    return 'code';
  }
  if (name.includes('network') || name.includes('ip') || name.includes('subnet')) {
    return 'network';
  }
  if (name.includes('database') || name.includes('sql')) {
    return 'database';
  }
  if (name.includes('docker') || name.includes('container')) {
    return 'server';
  }
  if (name.includes('regex') || name.includes('text')) {
    return 'wrench';
  }
  if (name.includes('converter') || name.includes('transform')) {
    return 'gear';
  }

  return 'wrench';
});

// Modern color palette for different tool types
const getToolColor = computed(() => {
  const type = getSilhouetteType.value;
  const colors: Record<string, { primary: string; light: string; gradient: string }> = {
    key: {
      primary: '#FF9500',
      light: '#FFB340',
      gradient: 'linear-gradient(135deg, #FF9500 0%, #FFB340 100%)',
    },
    lock: {
      primary: '#FF3B30',
      light: '#FF6259',
      gradient: 'linear-gradient(135deg, #FF3B30 0%, #FF6259 100%)',
    },
    code: {
      primary: '#007AFF',
      light: '#4DA2FF',
      gradient: 'linear-gradient(135deg, #007AFF 0%, #4DA2FF 100%)',
    },
    network: {
      primary: '#5856D6',
      light: '#7D7AFF',
      gradient: 'linear-gradient(135deg, #5856D6 0%, #7D7AFF 100%)',
    },
    database: {
      primary: '#AF52DE',
      light: '#C77EE8',
      gradient: 'linear-gradient(135deg, #AF52DE 0%, #C77EE8 100%)',
    },
    server: {
      primary: '#34C759',
      light: '#62D77D',
      gradient: 'linear-gradient(135deg, #34C759 0%, #62D77D 100%)',
    },
    wrench: {
      primary: '#00C7BE',
      light: '#32D9D2',
      gradient: 'linear-gradient(135deg, #00C7BE 0%, #32D9D2 100%)',
    },
    gear: {
      primary: '#FF2D55',
      light: '#FF5A7A',
      gradient: 'linear-gradient(135deg, #FF2D55 0%, #FF5A7A 100%)',
    },
  };
  return colors[type] || colors.wrench;
});
</script>

<template>
  <div class="modern-tool-card" @click="emit('click')">
    <!-- Pegboard hook -->
    <div class="peg-hook">
      <div class="hook-cylinder" />
      <div class="hook-tip" />
    </div>

    <!-- Card shadow/depth -->
    <div class="card-shadow" />

    <!-- Main card content -->
    <div class="card-content">
      <!-- Colored header bar -->
      <div class="color-accent" :style="{ background: getToolColor.gradient }" />

      <!-- Tool silhouette -->
      <div class="tool-icon-container">
        <div class="icon-background" :style="{ background: getToolColor.gradient, opacity: 0.1 }" />
        <ToolSilhouettes
          :tool="getSilhouetteType"
          :size="80"
          class="tool-icon"
          :style="{ color: getToolColor.primary }"
        />
      </div>

      <!-- Tool name -->
      <div class="tool-name">
        {{ tool.name }}
      </div>

      <!-- Tool description -->
      <div class="tool-description">
        {{ tool.description }}
      </div>

      <!-- NEW badge -->
      <div v-if="tool.isNew" class="new-badge" :style="{ background: getToolColor.gradient }">
        <span>NEW</span>
      </div>
    </div>
  </div>
</template>

<style scoped lang="less">
.modern-tool-card {
  position: relative;
  cursor: pointer;
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  padding-top: 16px;

  &:hover {
    transform: translateY(-8px);

    .card-content {
      background: rgba(255, 255, 255, 0.98);
      box-shadow:
        0 20px 60px -10px rgba(0, 0, 0, 0.12),
        0 0 0 1px rgba(0, 0, 0, 0.03),
        0 4px 16px rgba(0, 0, 0, 0.04);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
    }

    .card-shadow {
      opacity: 0.25;
      transform: translateY(12px) scale(0.96);
    }

    .peg-hook {
      transform: translateY(-3px);
    }

    .tool-icon {
      transform: scale(1.08);
    }

    .icon-background {
      transform: scale(1.25);
      opacity: 0.18 !important;
    }
  }

  &:active {
    transform: translateY(-4px) scale(0.99);
  }
}

/* Refined pegboard hook */
.peg-hook {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: 10;
}

.hook-cylinder {
  width: 12px;
  height: 16px;
  background: linear-gradient(90deg, #C7C7CC 0%, #D1D1D6 50%, #C7C7CC 100%);
  border-radius: 6px 6px 0 0;
  box-shadow:
    inset 0 1px 2px rgba(255, 255, 255, 0.8),
    0 2px 6px rgba(0, 0, 0, 0.08);
  margin: 0 auto;
}

.hook-tip {
  width: 16px;
  height: 6px;
  background: radial-gradient(ellipse at center, #D1D1D6 0%, #C7C7CC 100%);
  border-radius: 50%;
  margin: -1px auto 0;
  box-shadow:
    0 1px 3px rgba(0, 0, 0, 0.12),
    inset 0 1px 1px rgba(255, 255, 255, 0.6);
}

/* Ultra-soft card shadow */
.card-shadow {
  position: absolute;
  bottom: -8px;
  left: 8%;
  right: 8%;
  height: 18px;
  background: radial-gradient(ellipse at center, rgba(0, 0, 0, 0.1) 0%, transparent 70%);
  border-radius: 50%;
  opacity: 0.18;
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: 0;
  filter: blur(12px);
}

/* Premium glass card */
.card-content {
  position: relative;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-radius: 24px;
  padding: 0 0 28px 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  min-height: 260px;
  box-shadow:
    0 10px 40px -8px rgba(0, 0, 0, 0.08),
    0 0 0 1px rgba(0, 0, 0, 0.02),
    0 2px 8px rgba(0, 0, 0, 0.03);
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  overflow: hidden;
  z-index: 1;
  border: 1px solid rgba(255, 255, 255, 0.8);
}

/* Subtle colored accent bar */
.color-accent {
  width: 100%;
  height: 3px;
  border-radius: 24px 24px 0 0;
  margin-bottom: 20px;
  opacity: 0.9;
}

/* Tool icon */
.tool-icon-container {
  position: relative;
  width: 120px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px 0 24px;
}

.icon-background {
  position: absolute;
  width: 100px;
  height: 100px;
  border-radius: 50%;
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: 0;
  filter: blur(2px);
}

.tool-icon {
  position: relative;
  z-index: 1;
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  filter: drop-shadow(0 2px 8px rgba(0, 0, 0, 0.08));
}

/* Clean Apple typography */
.tool-name {
  font-size: 18px;
  font-weight: 600;
  color: #1D1D1F;
  text-align: center;
  line-height: 1.25;
  margin: 0 24px 10px;
  letter-spacing: -0.022em;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
}

/* Tool description */
.tool-description {
  font-size: 14px;
  font-weight: 400;
  color: #6E6E73;
  text-align: center;
  line-height: 1.42857;
  margin: 0 24px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  letter-spacing: -0.016em;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
}

/* Premium NEW badge */
.new-badge {
  position: absolute;
  top: 16px;
  right: 16px;
  padding: 5px 12px;
  border-radius: 20px;
  box-shadow:
    0 4px 16px rgba(0, 0, 0, 0.12),
    inset 0 1px 0 rgba(255, 255, 255, 0.5);
  z-index: 10;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);

  span {
    font-size: 11px;
    font-weight: 700;
    color: #FFFFFF;
    letter-spacing: 0.6px;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.25);
    font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
  }
}
</style>
