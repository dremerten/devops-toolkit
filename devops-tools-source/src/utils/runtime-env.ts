/**
 * Runtime environment detection based on hostname
 * This runs in the browser, not at build time
 */

import { computed, readonly, ref } from 'vue';

export type Environment = 'production' | 'staging' | 'qa' | 'development';

export function detectEnvironment(): Environment {
  // Only run in browser
  if (typeof window === 'undefined') {
    return 'development';
  }

  const hostname = window.location.hostname;
  let detectedEnv: Environment = 'development';

  // Production
  if (hostname === 'devops-toolkit.dremer10.com' || hostname === 'www.devops-toolkit.dremer10.com') {
    detectedEnv = 'production';
  }
  // Staging
  else if (hostname.startsWith('staging-') || hostname.includes('staging')) {
    detectedEnv = 'staging';
  }
  // QA
  else if (hostname.startsWith('qa-') || hostname.includes('qa')) {
    detectedEnv = 'qa';
  }
  // Development (dev subdomain or localhost)
  else if (hostname.startsWith('dev-') || hostname === 'localhost' || hostname.startsWith('127.0.0.1') || hostname.startsWith('192.168')) {
    detectedEnv = 'development';
  }

  return detectedEnv;
}

/**
 * Composable for reactive environment detection
 */
export function useEnvironment() {
  const environment = ref<Environment>(detectEnvironment());

  return {
    environment: readonly(environment),
    isProduction: computed(() => environment.value === 'production'),
    isStaging: computed(() => environment.value === 'staging'),
    isQA: computed(() => environment.value === 'qa'),
    isDevelopment: computed(() => environment.value === 'development'),
  };
}
