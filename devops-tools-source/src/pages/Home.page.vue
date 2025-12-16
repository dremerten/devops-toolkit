<script setup lang="ts">
import { IconDragDrop } from '@tabler/icons-vue';
import { useHead } from '@vueuse/head';
import { computed } from 'vue';
import Draggable from 'vuedraggable';
import ToolCardModern from '../components/ToolCardModern.vue';
import PegboardBackground from '../components/PegboardBackground.vue';
import { useToolStore } from '@/tools/tools.store';

const toolStore = useToolStore();

useHead({ title: 'DevOps Toolkit - Essential tools for modern development workflows' });
const { t } = useI18n();

const favoriteTools = computed(() => toolStore.favoriteTools);

// Update favorite tools order when drag is finished
function onUpdateFavoriteTools() {
  toolStore.updateFavoriteTools(favoriteTools.value); // Update the store with the new order
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
    <!-- Modern Header -->
    <div class="demo-header">
      <h1 class="title">
        DevOps Toolkit.
      </h1>
      <p class="subtitle">
        Essential tools for modern development workflows.
      </p>
    </div>

    <div class="grid-wrapper">
      <transition name="height">
        <div v-if="toolStore.favoriteTools.length > 0">
          <h3 class="section-header">
            {{ $t('home.categories.favoriteTools') }}
            <c-tooltip :tooltip="$t('home.categories.favoritesDndToolTip')">
              <n-icon :component="IconDragDrop" size="18" />
            </c-tooltip>
          </h3>
          <Draggable
            :list="favoriteTools"
            class="grid grid-cols-1 gap-12px lg:grid-cols-3 md:grid-cols-3 sm:grid-cols-2 xl:grid-cols-4"
            ghost-class="ghost-favorites-draggable"
            item-key="name"
            @end="onUpdateFavoriteTools"
          >
            <template #item="{ element: tool }">
              <ToolCardModern :tool="tool" :silhouette-type="getSilhouetteType(tool.path)" />
            </template>
          </Draggable>
        </div>
      </transition>

      <div v-if="toolStore.newTools.length > 0">
        <h3 class="section-header">
          {{ t('home.categories.newestTools') }}
        </h3>
        <div class="grid grid-cols-1 gap-12px lg:grid-cols-3 md:grid-cols-3 sm:grid-cols-2 xl:grid-cols-4">
          <ToolCardModern v-for="tool in toolStore.newTools" :key="tool.name" :tool="tool" :silhouette-type="getSilhouetteType(tool.path)" />
        </div>
      </div>

      <h3 class="section-header">
        {{ $t('home.categories.allTools') }}
      </h3>
      <div class="grid grid-cols-1 gap-12px lg:grid-cols-3 md:grid-cols-3 sm:grid-cols-2 xl:grid-cols-4">
        <ToolCardModern v-for="tool in toolStore.tools" :key="tool.name" :tool="tool" :silhouette-type="getSilhouetteType(tool.path)" />
      </div>
    </div>
  </PegboardBackground>
</template>

<style scoped lang="less">
.demo-header {
  text-align: center;
  margin-bottom: 80px;
  padding-top: 40px;
  animation: fade-in 1s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(-30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.title {
  font-size: 76px;
  font-weight: 700;
  margin: 0 0 20px;
  color: #1D1D1F;
  letter-spacing: -0.035em;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
  line-height: 1.05;
  background: linear-gradient(180deg, #1D1D1F 0%, #3D3D3D 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;

  @media (max-width: 768px) {
    font-size: 48px;
  }
}

.subtitle {
  font-size: 28px;
  font-weight: 500;
  color: #6E6E73;
  margin: 0;
  letter-spacing: -0.015em;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
  line-height: 1.35;

  @media (max-width: 768px) {
    font-size: 20px;
    padding: 0 20px;
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
  font-size: 20px;
  font-weight: 600;
  color: #1D1D1F;
  margin-bottom: 16px;
  margin-top: 48px;
  letter-spacing: -0.02em;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
  display: flex;
  align-items: center;
  gap: 8px;
}
</style>
