import type { GlobalThemeOverrides } from 'naive-ui';
import { detectEnvironment } from './runtime-env';

export interface EnvColorScheme {
  primary: string
  primaryHover: string
  primaryPressed: string
  accentColor: string
  borderColor: string
  label: string
}

export const ENV_COLOR_SCHEMES: Record<string, EnvColorScheme> = {
  production: {
    primary: '#1e3a8a', // Navy - Production stability
    primaryHover: '#2745a3',
    primaryPressed: '#172554',
    accentColor: '#c7d2fe',
    borderColor: '#e0e7ff',
    label: 'PRODUCTION',
  },
  staging: {
    primary: '#059669', // Emerald - Staging ready
    primaryHover: '#10b981',
    primaryPressed: '#047857',
    accentColor: '#a7f3d0',
    borderColor: '#d1fae5',
    label: 'STAGING',
  },
  qa: {
    primary: '#eab308', // Citrine - QA clarity
    primaryHover: '#facc15',
    primaryPressed: '#ca8a04',
    accentColor: '#fef08a',
    borderColor: '#fef9c3',
    label: 'QA',
  },
  development: {
    primary: '#f97316', // Orange - Development active
    primaryHover: '#fb923c',
    primaryPressed: '#ea580c',
    accentColor: '#fed7aa',
    borderColor: '#ffedd5',
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
