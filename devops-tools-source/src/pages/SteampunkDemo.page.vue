<script setup lang="ts">
import { useRouter } from 'vue-router';
import { tools } from '@/tools';
import MagneticBoardBackground from '@/components/MagneticBoardBackground.vue';
import ToolCardSteampunk from '@/components/ToolCardSteampunk.vue';

const router = useRouter();

// Get first 12 tools for demo
const demoTools = tools.slice(0, 12);

function navigateToTool(toolPath: string) {
  router.push(toolPath);
}
</script>

<template>
  <MagneticBoardBackground>
    <!-- Header -->
    <div class="demo-header">
      <h1 class="title">
        DevOps Toolkit
      </h1>
      <p class="subtitle">
        Steampunk Workshop Edition
      </p>
      <div class="brass-divider" />
    </div>

    <!-- Tools Grid -->
    <div class="tools-grid">
      <ToolCardSteampunk
        v-for="tool in demoTools"
        :key="tool.path"
        :tool="tool"
        @click="navigateToTool(tool.path)"
      />
    </div>

    <!-- Demo info badge -->
    <div class="demo-badge">
      <span class="demo-text">🔧 Design Preview</span>
    </div>
  </MagneticBoardBackground>
</template>

<style scoped lang="less">
.demo-header {
  text-align: center;
  margin-bottom: 48px;
  padding-top: 60px;
}

.title {
  font-size: 48px;
  font-weight: 800;
  margin: 0 0 12px;
  background: linear-gradient(135deg, #CD7F32 0%, #B87333 50%, #8B6914 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  letter-spacing: 2px;
  text-transform: uppercase;
  font-family: 'Courier New', monospace;
  text-shadow: 0 4px 12px rgba(184, 115, 51, 0.3);
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.5));
}

.subtitle {
  font-size: 18px;
  color: #9CA3AF;
  margin: 0 0 24px;
  letter-spacing: 3px;
  text-transform: uppercase;
  font-weight: 300;
}

.brass-divider {
  width: 200px;
  height: 4px;
  margin: 0 auto;
  background: linear-gradient(90deg, transparent 0%, #B87333 50%, transparent 100%);
  box-shadow: 0 2px 8px rgba(184, 115, 51, 0.4);
  border-radius: 2px;
}

.tools-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
  margin-bottom: 80px;
  padding: 0 20px;
}

@media (max-width: 768px) {
  .tools-grid {
    grid-template-columns: 1fr;
  }

  .title {
    font-size: 32px;
  }
}

.demo-badge {
  position: fixed;
  bottom: 24px;
  right: 24px;
  background: linear-gradient(135deg, #CD7F32 0%, #B87333 100%);
  padding: 12px 24px;
  border-radius: 24px;
  box-shadow:
    0 4px 16px rgba(184, 115, 51, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
  border: 2px solid #8B6914;
  z-index: 1000;
}

.demo-text {
  font-size: 14px;
  font-weight: 700;
  color: #1a1a1a;
  letter-spacing: 1px;
  text-shadow: 0 1px 0 rgba(255, 255, 255, 0.3);
}
</style>
