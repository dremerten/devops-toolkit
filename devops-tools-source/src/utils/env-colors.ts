import type { GlobalThemeOverrides } from 'naive-ui';
import { detectEnvironment } from './runtime-env';

export interface EnvColorScheme {
  primary: string;
  primaryHover: string;
  primaryPressed: string;
  accentColor: string;
  borderColor: string;
  label: string;
}

export const ENV_COLOR_SCHEMES: Record<string, EnvColorScheme> = {
  production: {
    primary: '#dc2626',        // Red - Production danger
    primaryHover: '#ef4444',
    primaryPressed: '#991b1b',
    accentColor: '#fecaca',
    borderColor: '#fee2e2',
    label: 'PRODUCTION',
  },
  staging: {
    primary: '#f59e0b',        // Amber - Staging warning
    primaryHover: '#fbbf24',
    primaryPressed: '#d97706',
    accentColor: '#fcd34d',
    borderColor: '#fef3c7',
    label: 'STAGING',
  },
  qa: {
    primary: '#0ea5e9',        // Cyan - QA info
    primaryHover: '#38bdf8',
    primaryPressed: '#0284c7',
    accentColor: '#7dd3fc',
    borderColor: '#cffafe',
    label: 'QA',
  },
  development: {
    primary: '#10b981',        // Emerald - Development safe
    primaryHover: '#34d399',
    primaryPressed: '#059669',
    accentColor: '#6ee7b7',
    borderColor: '#d1fae5',
    label: 'DEVELOPMENT',
  },
};

export function getEnvColorScheme(): EnvColorScheme {
  const env = detectEnvironment();
  return ENV_COLOR_SCHEMES[env] || ENV_COLOR_SCHEMES.development;
}

export function getEnvThemeOverrides(): GlobalThemeOverrides {
  const envColors = getEnvColorScheme();

  return {
    common: {
      primaryColor: envColors.primary,
      primaryColorHover: envColors.primaryHover,
      primaryColorPressed: envColors.primaryPressed,
    },
  };
}

export function getEnvBadgeStyle() {
  const envColors = getEnvColorScheme();
  return {
    backgroundColor: envColors.primary,
    borderColor: envColors.borderColor,
  };
}
