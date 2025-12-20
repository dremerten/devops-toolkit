import type { GlobalThemeOverrides } from 'naive-ui';

export const lightThemeOverrides: GlobalThemeOverrides = {
  common: {
    primaryColor: '#f97316',
    primaryColorHover: '#fb923c',
    primaryColorPressed: '#ea580c',
    primaryColorSuppl: '#feddca',
    successColor: '#10b981',
    warningColor: '#f97316',
    errorColor: '#ef4444',
    infoColor: '#f97316',
    textColorBase: '#0f172a',
    textColor1: '#1f2a37',
    textColor2: '#1e293b',
    textColor3: '#1c2433',
    textColorDisabled: '#94a3b8',
    placeholderColor: '#94a3b8',
    bodyColor: '#fffdfa',
    dividerColor: 'rgba(15, 23, 42, 0.12)',
    borderColor: 'rgba(15, 23, 42, 0.12)',
    borderColorHover: 'rgba(15, 23, 42, 0.18)',
    cardColor: '#ffffff',
    cardColorHover: '#fffdf9',
    cardColorPressed: '#fff4e4',
  },

  Menu: {
    itemHeight: '32px',
  },

  Layout: {
    color: '#fffdfa',
    siderColor: '#fffdfa',
    siderBorderColor: 'rgba(15, 23, 42, 0.15)',
  },

  Card: {
    color: '#ffffff',
    borderColor: 'rgba(15, 23, 42, 0.12)',
  },

  AutoComplete: {
    peers: {
      InternalSelectMenu: { height: '500px' },
    },
  },
};

export const darkThemeOverrides: GlobalThemeOverrides = {
  common: {
    primaryColor: '#a855f7',
    primaryColorHover: '#c084fc',
    primaryColorPressed: '#9333ea',
    primaryColorSuppl: '#d8b4fe',
  },

  Notification: {
    color: '#0f172a',
  },

  AutoComplete: {
    peers: {
      InternalSelectMenu: { height: '500px', color: '#1e1e1e' },
    },
  },

  Menu: {
    itemHeight: '32px',
  },

  Layout: {
    color: '#0b0f14',
    siderColor: '#0f172a',
    siderBorderColor: '#1e293b',
  },

  Card: {
    color: '#0f172a',
    borderColor: '#1e293b',
  },

  Table: {
    tdColor: '#0f172a',
    thColor: '#111827',
  },
};
