<template>
  <div class="pegboard-container">
    <!-- Modern pegboard surface -->
    <div class="pegboard-surface" />

    <!-- Content -->
    <div class="pegboard-content">
      <slot />
    </div>
  </div>
</template>

<style scoped lang="less">
.pegboard-container {
  position: relative;
  min-height: 100vh;
  background: linear-gradient(180deg, #D5D5D5 0%, #C8C8C8 100%);
  padding: 80px 40px;
  overflow: hidden;
}

/* Apple-style grey pegboard surface */
.pegboard-surface {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #D1D1D1;

  /* Darker pegboard hole pattern */
  background-image:
    radial-gradient(circle at center, rgba(0, 0, 0, 0.18) 1.5px, transparent 1.5px);
  background-size: 30px 30px;
  background-position: 0 0;

  /* Clean Apple-style overlay */
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background:
      radial-gradient(
        ellipse at top,
        rgba(255, 255, 255, 0.35) 0%,
        transparent 60%
      ),
      radial-gradient(
        ellipse at bottom,
        rgba(0, 0, 0, 0.05) 0%,
        transparent 60%
      );
    pointer-events: none;
  }

  /* Premium Apple-style ambient lighting */
  &::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    right: -50%;
    bottom: -50%;
    background:
      radial-gradient(
        ellipse at 25% 15%,
        rgba(230, 240, 250, 0.12) 0%,
        transparent 45%
      ),
      radial-gradient(
        ellipse at 75% 85%,
        rgba(200, 210, 220, 0.08) 0%,
        transparent 45%
      );
    pointer-events: none;
    animation: ambient-light 25s ease-in-out infinite;
  }
}

@keyframes ambient-light {
  0%, 100% {
    transform: translate(0, 0) scale(1);
    opacity: 0.4;
  }
  50% {
    transform: translate(1%, 1%) scale(1.02);
    opacity: 0.6;
  }
}

.pegboard-content {
  position: relative;
  z-index: 2;
  max-width: 1400px;
  margin: 0 auto;
}
</style>
