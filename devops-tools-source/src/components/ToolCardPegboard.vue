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

// Map tool categories to silhouette types
const getSilhouetteType = computed(() => {
  if (props.silhouetteType) {
    return props.silhouetteType;
  }

  const name = props.tool.name.toLowerCase();

  // Map based on tool name keywords
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

  return 'wrench'; // default
});
</script>

<template>
  <div class="pegboard-tool-card" @click="emit('click')">
    <!-- Pegboard hook -->
    <div class="peg-hook">
      <div class="hook-shadow" />
      <div class="hook-cylinder" />
      <div class="hook-head" />
    </div>

    <!-- Tool outline/shadow board style -->
    <div class="tool-outline">
      <div class="outline-glow" />
    </div>

    <!-- Tool silhouette -->
    <div class="tool-silhouette-wrapper">
      <ToolSilhouettes
        :tool="getSilhouetteType"
        :size="100"
        class="tool-silhouette"
      />
    </div>

    <!-- Tool name label -->
    <div class="tool-label">
      <div class="label-plate">
        <span class="label-text">{{ tool.name }}</span>
      </div>
    </div>

    <!-- NEW badge -->
    <div v-if="tool.isNew" class="new-badge">
      <span>NEW</span>
    </div>
  </div>
</template>

<style scoped lang="less">
.pegboard-tool-card {
  position: relative;
  background: rgba(45, 45, 45, 0.3);
  border: 2px solid rgba(74, 56, 33, 0.3);
  border-radius: 12px;
  padding: 24px 16px 16px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  min-height: 240px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  backdrop-filter: blur(2px);

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(184, 115, 51, 0.05) 0%, transparent 100%);
    border-radius: 12px;
    pointer-events: none;
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  &:hover {
    transform: translateY(-8px);
    border-color: rgba(184, 115, 51, 0.6);
    background: rgba(45, 45, 45, 0.5);
    box-shadow:
      0 12px 32px rgba(0, 0, 0, 0.4),
      0 0 0 1px rgba(184, 115, 51, 0.3),
      inset 0 1px 0 rgba(255, 255, 255, 0.1);

    &::before {
      opacity: 1;
    }

    .peg-hook {
      transform: translateY(-2px);
    }

    .tool-silhouette {
      color: #B87333;
      filter: drop-shadow(0 0 16px rgba(184, 115, 51, 0.6));
      transform: scale(1.05);
    }

    .outline-glow {
      opacity: 0.4;
    }

    .label-plate {
      background: linear-gradient(135deg, #CD7F32 0%, #B87333 100%);
      box-shadow:
        0 4px 12px rgba(184, 115, 51, 0.4),
        inset 0 1px 2px rgba(255, 255, 255, 0.3);
    }

    .label-text {
      color: #1a1a1a;
    }
  }

  &:active {
    transform: translateY(-4px) scale(0.98);
  }
}

/* Pegboard hook */
.peg-hook {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  transition: transform 0.3s ease;
  z-index: 10;
}

.hook-shadow {
  position: absolute;
  top: 2px;
  left: 50%;
  transform: translateX(-50%);
  width: 24px;
  height: 24px;
  background: radial-gradient(circle, rgba(0, 0, 0, 0.3) 0%, transparent 70%);
  border-radius: 50%;
}

.hook-cylinder {
  position: relative;
  width: 16px;
  height: 20px;
  background: linear-gradient(90deg, #6B7280 0%, #9CA3AF 50%, #6B7280 100%);
  border-radius: 8px 8px 0 0;
  box-shadow:
    inset 0 1px 2px rgba(255, 255, 255, 0.3),
    inset 0 -1px 2px rgba(0, 0, 0, 0.3),
    0 2px 4px rgba(0, 0, 0, 0.3);
  margin: 0 auto;
}

.hook-head {
  width: 20px;
  height: 8px;
  background: radial-gradient(ellipse at center, #9CA3AF 0%, #6B7280 100%);
  border-radius: 50%;
  margin: -2px auto 0;
  box-shadow:
    0 1px 2px rgba(0, 0, 0, 0.5),
    inset 0 1px 1px rgba(255, 255, 255, 0.3);
}

/* Tool outline (shadow board style) */
.tool-outline {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -45%);
  width: 120px;
  height: 120px;
  pointer-events: none;
  z-index: 1;
}

.outline-glow {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(
    ellipse at center,
    rgba(184, 115, 51, 0.15) 0%,
    rgba(184, 115, 51, 0.08) 40%,
    transparent 70%
  );
  border-radius: 50%;
  opacity: 0;
  transition: opacity 0.3s ease;
}

/* Tool silhouette */
.tool-silhouette-wrapper {
  position: relative;
  z-index: 5;
  margin: 20px 0;
  display: flex;
  align-items: center;
  justify-content: center;
  flex: 1;
}

.tool-silhouette {
  color: #4a4a4a;
  filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.4));
  transition: all 0.3s ease;
}

/* Tool label */
.tool-label {
  width: 100%;
  margin-top: auto;
  padding-top: 12px;
}

.label-plate {
  background: linear-gradient(135deg, #3d3d3d 0%, #2d2d2d 100%);
  padding: 8px 12px;
  border-radius: 6px;
  box-shadow:
    0 2px 6px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(74, 56, 33, 0.3);
  transition: all 0.3s ease;
  text-align: center;

  /* Stamped/embossed effect */
  &::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  }
}

.label-text {
  font-size: 13px;
  font-weight: 600;
  color: #9CA3AF;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  line-height: 1.3;
  transition: color 0.3s ease;
  display: block;

  /* Ensure text wraps nicely */
  word-break: break-word;
  hyphens: auto;
}

/* NEW badge */
.new-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  background: linear-gradient(135deg, #CD7F32 0%, #B87333 100%);
  padding: 4px 8px;
  border-radius: 8px;
  box-shadow:
    0 2px 6px rgba(205, 127, 50, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
  border: 1px solid rgba(139, 99, 20, 0.5);
  z-index: 15;

  span {
    font-size: 10px;
    font-weight: 700;
    color: #1a1a1a;
    letter-spacing: 0.5px;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.2);
  }
}
</style>
