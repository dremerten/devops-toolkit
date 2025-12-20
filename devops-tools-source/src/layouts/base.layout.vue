<script lang="ts" setup>
import { RouterLink } from 'vue-router';
import { Home2, Menu2 } from '@vicons/tabler';

import { storeToRefs } from 'pinia';
import { NIcon } from 'naive-ui';
import HeroGradient from '../assets/hero-gradient.svg?component';
import MenuLayout from '../components/MenuLayout.vue';
import NavbarButtons from '../components/NavbarButtons.vue';
import { useStyleStore } from '@/stores/style.store';
import { config } from '@/config';
import type { ToolCategory } from '@/tools/tools.types';
import { useToolStore } from '@/tools/tools.store';
import CollapsibleToolMenu from '@/components/CollapsibleToolMenu.vue';
import { getEnvColorScheme } from '@/utils/env-colors';
import { detectEnvironment } from '@/utils/runtime-env';
import { computeBuildVersion } from '@/utils/versioning';

const styleStore = useStyleStore();
const version = config.app.version;
const deploymentDate = config.app.deploymentDate;
const buildNumber = config.app.buildNumber;
const displayedVersion = computed(() => computeBuildVersion(version, buildNumber));

const formattedDeploymentDate = computed(() => {
  if (!deploymentDate) {
    return '';
  }
  try {
    return new Date(deploymentDate).toLocaleString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  }
  catch {
    return deploymentDate;
  }
});

const { t } = useI18n();

const currentEnvironment = computed(() => detectEnvironment());

const environmentDisplay = computed(() => {
  const env = currentEnvironment.value;
  if (env === 'production') {
    return 'ANDRE\'S PRODUCTION';
  }
  if (env === 'staging') {
    return 'ANDRE\'S STAGING';
  }
  if (env === 'qa') {
    return 'ANDRE\'S QA';
  }
  if (env === 'development') {
    return 'ANDRE\'S DEVELOPMENT';
  }
  return null;
});

const envColors = computed(() => getEnvColorScheme());
const envBadgeStyle = computed(() => ({
  backgroundColor: envColors.value.primary,
  borderColor: envColors.value.primary,
  color: '#ffffff',
  boxShadow: `0 0 20px ${envColors.value.primary}40`,
}));

const toolStore = useToolStore();
const { favoriteTools, toolsByCategory } = storeToRefs(toolStore);

const tools = computed<ToolCategory[]>(() => [
  ...(favoriteTools.value.length > 0 ? [{ name: t('tools.categories.favorite-tools'), components: favoriteTools.value }] : []),
  ...toolsByCategory.value,
]);
</script>

<template>
  <!-- Environment Colors v2.0 - Runtime Detection -->
  <div class="environment-wrapper">
    <div v-if="environmentDisplay" class="env-top-bar" :style="{ backgroundColor: envColors.primary }">
      <div class="env-top-bar-content">
        <span class="env-indicator-dot" :style="{ backgroundColor: '#fff' }" />
        {{ environmentDisplay }} ENVIRONMENT
      </div>
    </div>
    <MenuLayout class="menu-layout" :class="{ isSmallScreen: styleStore.isSmallScreen }">
      <template #sider>
        <RouterLink to="/" class="hero-wrapper">
          <HeroGradient class="gradient" />
          <div class="text-wrapper">
            <div class="title">
              DEVOPS TOOLKIT
            </div>
            <div class="divider" />
            <div v-if="environmentDisplay" class="environment-badge" :style="envBadgeStyle">
              {{ environmentDisplay }}
            </div>
          </div>
        </RouterLink>

        <div class="sider-content">
          <div v-if="styleStore.isSmallScreen" flex flex-col items-center>
            <div flex justify-center>
              <NavbarButtons />
            </div>
          </div>

          <CollapsibleToolMenu :tools-by-category="tools" />

          <div class="footer">
            <div class="footer-version">
              DevOps Toolkit v{{ displayedVersion }}
            </div>
            <div v-if="buildNumber" class="footer-build">
              Build #{{ buildNumber }}
            </div>
            <div v-if="formattedDeploymentDate" class="footer-deployment">
              Deployed: {{ formattedDeploymentDate }}
            </div>
          </div>
        </div>
      </template>

      <template #content>
        <div flex items-center justify-center gap-2>
          <c-button
            v-if="!styleStore.isSmallScreen"
            circle
            variant="text"
            :aria-label="$t('home.toggleMenu')"
            @click="styleStore.isMenuCollapsed = !styleStore.isMenuCollapsed"
          >
            <NIcon size="25" :component="Menu2" />
          </c-button>

          <c-tooltip :tooltip="$t('home.home')" position="bottom">
            <c-button to="/" circle variant="text" :aria-label="$t('home.home')">
              <NIcon size="25" :component="Home2" />
            </c-button>
          </c-tooltip>

          <command-palette />

          <div>
            <NavbarButtons v-if="!styleStore.isSmallScreen" />
          </div>
        </div>
        <slot />
      </template>
    </MenuLayout>
  </div>
