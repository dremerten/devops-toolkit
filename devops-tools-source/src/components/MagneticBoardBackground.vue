<template>
  <div class="magnetic-board">
    <!-- Main metallic surface -->
    <div class="metal-surface" />

    <!-- Brass corner brackets -->
    <div class="corner-bracket corner-tl" />
    <div class="corner-bracket corner-tr" />
    <div class="corner-bracket corner-bl" />
    <div class="corner-bracket corner-br" />

    <!-- Content slot -->
    <div class="board-content">
      <slot />
    </div>
  </div>
</template>

<style scoped lang="less">
.magnetic-board {
  position: relative;
  min-height: 100vh;
  background: #1a1a1a;
  padding: 40px 20px;
  overflow: hidden;

  /* Dark charcoal base with subtle gradient */
  background: radial-gradient(ellipse at top, #252525 0%, #1a1a1a 50%, #121212 100%);
}

/* Metallic surface texture */
.metal-surface {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;

  /* Brushed metal texture */
  background-image:
    repeating-linear-gradient(
      90deg,
      transparent,
      transparent 1px,
      rgba(255, 255, 255, 0.02) 1px,
      rgba(255, 255, 255, 0.02) 2px
    ),
    repeating-linear-gradient(
      0deg,
      transparent,
      transparent 1px,
      rgba(0, 0, 0, 0.03) 1px,
      rgba(0, 0, 0, 0.03) 2px
    );

  pointer-events: none;

  /* Vignette effect */
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: radial-gradient(ellipse at center, transparent 0%, rgba(0, 0, 0, 0.4) 100%);
  }

  /* Copper light reflection */
  &::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    right: -50%;
    bottom: -50%;
    background:
      radial-gradient(
        ellipse at 20% 20%,
        rgba(184, 115, 51, 0.08) 0%,
        transparent 30%
      ),
      radial-gradient(
        ellipse at 80% 80%,
        rgba(139, 99, 20, 0.05) 0%,
        transparent 30%
      );
    animation: subtle-shimmer 10s ease-in-out infinite;
  }
}

@keyframes subtle-shimmer {
  0%, 100% {
    opacity: 0.5;
    transform: translate(0, 0);
  }
  50% {
    opacity: 0.8;
    transform: translate(2%, 2%);
  }
}

/* Brass corner brackets */
.corner-bracket {
  position: fixed;
  width: 80px;
  height: 80px;
  z-index: 1;
  pointer-events: none;

  &::before,
  &::after {
    content: '';
    position: absolute;
    background: linear-gradient(135deg, #CD7F32 0%, #B87333 50%, #8B6914 100%);
    box-shadow:
      inset 0 1px 2px rgba(255, 255, 255, 0.3),
      inset 0 -1px 2px rgba(0, 0, 0, 0.5),
      0 4px 8px rgba(0, 0, 0, 0.4);
  }

  &::before {
    width: 80px;
    height: 12px;
  }

  &::after {
    width: 12px;
    height: 80px;
  }
}

.corner-tl {
  top: 20px;
  left: 20px;

  &::before {
    top: 0;
    left: 0;
    border-radius: 6px 0 0 0;
  }

  &::after {
    top: 0;
    left: 0;
    border-radius: 6px 0 0 0;
  }
}

.corner-tr {
  top: 20px;
  right: 20px;

  &::before {
    top: 0;
    right: 0;
    border-radius: 0 6px 0 0;
  }

  &::after {
    top: 0;
    right: 0;
    border-radius: 0 6px 0 0;
  }
}

.corner-bl {
  bottom: 20px;
  left: 20px;

  &::before {
    bottom: 0;
    left: 0;
    border-radius: 0 0 0 6px;
  }

  &::after {
    bottom: 0;
    left: 0;
    border-radius: 0 0 0 6px;
  }
}

.corner-br {
  bottom: 20px;
  right: 20px;

  &::before {
    bottom: 0;
    right: 0;
    border-radius: 0 0 6px 0;
  }

  &::after {
    bottom: 0;
    right: 0;
    border-radius: 0 0 6px 0;
  }
}

.board-content {
  position: relative;
  z-index: 2;
  max-width: 1400px;
  margin: 0 auto;
}
</style>
