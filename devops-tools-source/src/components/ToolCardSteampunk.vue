<script setup lang="ts">
import { NIcon } from 'naive-ui';
import type { Tool } from '@/tools';

defineProps<{
  tool: Tool
}>();

const emit = defineEmits<{
  click: []
}>();
</script>

<template>
  <div class="steampunk-card" @click="emit('click')">
    <!-- Magnetic rivet corners -->
    <div class="rivet rivet-tl" />
    <div class="rivet rivet-tr" />
    <div class="rivet rivet-bl" />
    <div class="rivet rivet-br" />

    <!-- Tool icon silhouette -->
    <div class="tool-icon-wrapper">
      <NIcon :size="48" class="tool-icon-silhouette">
        <component :is="tool.icon" />
      </NIcon>
    </div>

    <!-- Tool name on brass plate -->
    <div class="brass-nameplate">
      <span class="tool-name">{{ tool.name }}</span>
    </div>

    <!-- Tool description -->
    <div class="tool-description">
      {{ tool.description }}
    </div>

    <!-- NEW badge with copper styling -->
    <div v-if="tool.isNew" class="new-badge">
      NEW
    </div>

    <!-- Magnetic attachment indicator -->
    <div class="magnetic-indicator" />
  </div>
</template>

<style scoped lang="less">
.steampunk-card {
  position: relative;
  background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
  border: 2px solid #3d3d3d;
  border-radius: 8px;
  padding: 20px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.05),
    0 4px 8px rgba(0, 0, 0, 0.3),
    0 0 0 1px rgba(184, 115, 51, 0.2);

  /* Metallic texture overlay */
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background:
      repeating-linear-gradient(
        90deg,
        transparent,
        transparent 2px,
        rgba(255, 255, 255, 0.03) 2px,
        rgba(255, 255, 255, 0.03) 4px
      );
    pointer-events: none;
    opacity: 0.5;
  }

  /* Magnetic surface texture */
  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image:
      radial-gradient(circle at 20% 30%, rgba(184, 115, 51, 0.08) 0%, transparent 50%),
      radial-gradient(circle at 80% 70%, rgba(205, 127, 50, 0.06) 0%, transparent 50%);
    pointer-events: none;
  }

  &:hover {
    transform: translateY(-4px) scale(1.02);
    border-color: #B87333;
    box-shadow:
      inset 0 1px 0 rgba(255, 255, 255, 0.1),
      0 8px 24px rgba(184, 115, 51, 0.3),
      0 0 0 1px rgba(184, 115, 51, 0.5),
      0 0 20px rgba(184, 115, 51, 0.2);

    .tool-icon-silhouette {
      color: #CD7F32;
      filter: drop-shadow(0 0 8px rgba(205, 127, 50, 0.6));
    }

    .brass-nameplate {
      background: linear-gradient(135deg, #CD7F32 0%, #B87333 50%, #8B6914 100%);
      box-shadow:
        0 2px 8px rgba(184, 115, 51, 0.4),
        inset 0 1px 0 rgba(255, 255, 255, 0.3);
    }
  }
}

/* Magnetic rivets in corners */
.rivet {
  position: absolute;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: radial-gradient(circle at 30% 30%, #9CA3AF, #4B5563);
  box-shadow:
    inset 0 1px 2px rgba(0, 0, 0, 0.5),
    0 1px 1px rgba(255, 255, 255, 0.1);
  z-index: 10;

  &::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 4px;
    height: 4px;
    background: #2a2a2a;
    border-radius: 50%;
  }
}

.rivet-tl { top: 8px; left: 8px; }
.rivet-tr { top: 8px; right: 8px; }
.rivet-bl { bottom: 8px; left: 8px; }
.rivet-br { bottom: 8px; right: 8px; }

/* Tool icon as silhouette */
.tool-icon-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0 16px;
  position: relative;
  z-index: 2;
}

.tool-icon-silhouette {
  color: #8B7355;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.5));
  transition: all 0.3s ease;
}

/* Brass nameplate */
.brass-nameplate {
  background: linear-gradient(135deg, #B87333 0%, #8B6914 50%, #6B5410 100%);
  padding: 8px 12px;
  margin: 12px 0;
  border-radius: 4px;
  box-shadow:
    0 2px 4px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2),
    inset 0 -1px 0 rgba(0, 0, 0, 0.3);
  position: relative;
  z-index: 2;
  transition: all 0.3s ease;

  /* Engraved effect */
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: repeating-linear-gradient(
      90deg,
      transparent,
      transparent 1px,
      rgba(0, 0, 0, 0.1) 1px,
      rgba(0, 0, 0, 0.1) 2px
    );
    pointer-events: none;
  }
}

.tool-name {
  font-size: 16px;
  font-weight: 700;
  color: #2a2a2a;
  text-shadow: 0 1px 0 rgba(255, 255, 255, 0.3);
  letter-spacing: 0.5px;
  text-transform: uppercase;
  font-family: 'Courier New', monospace;
  position: relative;
  z-index: 1;
}

.tool-description {
  font-size: 13px;
  line-height: 1.5;
  color: #9CA3AF;
  margin-top: 8px;
  position: relative;
  z-index: 2;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Copper NEW badge */
.new-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  background: linear-gradient(135deg, #CD7F32 0%, #B87333 100%);
  color: #1a1a1a;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 1px;
  box-shadow:
    0 2px 6px rgba(205, 127, 50, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
  z-index: 5;
  border: 1px solid rgba(139, 99, 20, 0.5);
}

/* Magnetic attachment indicator */
.magnetic-indicator {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(220, 20, 60, 0.1) 0%, transparent 70%);
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none;
}

.steampunk-card:active .magnetic-indicator {
  opacity: 1;
  animation: magnetic-pulse 0.6s ease-out;
}

@keyframes magnetic-pulse {
  0% {
    transform: translate(-50%, -50%) scale(0.5);
    opacity: 1;
  }
  100% {
    transform: translate(-50%, -50%) scale(2);
    opacity: 0;
  }
}
</style>
