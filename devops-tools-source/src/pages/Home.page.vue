<script setup lang="ts">
import { IconDragDrop } from '@tabler/icons-vue';
import { useHead } from '@vueuse/head';
import { computed, ref } from 'vue';
import { useRouter } from 'vue-router';
import Draggable from 'vuedraggable';
import ToolCardModern from '../components/ToolCardModern.vue';
import PegboardBackground from '../components/PegboardBackground.vue';
import { useToolStore } from '@/tools/tools.store';

const toolStore = useToolStore();
const router = useRouter();

useHead({ title: 'DevOps Toolkit - Essential tools for modern development workflows' });
const { t } = useI18n();

const favoriteTools = computed(() => toolStore.favoriteTools);
const selectedCategory = ref('all');
const categoryTabs = computed(() => {
  const allTab = {
    key: 'all',
    name: t('home.categories.allTools'),
    count: toolStore.tools.length,
  };
  const categoryTabs = toolStore.toolsByCategory.map(category => ({
    key: category.name,
    name: category.name,
    count: category.components.length,
  }));

  return [allTab, ...categoryTabs];
});

const filteredTools = computed(() => {
  if (selectedCategory.value === 'all') {
    return toolStore.tools;
  }

  const category = toolStore.toolsByCategory.find(item => item.name === selectedCategory.value);
  return category?.components ?? [];
});

// Update favorite tools order when drag is finished
function onUpdateFavoriteTools() {
  toolStore.updateFavoriteTools(favoriteTools.value); // Update the store with the new order
}

// Navigate to tool page
function navigateToTool(toolPath: string) {
  router.push(toolPath);
}

// Map EACH tool to a completely UNIQUE icon - no duplicates!
const toolIconMap: Record<string, string> = {
  // Each tool gets its own unique icon
  'base64-file-converter': 'file-binary',
  'base64-string-converter': 'text-binary',
  'basic-auth-generator': 'user-lock',
  'email-normalizer': 'envelope-check',
  'ascii-text-drawer': 'text-art',
  'text-to-unicode': 'unicode',
  'safelink-decoder': 'link-broken',
  'xml-to-json': 'angle-to-bracket',
  'json-to-xml': 'bracket-to-angle',
  'regex-tester': 'regex',
  'regex-memo': 'regex-book',
  'markdown-to-html': 'markdown',
  'pdf-signature-checker': 'certificate',
  'numeronym-generator': 'numbers',
  'mac-address-generator': 'ethernet',
  'text-to-binary': 'binary-code',
  'ulid-generator': 'id-card',
  'iban-validator-and-parser': 'bank',
  'string-obfuscator': 'eye-slash',
  'text-diff': 'file-diff',
  'emoji-picker': 'smiley',
  'password-strength-analyser': 'shield-check',
  'yaml-to-toml': 'yaml-toml',
  'json-to-toml': 'json-toml',
  'toml-to-yaml': 'toml-yaml',
  'toml-to-json': 'toml-json',
  'json-to-csv': 'table-convert',
  'camera-recorder': 'video-camera',
  'list-converter': 'list-alt',
  'phone-parser-and-formatter': 'phone-alt',
  'json-diff': 'json-compare',
  'ipv4-range-expander': 'network-wired',
  'http-status-codes': 'http',
  'yaml-to-json-converter': 'yaml-json',
  'json-to-yaml-converter': 'json-yaml',
  'ipv6-ula-generator': 'ipv6',
  'ipv4-address-converter': 'ipv4',
  'benchmark-builder': 'stopwatch',
  'user-agent-parser': 'browser',
  'ipv4-subnet-calculator': 'subnet',
  'docker-run-to-docker-compose-converter': 'docker',
  'html-wysiwyg-editor': 'edit',
  'rsa-key-pair-generator': 'key-pair',
  'text-to-nato-alphabet': 'radio',
  'slugify-string': 'link-simple',
  'keycode-info': 'keyboard',
  'json-minify': 'compress',
  'bcrypt': 'hash-lock',
  'bip39-generator': 'seed',
  'case-converter': 'text-case',
  'chmod-calculator': 'permissions',
  'chronometer': 'timer',
  'color-converter': 'color-wheel',
  'crontab-generator': 'cron',
  'date-time-converter': 'calendar-clock',
  'device-information': 'device',
  'encryption': 'padlock',
  'eta-calculator': 'hourglass',
  'percentage-calculator': 'percentage',
  'git-memo': 'git-branch',
  'hash-text': 'hashtag',
  'hmac-generator': 'signature',
  'html-entities': 'html',
  'integer-base-converter': 'base-convert',
  'json-viewer': 'json-tree',
  'jwt-parser': 'jwt',
  'lorem-ipsum-generator': 'paragraph',
  'math-evaluator': 'function',
  'meta-tag-generator': 'meta',
  'mime-types': 'file-type',
  'otp-code-generator-and-validator': 'otp',
  'qr-code-generator': 'qr',
  'wifi-qr-code-generator': 'wifi-qr',
  'random-port-generator': 'port',
  'roman-numeral-converter': 'roman',
  'sql-prettify': 'sql',
  'svg-placeholder-generator': 'svg',
  'temperature-converter': 'thermometer',
  'text-statistics': 'stats',
  'token-generator': 'token',
  'url-encoder': 'url-encode',
  'url-parser': 'url-parse',
  'uuid-generator': 'uuid',
  'mac-address-lookup': 'mac-lookup',
  'xml-formatter': 'xml',
  'yaml-viewer': 'yaml',
};

