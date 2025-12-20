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

const getToolColor = computed(() => {
  const type = getSilhouetteType.value;
  const colors: Record<string, { primary: string; light: string; gradient: string }> = {
    key: {
      primary: '#f59e0b',
      light: '#fbbf24',
      gradient: 'linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%)',
    },
    lock: {
      primary: '#ef4444',
      light: '#f87171',
      gradient: 'linear-gradient(135deg, #ef4444 0%, #f87171 100%)',
    },
    code: {
      primary: '#3b82f6',
      light: '#60a5fa',
      gradient: 'linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%)',
    },
    network: {
      primary: '#6366f1',
      light: '#818cf8',
      gradient: 'linear-gradient(135deg, #6366f1 0%, #818cf8 100%)',
    },
    database: {
      primary: '#8b5cf6',
      light: '#a78bfa',
      gradient: 'linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%)',
    },
    server: {
      primary: '#10b981',
      light: '#34d399',
      gradient: 'linear-gradient(135deg, #10b981 0%, #34d399 100%)',
    },
    wrench: {
      primary: '#22d3ee',
      light: '#67e8f9',
      gradient: 'linear-gradient(135deg, #22d3ee 0%, #67e8f9 100%)',
    },
    gear: {
      primary: '#f97316',
      light: '#fb923c',
      gradient: 'linear-gradient(135deg, #f97316 0%, #fb923c 100%)',
    },
  };
  return colors[type] || colors.wrench;
});

const amberGlowGradient = 'linear-gradient(135deg, rgba(249, 115, 22, 0.95) 0%, rgba(251, 191, 36, 0.7) 60%, rgba(249, 115, 22, 0.15) 100%)';
</script>

<template>
  <div class="modern-tool-card" @click="emit('click')">
    <div class="card-glow" :style="{ background: amberGlowGradient }" />
      <div class="card-content">
        <div class="color-accent" :style="{ background: getToolColor.gradient }" />

      <div class="card-top">
        <div class="card-tag" :style="{ color: getToolColor.light, borderColor: `${getToolColor.light}55` }">
          TOOL
        </div>
        <div v-if="tool.isNew" class="new-badge" :style="{ background: getToolColor.gradient }">
          <span>NEW</span>
        </div>
      </div>

      <div class="tool-icon-outer">
        <div class="tool-icon-container" :title="tool.description">
          <div class="icon-background" :style="{ background: getToolColor.gradient, opacity: 0.1 }" />
          <ToolSilhouettes
            :tool="getSilhouetteType"
            :size="64"
            class="tool-icon"
          />
        </div>
        <div class="icon-tooltip">
          {{ tool.description }}
        </div>
      </div>

      <div class="tool-name">
        {{ tool.name }}
      </div>

      <div class="tool-description">
        {{ tool.description }}
      </div>
    </div>
  </div>
</template>

<style scoped lang="less">
.modern-tool-card {
  position: relative;
  cursor: pointer;
  transition: transform 0.4s ease;
  border-radius: 24px;
  width: 100%;

  &:hover {
    transform: translateY(-8px);

    .card-content {
      border-color: rgba(249, 115, 22, 0.45);
      box-shadow:
        0 34px 70px rgba(2, 6, 23, 0.45),
        0 0 0 1px rgba(249, 115, 22, 0.25);
    }

    .tool-icon {
      transform: scale(1.08);
    }

    .icon-background {
      transform: scale(1.25);
      opacity: 0.2 !important;
    }

    .card-glow {
      opacity: 0.28;
      transform: translateY(-12px) scale(1.08);
    }
  }

  &:active {
    transform: translateY(-4px) scale(0.99);
  }
}

.card-glow {
  position: absolute;
  inset: -8px;
  border-radius: 28px;
  opacity: 0.25;
  filter: blur(32px);
  z-index: 0;
  transition: all 0.4s ease;
}

.card-tag {
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  border: 1px solid transparent;
  padding: 4px 10px;
  border-radius: 999px;
  font-weight: 600;
}

:global(html:not(.dark)) .card-glow {
  opacity: 0.18;
}

:global(html:not(.dark)) .card-tag {
  color: #0f172a !important;
  border-color: rgba(15, 23, 42, 0.2) !important;
}

.card-content {
  position: relative;
  background: var(--app-card);
  border: 1px solid var(--app-card-border);
  border-radius: 24px;
  padding: 14px 14px 22px 14px;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  min-height: 240px;
  box-shadow:
    0 18px 40px rgba(2, 6, 23, 0.35),
    inset 0 1px 0 rgba(148, 163, 184, 0.12);
  transition: all 0.4s ease;
  overflow: visible;
  z-index: 1;
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
}

