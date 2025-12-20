import { defineThemes } from './theme.models';

export const { themes: appThemes, useTheme: useAppTheme } = defineThemes({
  light: {
    background: '#ffffff',
    text: {
      baseColor: '#333639',
      mutedColor: '#767c82',
    },
    default: {
      color: 'rgba(46, 51, 56, 0.05)',
      colorHover: 'rgba(46, 51, 56, 0.09)',
      colorPressed: 'rgba(46, 51, 56, 0.22)',
    },
    primary: {
      color: '#a855f7',
      colorHover: '#c084fc',
      colorPressed: '#9333ea',
      colorFaded: '#a855f72f',
    },
    warning: {
      color: '#f59e0b',
      colorHover: '#f59e0b',
      colorPressed: '#f59e0b',
      colorFaded: '#f59e0b2f',
    },
    success: {
      color: '#10b981',
      colorHover: '#34d399',
      colorPressed: '#059669',
      colorFaded: '#10b9812f',
    },
    error: {
      color: '#ef4444',
      colorHover: '#f87171',
      colorPressed: '#dc2626',
      colorFaded: '#ef44442a',
    },
  },
  dark: {
    background: '#1e1e1e',
    text: {
      baseColor: '#ffffffd1',
      mutedColor: '#ffffff80',
    },
    default: {
      color: 'rgba(255, 255, 255, 0.08)',
      colorHover: 'rgba(255, 255, 255, 0.12)',
      colorPressed: 'rgba(255, 255, 255, 0.24)',
    },
    primary: {
      color: '#c084fc',
      colorHover: '#d8b4fe',
      colorPressed: '#a855f7',
      colorFaded: '#c084fc2f',
    },
    warning: {
      color: '#f59e0b',
      colorHover: '#fbbf24',
      colorPressed: '#d97706',
      colorFaded: '#f59e0b2f',
    },
    success: {
      color: '#10b981',
      colorHover: '#34d399',
      colorPressed: '#059669',
      colorFaded: '#10b9812f',
    },
    error: {
      color: '#f87171',
      colorHover: '#fca5a5',
      colorPressed: '#ef4444',
      colorFaded: '#f871712a',
    },
  },
});