</template>

<style lang="less" scoped>
.environment-wrapper {
  width: 100%;
  height: 100%;
  color: var(--app-text);
  background: radial-gradient(1000px 520px at 12% -10%, rgba(249, 115, 22, 0.22), transparent 60%),
    radial-gradient(900px 400px at 92% 5%, rgba(248, 210, 144, 0.18), transparent 65%),
    linear-gradient(180deg, #03060d 0%, #05070f 55%, #060914 100%);
}

:global(html:not(.dark)) .environment-wrapper {
  background: radial-gradient(1100px 520px at 15% -15%, rgba(249, 115, 22, 0.18), transparent 60%),
    radial-gradient(900px 420px at 88% 10%, rgba(251, 191, 36, 0.25), transparent 70%),
    linear-gradient(180deg, #fffdfa 0%, #fff2e6 55%, #fffdfa 100%);
  color: #0f172a;
}

.env-top-bar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  color: #fff;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 1.5px;
  text-transform: uppercase;
  background: rgba(5, 8, 18, 0.9);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(14px);
}

.env-top-bar-content {
  display: flex;
  align-items: center;
  gap: 8px;
}

.env-indicator-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  animation: blink 1.5s ease-in-out infinite;
}

:global(html:not(.dark)) .env-top-bar {
  background: rgba(255, 255, 255, 0.88);
  color: #0f172a;
  box-shadow: 0 2px 16px rgba(15, 23, 42, 0.15);
  border-bottom: 1px solid rgba(15, 23, 42, 0.08);
}

@keyframes blink {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.3;
  }
}

.menu-layout {
  padding-top: 32px;
}

// ::v-deep(.n-layout-scroll-container) {
//     @percent: 4%;
//     @position: 25px;
//     @size: 50px;
//     @color: #eeeeee25;
//     background-image: radial-gradient(@color @percent, transparent @percent),
//         radial-gradient(@color @percent, transparent @percent);
//     background-position: 0 0, @position @position;
//     background-size: @size @size;
// }

.support-button {
  background: rgb(37, 99, 108);
  background: linear-gradient(48deg, rgba(37, 99, 108, 1) 0%, rgba(59, 149, 111, 1) 60%, rgba(20, 160, 88, 1) 100%);
  color: #fff !important;
  transition: padding ease 0.2s !important;

  &:hover {
    color: #fff;
    padding-left: 30px;
    padding-right: 30px;
  }
}

.footer {
  text-align: center;
  color: var(--app-muted);
  margin-top: 20px;
  padding: 20px 0;

  .footer-version {
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 4px;
  }

  .footer-build {
    font-size: 11px;
    opacity: 0.8;
    margin-bottom: 2px;
  }

  .footer-deployment {
    font-size: 10px;
    opacity: 0.7;
  }
}

.sider-content {
  padding-top: 160px;
  padding-bottom: 200px;
}

.hero-wrapper {
  position: absolute;
  display: block;
  left: 0;
  width: 100%;
  z-index: 10;
  overflow: hidden;

  .gradient {
    margin-top: -65px;
  }

  .text-wrapper {
    position: absolute;
    left: 0;
    width: 100%;
    text-align: center;
    top: 16px;
    color: #fff;

    .title {
      font-size: 24px;
      font-weight: 600;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      font-family: var(--font-sans);
      color: var(--app-amber-soft);
      text-shadow: 0 0 18px var(--app-amber-glow);
    }

    .divider {
      width: 70px;
      height: 3px;
      border-radius: 6px;
      background: linear-gradient(90deg, rgba(249, 115, 22, 0.95) 0%, rgba(251, 191, 36, 0.85) 100%);
      margin: 0 auto 5px;
    }

    .environment-badge {
      font-size: 12px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      padding: 6px 16px;
      border-radius: 16px;
      display: inline-block;
      margin-top: 8px;
      border: 2px solid;
      transition: all 0.3s ease;
      animation: pulse 2s ease-in-out infinite;
      font-family: var(--font-sans);

      &:hover {
        transform: scale(1.05);
      }
    }

    @keyframes pulse {
      0%, 100% {
        opacity: 1;
      }
      50% {
        opacity: 0.85;
      }
    }

    .subtitle {
      font-size: 15px;
      font-weight: 500;
      opacity: 0.95;
      font-family: var(--font-sans);
    }
  }
}

:global(html:not(.dark)) .hero-wrapper .text-wrapper {
  color: #0f172a;
}
</style>