function getSilhouetteType(toolPath: string): string {
  // Find exact match from tool path
  for (const [toolKey, icon] of Object.entries(toolIconMap)) {
    if (toolPath.includes(toolKey)) {
      return icon;
    }
  }

  // Fallback to default if no match (shouldn't happen)
  return 'wrench';
}
</script>

<template>
  <PegboardBackground>
    <div class="hero">
      <div class="hero-eyebrow">
        DevOps Toolkit
      </div>
      <h1 class="title">
        Tools to help on everyday development tasks.
      </h1>
      <p class="subtitle">
        Essential tools to aid in shipping fast, reliable, and secure software. 
      </p>
    </div>

    <div class="grid-wrapper">
      <div class="category-tabs">
        <button
          v-for="category in categoryTabs"
          :key="category.key"
          type="button"
          class="category-tab"
          :class="{ active: selectedCategory === category.key }"
          @click="selectedCategory = category.key"
        >
          <span>{{ category.name }}</span>
          <span class="category-count">{{ category.count }}</span>
        </button>
      </div>
      <transition name="height">
        <div v-if="selectedCategory === 'all' && toolStore.favoriteTools.length > 0">
          <h3 class="section-header">
            {{ $t('home.categories.favoriteTools') }}
            <c-tooltip :tooltip="$t('home.categories.favoritesDndToolTip')">
              <n-icon :component="IconDragDrop" size="18" />
            </c-tooltip>
          </h3>
          <Draggable
            :list="favoriteTools"
            class="grid grid-cols-1 gap-12px sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 2xl:grid-cols-6"
            ghost-class="ghost-favorites-draggable"
            item-key="name"
            @end="onUpdateFavoriteTools"
          >
            <template #item="{ element: tool }">
              <ToolCardModern :tool="tool" :silhouette-type="getSilhouetteType(tool.path)" @click="navigateToTool(tool.path)" />
            </template>
          </Draggable>
        </div>
      </transition>

      <div v-if="selectedCategory === 'all' && toolStore.newTools.length > 0">
        <h3 class="section-header">
          {{ t('home.categories.newestTools') }}
        </h3>
        <div class="grid grid-cols-1 gap-12px sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 2xl:grid-cols-6">
          <ToolCardModern v-for="tool in toolStore.newTools" :key="tool.name" :tool="tool" :silhouette-type="getSilhouetteType(tool.path)" @click="navigateToTool(tool.path)" />
        </div>
      </div>

      <h3 class="section-header">
        {{ selectedCategory === 'all' ? $t('home.categories.allTools') : selectedCategory }}
      </h3>
      <div class="grid grid-cols-1 gap-12px sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 2xl:grid-cols-6">
        <ToolCardModern v-for="tool in filteredTools" :key="tool.name" :tool="tool" :silhouette-type="getSilhouetteType(tool.path)" @click="navigateToTool(tool.path)" />
      </div>
    </div>
  </PegboardBackground>
</template>

