<script setup lang="ts">
import { useRouter } from 'vue-router';
import { tools } from '@/tools';
import PegboardBackground from '@/components/PegboardBackground.vue';
import ToolCardModern from '@/components/ToolCardModern.vue';

const router = useRouter();

// Select 12 diverse tools for the demo
const demoTools = [
  tools.find(t => t.path.includes('jwt-parser')),
  tools.find(t => t.path.includes('bcrypt')),
  tools.find(t => t.path.includes('json-to-yaml')),
  tools.find(t => t.path.includes('yaml-to-json')),
  tools.find(t => t.path.includes('base64')),
  tools.find(t => t.path.includes('hash-text')),
  tools.find(t => t.path.includes('uuid-generator')),
  tools.find(t => t.path.includes('token-generator')),
  tools.find(t => t.path.includes('regex-tester')),
  tools.find(t => t.path.includes('ipv4-subnet-calculator')),
  tools.find(t => t.path.includes('docker-run')),
  tools.find(t => t.path.includes('sql-prettify')),
].filter(Boolean);

// Silhouette type mapping for specific tools
const silhouetteMap: Record<string, string> = {
  'jwt-parser': 'key',
  'bcrypt': 'lock',
  'json-to-yaml': 'code',
  'yaml-to-json': 'code',
  'base64': 'wrench',
  'hash-text': 'lock',
  'uuid-generator': 'key',
  'token-generator': 'key',
  'regex-tester': 'code',
  'ipv4-subnet-calculator': 'network',
  'docker-run': 'server',
  'sql-prettify': 'database',
};

function getSilhouetteType(toolPath: string): string {
  const key = Object.keys(silhouetteMap).find(k => toolPath.includes(k));
  return key ? silhouetteMap[key] : 'wrench';
}

function navigateToTool(toolPath: string) {
  router.push(toolPath);
}
</script>

<template>
  <PegboardBackground>
    <div class="hero">
      <div class="hero-eyebrow">
        Design Preview
      </div>
      <h1 class="title">
        DevOps Toolkit.
      </h1>
      <p class="subtitle">
        Essential tools for modern development teams.
      </p>
    </div>

    <!-- Tools Grid -->
    <div class="tools-grid">
      <ToolCardModern
        v-for="tool in demoTools"
        :key="tool.path"
        :tool="tool"
        :silhouette-type="getSilhouetteType(tool.path)"
        @click="navigateToTool(tool.path)"
      />
    </div>

    <div class="demo-badge">
      <span class="demo-text">Modern Design Preview</span>
    </div>
  </PegboardBackground>
</template>

<style scoped lang="less">
.hero {
  text-align: center;
  margin-bottom: 72px;
  padding-top: 20px;
  animation: fade-in 0.8s ease-out;
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-eyebrow {
  display: inline-flex;
  align-items: center;
  padding: 6px 14px;
  border-radius: 999px;
  border: 1px solid rgba(59, 130, 246, 0.4);
  color: #93c5fd;
  font-size: 12px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  font-weight: 600;
  margin-bottom: 20px;
  background: rgba(15, 23, 42, 0.6);
}

:global(html:not(.dark)) .hero-eyebrow {
  background: rgba(255, 255, 255, 0.9);
  border-color: rgba(15, 23, 42, 0.2);
  color: #0f172a;
}

.title {
  font-size: 60px;
  font-weight: 600;
  margin: 0 0 16px;
  color: var(--app-amber-soft);
  letter-spacing: -0.03em;
  font-family: var(--font-sans);
  line-height: 1.1;
  text-shadow: 0 0 20px var(--app-amber-glow);

  @media (max-width: 768px) {
    font-size: 40px;
  }
}

.subtitle {
  font-size: 20px;
  font-weight: 400;
  color: var(--app-text);
  margin: 0;
  letter-spacing: -0.01em;
  font-family: var(--font-sans);
  line-height: 1.4;
  text-shadow: 0 0 10px rgba(245, 158, 11, 0.2);

  @media (max-width: 768px) {
    font-size: 18px;
    padding: 0 20px;
  }
}

.tools-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 32px;
  margin-bottom: 80px;
  padding: 0 20px;

  @media (min-width: 768px) {
    grid-template-columns: repeat(3, 1fr);
    gap: 40px;
  }

  @media (min-width: 1024px) {
    grid-template-columns: repeat(4, 1fr);
    gap: 48px;
  }

  @media (max-width: 640px) {
    grid-template-columns: repeat(2, 1fr);
    gap: 24px;
  }
}

.demo-badge {
  position: fixed;
  bottom: 32px;
  right: 32px;
  background: rgba(15, 23, 42, 0.85);
  backdrop-filter: blur(18px) saturate(160%);
  -webkit-backdrop-filter: blur(18px) saturate(160%);
  padding: 10px 20px;
  border-radius: 20px;
  box-shadow:
    0 12px 30px rgba(2, 6, 23, 0.45),
    inset 0 0 0 1px rgba(148, 163, 184, 0.2);
  z-index: 1000;
  transition: all 0.3s ease;

  &:hover {
    box-shadow:
      0 18px 36px rgba(2, 6, 23, 0.55),
      inset 0 0 0 1px rgba(59, 130, 246, 0.35);
    transform: translateY(-2px);
  }

  @media (max-width: 768px) {
    bottom: 20px;
    right: 20px;
  }
}

.demo-text {
  font-size: 13px;
  font-weight: 500;
  color: #e2e8f0;
  letter-spacing: -0.01em;
  font-family: var(--font-sans);
}
</style>