:global(html:not(.dark)) .modern-tool-card .card-content {
  box-shadow:
    0 20px 50px rgba(15, 23, 42, 0.12),
    inset 0 1px 0 rgba(15, 23, 42, 0.06);
  border-color: rgba(249, 115, 22, 0.25);
}

.color-accent {
  width: 100%;
  height: 4px;
  border-radius: 24px 24px 0 0;
  opacity: 0.9;
}

.card-top {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 20px 0;
}

.tool-icon-outer {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  padding: 12px;
  margin: -6px -6px 0;
  cursor: pointer;

  &::before {
    content: '';
    position: absolute;
    inset: -16px;
  }
}

.tool-icon-container {
  position: relative;
  width: 104px;
  height: 104px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 14px 0 16px;
  cursor: pointer;
}

.icon-background {
  position: absolute;
  width: 88px;
  height: 88px;
  border-radius: 50%;
  transition: all 0.4s ease;
  z-index: 0;
  filter: blur(6px);
}

.tool-icon {
  position: relative;
  z-index: 1;
  transition: all 0.4s ease;
  color: var(--app-amber);
  filter:
    drop-shadow(0 6px 18px rgba(2, 6, 23, 0.4))
    drop-shadow(0 0 12px var(--app-amber-glow));
  animation: iconPulse 6.8s ease-in-out infinite;
}

.icon-tooltip {
  position: absolute;
  bottom: 110%;
  left: 50%;
  transform: translateX(-50%);
  min-width: 180px;
  max-width: 260px;
  padding: 8px 10px;
  background: rgba(7, 11, 20, 0.95);
  color: #fff;
  border-radius: 10px;
  box-shadow: 0 14px 30px rgba(0, 0, 0, 0.35);
  font-size: 12px;
  line-height: 1.4;
  text-align: center;
  opacity: 0;
  pointer-events: none;
  z-index: 20;
  transition: opacity 0.2s ease, transform 0.2s ease;
  white-space: normal;
}

.tool-icon-outer:hover .icon-tooltip,
.modern-tool-card:hover .icon-tooltip {
  opacity: 1;
  transform: translate(-50%, -6px);
}

.tool-icon-outer:focus-within .icon-tooltip,
.modern-tool-card:focus-within .icon-tooltip {
  opacity: 1;
  transform: translate(-50%, -6px);
}

:global(html:not(.dark)) .icon-tooltip {
  background: rgba(255, 255, 255, 0.95);
  color: #0f172a;
  box-shadow: 0 14px 30px rgba(15, 23, 42, 0.2);
}

@keyframes iconPulse {
  0%, 100% {
    filter:
      drop-shadow(0 6px 18px rgba(2, 6, 23, 0.35))
      drop-shadow(0 0 12px rgba(249, 115, 22, 0.65));
  }
  50% {
    filter:
      drop-shadow(0 12px 32px rgba(2, 6, 23, 0.5))
      drop-shadow(0 0 24px rgba(251, 191, 36, 0.82));
  }
}

.tool-name {
  font-size: 18px;
  font-weight: 600;
  color: var(--app-amber-soft);
  text-align: center;
  line-height: 1.25;
  margin: 0 18px 10px;
  letter-spacing: -0.02em;
  font-family: var(--font-sans);
  text-shadow: 0 0 12px var(--app-amber-glow);
}

.tool-description {
  font-size: 14px;
  font-weight: 400;
  color: var(--app-amber);
  text-align: center;
  line-height: 1.42857;
  margin: 0 16px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  letter-spacing: -0.01em;
  font-family: var(--font-sans);
  text-shadow: 0 0 10px rgba(245, 158, 11, 0.2);
}

.new-badge {
  padding: 4px 10px;
  border-radius: 20px;
  box-shadow: 0 8px 20px rgba(2, 6, 23, 0.4);
  z-index: 2;

  span {
    font-size: 10px;
    font-weight: 700;
    color: #FFFFFF;
    letter-spacing: 0.6px;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
    font-family: var(--font-sans);
  }
}

@media (max-width: 700px) {
  .card-content {
    min-height: 260px;
    padding: 10px 12px 24px 12px;
  }

  .tool-icon-container {
    width: 112px;
    height: 112px;
    margin: 16px 0 18px;
  }

  .icon-background {
    width: 88px;
    height: 88px;
  }

  .tool-icon {
    transform: none;
  }

  .tool-name {
    font-size: 18px;
    margin: 0 24px 10px;
  }

  .tool-description {
    font-size: 14px;
    margin: 0 18px;
    display: block;
    -webkit-line-clamp: unset;
    -webkit-box-orient: unset;
    overflow: visible;
  }
}
</style>