<style scoped lang="less">
.hero {
  text-align: center;
  margin-bottom: 88px;
  padding-top: 24px;
  animation: fade-in 0.9s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(-26px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 14px;
  border-radius: 999px;
  border: 1px solid rgba(168, 85, 247, 0.45);
  color: #d8b4fe;
  font-size: 12px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  font-weight: 600;
  margin-bottom: 24px;
  background: rgba(15, 23, 42, 0.6);
  box-shadow: inset 0 0 18px rgba(168, 85, 247, 0.28), 0 0 26px rgba(168, 85, 247, 0.22);
}

:global(html:not(.dark)) .hero-eyebrow {
  background: rgba(255, 255, 255, 0.9);
  border-color: rgba(168, 85, 247, 0.25);
  color: #6b21a8;
  box-shadow: inset 0 0 12px rgba(168, 85, 247, 0.12);
}

.title {
  font-size: 68px;
  font-weight: 600;
  margin: 0 0 20px;
  color: var(--app-amber-soft);
  letter-spacing: -0.03em;
  font-family: var(--font-sans);
  line-height: 1.05;
  background: linear-gradient(90deg, #fde6c3 0%, #f59e0b 50%, #f97316 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-shadow: 0 0 24px var(--app-amber-glow);

  @media (max-width: 768px) {
    font-size: 42px;
  }
}

.subtitle {
  font-size: 22px;
  font-weight: 400;
  color: var(--app-text);
  margin: 0;
  letter-spacing: -0.01em;
  font-family: var(--font-sans);
  line-height: 1.5;
  text-shadow: 0 0 12px rgba(245, 158, 11, 0.2);

  @media (max-width: 768px) {
    font-size: 18px;
    padding: 0 16px;
  }
}

.height-enter-active,
.height-leave-active {
  transition: all 0.5s ease-in-out;
  overflow: hidden;
  max-height: 500px;
}

.height-enter-from,
.height-leave-to {
  max-height: 42px;
  overflow: hidden;
  opacity: 0;
  margin-bottom: 0;
}

.ghost-favorites-draggable {
  opacity: 0.4;
  background-color: #ccc;
  border: 2px dashed #666;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  transform: scale(1.1);
  animation: ghost-favorites-draggable-animation 0.2s ease-out;
}

.category-tabs {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 12px;
  margin-bottom: 36px;
}

.category-tab {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 8px 16px;
  border-radius: 999px;
  border: 1px solid rgba(148, 163, 184, 0.3);
  background: rgba(15, 23, 42, 0.65);
  color: var(--app-text);
  font-size: 13px;
  letter-spacing: 0.04em;
  font-weight: 500;
  transition: all 0.2s ease;
  box-shadow: inset 0 0 12px rgba(15, 23, 42, 0.35);
}

.category-tab:hover {
  transform: translateY(-2px);
  border-color: rgba(245, 158, 11, 0.5);
}

.category-tab.active {
  border-color: rgba(245, 158, 11, 0.6);
  color: var(--app-amber-soft);
  box-shadow: 0 0 18px rgba(245, 158, 11, 0.25);
}

.category-count {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 999px;
  background: rgba(245, 158, 11, 0.15);
  color: var(--app-amber-soft);
}

:global(html:not(.dark)) .category-tab {
  background: rgba(255, 255, 255, 0.92);
  border-color: rgba(249, 115, 22, 0.25);
  color: #0f172a;
  box-shadow: inset 0 0 12px rgba(249, 115, 22, 0.12);
}

:global(html:not(.dark)) .category-tab.active {
  border-color: rgba(249, 115, 22, 0.5);
  color: var(--app-amber-soft);
  box-shadow: 0 0 18px rgba(249, 115, 22, 0.35);
}
@keyframes ghost-favorites-draggable-animation {
  0% {
    opacity: 0;
    transform: scale(0.9);
  }
  100% {
    opacity: 0.4;
    transform: scale(1.0);
  }
}

.section-header {
  font-size: 14px;
  font-weight: 600;
  color: var(--app-amber);
  margin-bottom: 16px;
  margin-top: 48px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  font-family: var(--font-sans);
  display: flex;
  align-items: center;
  gap: 8px;
  text-shadow: 0 0 12px var(--app-amber-glow);
}
</style>
