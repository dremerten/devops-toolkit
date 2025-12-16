import type { RouteRecordRaw } from 'vue-router';
import SteampunkDemo from '../../pages/SteampunkDemo.page.vue';
import PegboardDemo from '../../pages/PegboardDemo.page.vue';
import DemoHome from './demo-home.page.vue';

const demoPages = import.meta.glob('../*/*.demo.vue', { eager: true });

export const demoRoutes = Object.keys(demoPages).map((demoComponentPath) => {
  const [, , fileName] = demoComponentPath.split('/');
  const demoComponentName = fileName.split('.').shift();

  return {
    path: demoComponentName,
    name: demoComponentName,
    component: () => import(/* @vite-ignore */ demoComponentPath),
  } as RouteRecordRaw;
});

export const routes = [
  {
    path: '/steampunk-demo',
    name: 'steampunk-demo',
    component: SteampunkDemo,
  },
  {
    path: '/pegboard-demo',
    name: 'pegboard-demo',
    component: PegboardDemo,
  },
  {
    path: '/c-lib',
    name: 'c-lib',
    children: [
      {
        path: '',
        name: 'c-lib-index',
        component: DemoHome,
      },
      ...demoRoutes,
    ],
    component: () => import('./demo-wrapper.vue'),
  },
];
