<template>
  <div class="atmosphere">
    <div class="atmosphere-sheen" />
    <div class="atmosphere-grid" />
    <div class="atmosphere-noise" />
    <div class="atmosphere-content">
      <slot />
    </div>
  </div>
</template>

<style scoped lang="less">
.atmosphere {
  position: relative;
  min-height: 100vh;
  padding: 96px 48px 120px;
  overflow: hidden;
  background:
    radial-gradient(1100px 520px at 90% -5%, rgba(249, 115, 22, 0.24), transparent 55%),
    radial-gradient(900px 520px at 12% 18%, rgba(251, 191, 36, 0.18), transparent 60%),
    linear-gradient(180deg, #03060d 0%, #05070f 55%, #03060d 100%);
}

:global(html:not(.dark)) .atmosphere {
  background:
    radial-gradient(1100px 520px at 85% -10%, rgba(249, 115, 22, 0.22), transparent 60%),
    radial-gradient(900px 520px at 10% 15%, rgba(251, 191, 36, 0.28), transparent 60%),
    linear-gradient(180deg, #fffdfa 0%, #fff0e2 55%, #fffdfa 100%);
}

.atmosphere-sheen {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(500px 300px at 80% 0%, rgba(168, 85, 247, 0.25), transparent 65%),
    radial-gradient(420px 260px at 20% 15%, rgba(192, 132, 252, 0.18), transparent 60%);
  opacity: 0.65;
  pointer-events: none;
  animation: sheen 18s ease-in-out infinite;
}

.atmosphere-grid {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(148, 163, 184, 0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(148, 163, 184, 0.06) 1px, transparent 1px);
  background-size: 80px 80px;
  opacity: 0.35;
  mask-image: radial-gradient(circle at 50% 20%, rgba(0, 0, 0, 0.8) 0%, transparent 70%);
  pointer-events: none;
}

.atmosphere-noise {
  position: absolute;
  inset: -50%;
  background: transparent url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzMDAiIGhlaWdodD0iMzAwIj48ZmlsdGVyIGlkPSJub2lzZSIgeD0iMCIgeT0iMCI+PGZlVHVyYnVsZW5jZSB0eXBlPSJmcmFjdGFsTm9pc2UiIGJhc2VGcmVxdWVuY3k9IjAuNzUiIHN0aXRjaFRpbGVzPSJzdGl0Y2giLz48L2ZpbHRlcj48cmVjdCB3aWR0aD0iMzAwIiBoZWlnaHQ9IjMwMCIgZmlsdGVyPSJ1cmwoI25vaXNlKSIgb3BhY2l0eT0iMC4zIi8+PC9zdmc+") repeat;
  background-size: 300px 300px;
  opacity: 0.25;
  pointer-events: none;
  animation: noise-shift 1.2s steps(2) infinite;
}

:global(html:not(.dark)) .atmosphere-sheen {
  background:
    radial-gradient(500px 300px at 80% 0%, rgba(249, 115, 22, 0.25), transparent 65%),
    radial-gradient(420px 260px at 20% 15%, rgba(251, 191, 36, 0.2), transparent 62%);
  opacity: 0.55;
}

:global(html:not(.dark)) .atmosphere-grid {
  background-image:
    linear-gradient(rgba(15, 23, 42, 0.08) 1px, transparent 1px),
    linear-gradient(90deg, rgba(15, 23, 42, 0.08) 1px, transparent 1px);
  opacity: 0.35;
}

:global(html:not(.dark)) .atmosphere-noise {
  background: transparent url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzMDAiIGhlaWdodD0iMzAwIj48ZmlsdGVyIGlkPSJub2lzZSIgeD0iMCIgeT0iMCI+PGZlVHVyYnVsZW5jZSB0eXBlPSJmcmFjdGFsTm9pc2UiIGJhc2VGcmVxdWVuY3k9IjAuNzUiIHN0aXRjaFRpbGVzPSJzdGl0Y2giLz48L2ZpbHRlcj48cmVjdCB3aWR0aD0iMzAwIiBoZWlnaHQ9IjMwMCIgZmlsdGVyPSJ1cmwoI25vaXNlKSIgb3BhY2l0eT0iMC4xIi8+PC9zdmc+") repeat;
  opacity: 0.22;
}

.atmosphere-content {
  position: relative;
  z-index: 2;
  max-width: 1400px;
  margin: 0 auto;
}

@keyframes sheen {
  0%, 100% {
    transform: translate(0, 0);
    opacity: 0.55;
  }
  50% {
    transform: translate(1%, -1%);
    opacity: 0.8;
  }
}

@keyframes noise-shift {
  0%, 100% {
    transform: translate(0, 0);
  }
  50% {
    transform: translate(-1%, 1%);
  }
}

@media (max-width: 768px) {
  .atmosphere {
    padding: 88px 20px 96px;
  }
}
</style>
