<script setup lang="ts">
defineProps<{
  tool: string
  size?: number
}>();
</script>

<template>
  <svg
    :width="size || 80"
    :height="size || 80"
    viewBox="0 0 100 100"
    class="tool-silhouette"
  >
    <!-- Hammer -->
    <g v-if="tool === 'hammer'">
      <path
        d="M85,15 L75,25 L70,20 L65,25 L35,55 L15,35 L10,40 L5,45 L15,55 L20,60 L30,70 L40,80 L45,75 L50,70 L40,60 L70,30 L75,35 L80,30 L90,20 L95,15 L90,10 L85,15 Z"
        fill="currentColor"
      />
      <rect x="78" y="8" width="18" height="8" rx="2" fill="currentColor" transform="rotate(45 87 12)" />
    </g>

    <!-- Screwdriver -->
    <g v-else-if="tool === 'screwdriver'">
      <path
        d="M90,5 L85,10 L75,20 L70,25 L45,50 L40,55 L35,60 L30,65 L25,70 L20,75 L15,80 L10,85 L15,90 L20,85 L25,80 L30,75 L35,70 L40,65 L45,60 L50,55 L75,30 L80,25 L90,15 L95,10 L90,5 Z"
        fill="currentColor"
      />
      <rect x="72" y="18" width="6" height="40" rx="1" fill="currentColor" transform="rotate(45 75 38)" />
      <path d="M88,7 L93,12 L95,10 L92,5 L88,7 Z" fill="currentColor" />
    </g>

    <!-- Pliers -->
    <g v-else-if="tool === 'pliers'">
      <path
        d="M30,10 L35,15 L40,20 L45,25 L50,30 L45,35 L40,30 L35,25 L30,20 L25,15 L20,10 L15,15 L20,20 L25,25 L30,30 L35,35 L40,40 L45,45 L50,50 L45,55 L40,60 L35,65 L30,70 L25,75 L20,80 L15,85 L20,90 L25,85 L30,80 L35,75 L40,70 L45,65 L50,60 L55,55 L60,60 L65,65 L70,70 L75,75 L80,80 L85,85 L90,80 L85,75 L80,70 L75,65 L70,60 L65,55 L60,50 L55,45 L60,40 L65,35 L70,30 L75,25 L80,20 L85,15 L90,10 L85,5 L80,10 L75,15 L70,20 L65,25 L60,30 L55,35 L50,30 L45,25 L40,20 L35,15 L30,10 Z"
        fill="currentColor"
      />
    </g>

    <!-- Code/Brackets -->
    <g v-else-if="tool === 'code'">
      <path
        d="M30,20 L10,50 L30,80 L40,75 L25,50 L40,25 L30,20 Z M70,20 L60,25 L75,50 L60,75 L70,80 L90,50 L70,20 Z"
        fill="currentColor"
      />
      <rect x="45" y="15" width="10" height="70" rx="2" fill="currentColor" transform="rotate(15 50 50)" />
    </g>

    <!-- Gear/Settings -->
    <g v-else-if="tool === 'gear'">
      <path
        d="M50,10 L55,25 L70,25 L60,35 L65,50 L50,42 L35,50 L40,35 L30,25 L45,25 L50,10 Z M50,30 C58,30 65,37 65,45 C65,53 58,60 50,60 C42,60 35,53 35,45 C35,37 42,30 50,30 Z M50,35 C45,35 40,40 40,45 C40,50 45,55 50,55 C55,55 60,50 60,45 C60,40 55,35 50,35 Z"
        fill="currentColor"
      />
      <circle cx="50" cy="50" r="25" fill="none" stroke="currentColor" stroke-width="8" />
      <circle cx="50" cy="50" r="12" fill="currentColor" />
    </g>

    <!-- Lock/Security -->
    <g v-else-if="tool === 'lock'">
      <rect x="30" y="45" width="40" height="45" rx="5" fill="currentColor" />
      <path
        d="M35,45 L35,30 C35,20 42,12 50,12 C58,12 65,20 65,30 L65,45"
        fill="none"
        stroke="currentColor"
        stroke-width="8"
        stroke-linecap="round"
      />
      <circle cx="50" cy="65" r="5" fill="#2d2d2d" />
      <rect x="48" y="65" width="4" height="12" rx="1" fill="#2d2d2d" />
    </g>

    <!-- Key -->
    <g v-else-if="tool === 'key'">
      <circle cx="25" cy="25" r="18" fill="currentColor" />
      <circle cx="25" cy="25" r="8" fill="#2d2d2d" />
      <rect x="32" y="20" width="60" height="10" rx="2" fill="currentColor" />
      <rect x="70" y="15" width="8" height="20" rx="1" fill="currentColor" />
      <rect x="82" y="15" width="8" height="20" rx="1" fill="currentColor" />
    </g>

    <!-- Database -->
    <g v-else-if="tool === 'database'">
      <ellipse cx="50" cy="25" rx="35" ry="12" fill="currentColor" />
      <path d="M15,25 L15,75 C15,82 30,88 50,88 C70,88 85,82 85,75 L85,25" fill="currentColor" />
      <ellipse cx="50" cy="75" rx="35" ry="12" fill="#1a1a1a" />
      <ellipse cx="50" cy="55" rx="35" ry="12" fill="currentColor" />
      <ellipse cx="50" cy="55" rx="35" ry="12" fill="#1a1a1a" opacity="0.5" />
    </g>

    <!-- Network/Connected -->
    <g v-else-if="tool === 'network'">
      <circle cx="50" cy="20" r="12" fill="currentColor" />
      <circle cx="20" cy="60" r="12" fill="currentColor" />
      <circle cx="80" cy="60" r="12" fill="currentColor" />
      <circle cx="50" cy="85" r="12" fill="currentColor" />
      <line x1="50" y1="32" x2="50" y2="73" stroke="currentColor" stroke-width="6" />
      <line x1="45" y1="28" x2="28" y2="52" stroke="currentColor" stroke-width="6" />
      <line x1="55" y1="28" x2="72" y2="52" stroke="currentColor" stroke-width="6" />
      <line x1="32" y1="65" x2="42" y2="80" stroke="currentColor" stroke-width="6" />
      <line x1="68" y1="65" x2="58" y2="80" stroke="currentColor" stroke-width="6" />
    </g>

    <!-- Server -->
    <g v-else-if="tool === 'server'">
      <rect x="15" y="15" width="70" height="20" rx="4" fill="currentColor" />
      <rect x="15" y="40" width="70" height="20" rx="4" fill="currentColor" />
      <rect x="15" y="65" width="70" height="20" rx="4" fill="currentColor" />
      <circle cx="25" cy="25" r="3" fill="#1a1a1a" />
      <circle cx="35" cy="25" r="3" fill="#1a1a1a" />
      <circle cx="25" cy="50" r="3" fill="#1a1a1a" />
      <circle cx="35" cy="50" r="3" fill="#1a1a1a" />
      <circle cx="25" cy="75" r="3" fill="#1a1a1a" />
      <circle cx="35" cy="75" r="3" fill="#1a1a1a" />
    </g>

    <!-- Clock/Time -->
    <g v-else-if="tool === 'clock'">
      <circle cx="50" cy="50" r="38" fill="currentColor" />
      <circle cx="50" cy="50" r="32" fill="none" stroke="#1a1a1a" stroke-width="2" />
      <line x1="50" y1="50" x2="50" y2="25" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" />
      <line x1="50" y1="50" x2="70" y2="50" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" />
      <circle cx="50" cy="50" r="4" fill="#1a1a1a" />
    </g>

    <!-- Calendar -->
    <g v-else-if="tool === 'calendar'">
      <rect x="15" y="25" width="70" height="65" rx="5" fill="currentColor" />
      <rect x="15" y="25" width="70" height="18" rx="5" fill="currentColor" opacity="0.8" />
      <rect x="30" y="15" width="6" height="18" rx="3" fill="currentColor" />
      <rect x="64" y="15" width="6" height="18" rx="3" fill="currentColor" />
      <path d="M25,55 L35,55 M45,55 L55,55 M65,55 L75,55 M25,68 L35,68 M45,68 L55,68 M65,68 L75,68" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
    </g>

    <!-- Camera -->
    <g v-else-if="tool === 'camera'">
      <rect x="15" y="30" width="70" height="50" rx="8" fill="currentColor" />
      <rect x="35" y="20" width="30" height="12" rx="4" fill="currentColor" />
      <circle cx="55" cy="55" r="18" fill="#1a1a1a" />
      <circle cx="55" cy="55" r="12" fill="currentColor" opacity="0.5" />
      <circle cx="25" cy="40" r="3" fill="#1a1a1a" />
    </g>

    <!-- WiFi -->
    <g v-else-if="tool === 'wifi'">
      <path d="M50,70 L50,75 M30,50 Q50,30 70,50 M20,35 Q50,10 80,35 M10,20 Q50,0 90,20" stroke="currentColor" stroke-width="8" stroke-linecap="round" fill="none" />
      <circle cx="50" cy="82" r="6" fill="currentColor" />
    </g>

    <!-- QR Code -->
    <g v-else-if="tool === 'qrcode'">
      <rect x="12" y="12" width="30" height="30" rx="3" fill="currentColor" />
      <rect x="58" y="12" width="30" height="30" rx="3" fill="currentColor" />
      <rect x="12" y="58" width="30" height="30" rx="3" fill="currentColor" />
      <rect x="20" y="20" width="14" height="14" rx="2" fill="#1a1a1a" />
      <rect x="66" y="20" width="14" height="14" rx="2" fill="#1a1a1a" />
      <rect x="20" y="66" width="14" height="14" rx="2" fill="#1a1a1a" />
      <rect x="58" y="58" width="12" height="12" fill="currentColor" />
      <rect x="75" y="58" width="13" height="12" fill="currentColor" />
      <rect x="58" y="76" width="12" height="12" fill="currentColor" />
      <rect x="75" y="76" width="13" height="12" fill="currentColor" />
    </g>

    <!-- Shield/Security -->
    <g v-else-if="tool === 'shield'">
      <path d="M50,10 L80,25 L80,50 Q80,75 50,90 Q20,75 20,50 L20,25 Z" fill="currentColor" />
      <path d="M50,25 L65,35 L65,52 Q65,65 50,75 Q35,65 35,52 L35,35 Z" fill="#1a1a1a" />
    </g>

    <!-- Calculator -->
    <g v-else-if="tool === 'calculator'">
      <rect x="20" y="10" width="60" height="80" rx="6" fill="currentColor" />
      <rect x="28" y="18" width="44" height="16" rx="3" fill="#1a1a1a" />
      <rect x="28" y="42" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="45" y="42" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="62" y="42" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="28" y="57" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="45" y="57" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="62" y="57" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="28" y="72" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="45" y="72" width="10" height="10" rx="2" fill="#1a1a1a" />
      <rect x="62" y="72" width="10" height="10" rx="2" fill="#1a1a1a" />
    </g>

    <!-- Document/Text -->
    <g v-else-if="tool === 'document'">
      <path d="M25,10 L60,10 L75,25 L75,90 L25,90 Z" fill="currentColor" />
      <path d="M60,10 L60,25 L75,25" fill="#1a1a1a" />
      <line x1="35" y1="38" x2="65" y2="38" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <line x1="35" y1="50" x2="65" y2="50" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <line x1="35" y1="62" x2="55" y2="62" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <line x1="35" y1="74" x2="65" y2="74" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
    </g>

    <!-- Chart/Graph -->
    <g v-else-if="tool === 'chart'">
      <rect x="15" y="15" width="70" height="70" rx="4" fill="currentColor" />
      <rect x="22" y="55" width="12" height="28" fill="#1a1a1a" />
      <rect x="38" y="40" width="12" height="43" fill="#1a1a1a" />
      <rect x="54" y="28" width="12" height="55" fill="#1a1a1a" />
      <rect x="70" y="48" width="12" height="35" fill="#1a1a1a" />
    </g>

    <!-- Image/Photo -->
    <g v-else-if="tool === 'image'">
      <rect x="15" y="20" width="70" height="60" rx="5" fill="currentColor" />
      <circle cx="35" cy="38" r="8" fill="#1a1a1a" />
      <path d="M15,65 L30,50 L45,65 L65,45 L85,65 L85,75 Q85,80 80,80 L20,80 Q15,80 15,75 Z" fill="#1a1a1a" />
    </g>

    <!-- Compass -->
    <g v-else-if="tool === 'compass'">
      <circle cx="50" cy="50" r="38" fill="currentColor" />
      <circle cx="50" cy="50" r="32" fill="none" stroke="#1a1a1a" stroke-width="2" />
      <path d="M50,18 L45,50 L50,35 L55,50 Z" fill="#ff0000" />
      <path d="M50,82 L55,50 L50,65 L45,50 Z" fill="#ffffff" />
      <circle cx="50" cy="50" r="4" fill="#1a1a1a" />
      <text x="50" y="25" font-size="12" fill="#1a1a1a" text-anchor="middle">N</text>
    </g>

    <!-- Ruler/Measure -->
    <g v-else-if="tool === 'ruler'">
      <rect x="10" y="35" width="80" height="30" rx="3" fill="currentColor" />
      <line x1="20" y1="40" x2="20" y2="60" stroke="#1a1a1a" stroke-width="2" />
      <line x1="30" y1="42" x2="30" y2="58" stroke="#1a1a1a" stroke-width="2" />
      <line x1="40" y1="40" x2="40" y2="60" stroke="#1a1a1a" stroke-width="2" />
      <line x1="50" y1="42" x2="50" y2="58" stroke="#1a1a1a" stroke-width="2" />
      <line x1="60" y1="40" x2="60" y2="60" stroke="#1a1a1a" stroke-width="2" />
      <line x1="70" y1="42" x2="70" y2="58" stroke="#1a1a1a" stroke-width="2" />
      <line x1="80" y1="40" x2="80" y2="60" stroke="#1a1a1a" stroke-width="2" />
    </g>

    <!-- Clipboard -->
    <g v-else-if="tool === 'clipboard'">
      <rect x="25" y="20" width="50" height="70" rx="5" fill="currentColor" />
      <rect x="35" y="10" width="30" height="15" rx="3" fill="currentColor" opacity="0.8" />
      <line x1="35" y1="38" x2="65" y2="38" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <line x1="35" y1="50" x2="65" y2="50" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <line x1="35" y1="62" x2="55" y2="62" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
    </g>

    <!-- Tag -->
    <g v-else-if="tool === 'tag'">
      <path d="M15,15 L50,15 L85,50 L50,85 L15,50 Z" fill="currentColor" />
      <circle cx="32" cy="32" r="6" fill="#1a1a1a" />
    </g>

    <!-- Search -->
    <g v-else-if="tool === 'search'">
      <circle cx="40" cy="40" r="25" fill="none" stroke="currentColor" stroke-width="8" />
      <line x1="58" y1="58" x2="85" y2="85" stroke="currentColor" stroke-width="10" stroke-linecap="round" />
    </g>

    <!-- Palette/Color -->
    <g v-else-if="tool === 'palette'">
      <path d="M50,10 Q25,10 15,30 Q10,45 15,60 Q20,75 35,80 L40,80 Q45,75 40,70 Q38,68 40,65 Q42,62 48,62 L70,62 Q80,62 85,52 Q90,42 85,30 Q75,10 50,10 Z" fill="currentColor" />
      <circle cx="35" cy="35" r="5" fill="#ff0000" />
      <circle cx="50" cy="28" r="5" fill="#00ff00" />
      <circle cx="65" cy="35" r="5" fill="#0000ff" />
      <circle cx="60" cy="50" r="5" fill="#ffff00" />
    </g>

    <!-- Puzzle -->
    <g v-else-if="tool === 'puzzle'">
      <path d="M20,20 L40,20 L40,15 Q45,10 50,15 Q55,10 60,15 L60,20 L80,20 L80,40 L85,40 Q90,45 85,50 Q90,55 85,60 L80,60 L80,80 L60,80 L60,85 Q55,90 50,85 Q45,90 40,85 L40,80 L20,80 L20,60 L15,60 Q10,55 15,50 Q10,45 15,40 L20,40 Z" fill="currentColor" />
    </g>

    <!-- Percent -->
    <g v-else-if="tool === 'percent'">
      <circle cx="30" cy="30" r="12" fill="currentColor" />
      <circle cx="70" cy="70" r="12" fill="currentColor" />
      <line x1="20" y1="80" x2="80" y2="20" stroke="currentColor" stroke-width="8" stroke-linecap="round" />
    </g>

    <!-- Globe -->
    <g v-else-if="tool === 'globe'">
      <circle cx="50" cy="50" r="35" fill="none" stroke="currentColor" stroke-width="6" />
      <ellipse cx="50" cy="50" rx="15" ry="35" fill="none" stroke="currentColor" stroke-width="5" />
      <line x1="15" y1="50" x2="85" y2="50" stroke="currentColor" stroke-width="5" />
      <ellipse cx="50" cy="50" rx="35" ry="12" fill="none" stroke="currentColor" stroke-width="4" />
    </g>

    <!-- Phone -->
    <g v-else-if="tool === 'phone'">
      <rect x="28" y="10" width="44" height="80" rx="8" fill="currentColor" />
      <rect x="33" y="16" width="34" height="58" rx="3" fill="#1a1a1a" />
      <circle cx="50" cy="82" r="4" fill="#1a1a1a" />
    </g>

    <!-- Email/Envelope -->
    <g v-else-if="tool === 'email'">
      <rect x="12" y="25" width="76" height="50" rx="5" fill="currentColor" />
      <path d="M12,25 L50,55 L88,25" fill="none" stroke="#1a1a1a" stroke-width="6" stroke-linejoin="round" />
    </g>

    <!-- Terminal/Command -->
    <g v-else-if="tool === 'terminal'">
      <rect x="10" y="20" width="80" height="60" rx="5" fill="currentColor" />
      <path d="M20,35 L30,45 L20,55" fill="none" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
      <line x1="38" y1="52" x2="55" y2="52" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" />
    </g>

    <!-- Cloud -->
    <g v-else-if="tool === 'cloud'">
      <path d="M30,55 Q20,55 20,45 Q20,38 25,33 Q28,25 38,23 Q42,18 50,18 Q60,18 65,25 Q72,25 77,30 Q82,35 82,43 Q82,50 77,55 Z" fill="currentColor" />
      <ellipse cx="50" cy="58" rx="32" ry="18" fill="currentColor" />
    </g>

    <!-- Bookmark -->
    <g v-else-if="tool === 'bookmark'">
      <path d="M30,10 L70,10 L70,90 L50,75 L30,90 Z" fill="currentColor" />
    </g>

    <!-- Link/Chain -->
    <g v-else-if="tool === 'link'">
      <path d="M35,25 L45,15 Q50,10 55,15 L65,25 Q68,28 65,31 L60,36 M40,65 L30,75 Q25,80 20,75 L10,65 Q7,62 10,59 L15,54" fill="none" stroke="currentColor" stroke-width="8" stroke-linecap="round" />
      <line x1="35" y1="65" x2="65" y2="35" stroke="currentColor" stroke-width="8" stroke-linecap="round" />
    </g>

    <!-- Magnifier/Zoom -->
    <g v-else-if="tool === 'magnifier'">
      <circle cx="38" cy="38" r="24" fill="none" stroke="currentColor" stroke-width="7" />
      <line x1="54" y1="54" x2="80" y2="80" stroke="currentColor" stroke-width="10" stroke-linecap="round" />
      <line x1="38" y1="28" x2="38" y2="48" stroke="currentColor" stroke-width="4" />
      <line x1="28" y1="38" x2="48" y2="38" stroke="currentColor" stroke-width="4" />
    </g>

    <!-- Broadcast/Signal -->
    <g v-else-if="tool === 'broadcast'">
      <circle cx="50" cy="70" r="8" fill="currentColor" />
      <path d="M35,55 Q50,40 65,55 M25,40 Q50,20 75,40 M15,25 Q50,0 85,25" fill="none" stroke="currentColor" stroke-width="6" stroke-linecap="round" />
    </g>

    <!-- Convert/Transfer -->
    <g v-else-if="tool === 'convert'">
      <path d="M20,30 L70,30 L60,20 M70,30 L60,40" fill="none" stroke="currentColor" stroke-width="7" stroke-linecap="round" stroke-linejoin="round" />
      <path d="M80,70 L30,70 L40,60 M30,70 L40,80" fill="none" stroke="currentColor" stroke-width="7" stroke-linecap="round" stroke-linejoin="round" />
    </g>

    <!-- file-binary -->
    <g v-else-if="tool === 'file-binary'">
      <path d="M25,10 L60,10 L75,25 L75,90 L25,90 Z" fill="currentColor" />
      <path d="M60,10 L60,25 L75,25" fill="#1a1a1a" />
      <text x="35" y="60" font-size="28" fill="#1a1a1a" font-weight="bold" font-family="monospace">01</text>
    </g>

    <!-- text-binary -->
    <g v-else-if="tool === 'text-binary'">
      <rect x="15" y="30" width="70" height="45" rx="5" fill="currentColor" />
      <text x="22" y="52" font-size="12" fill="#1a1a1a" font-family="monospace" font-weight="bold">01010</text>
      <text x="22" y="66" font-size="12" fill="#1a1a1a" font-family="monospace" font-weight="bold">11001</text>
    </g>

    <!-- user-lock -->
    <g v-else-if="tool === 'user-lock'">
      <circle cx="32" cy="28" r="13" fill="currentColor" />
      <path d="M18,50 Q32,42 46,50 L46,70 L18,70 Z" fill="currentColor" />
      <rect x="54" y="52" width="32" height="30" rx="4" fill="currentColor" />
      <path d="M59,52 L59,45 C59,40 66,36 73,36 C80,36 87,40 87,45 L87,52" fill="none" stroke="currentColor" stroke-width="5" />
    </g>

    <!-- envelope-check -->
    <g v-else-if="tool === 'envelope-check'">
      <rect x="10" y="32" width="56" height="36" rx="4" fill="currentColor" />
      <path d="M10,32 L38,52 L66,32" fill="none" stroke="#1a1a1a" stroke-width="5" />
      <path d="M72,50 L77,55 L90,38" fill="none" stroke="currentColor" stroke-width="7" stroke-linecap="round" stroke-linejoin="round" />
    </g>

    <!-- text-art -->
    <g v-else-if="tool === 'text-art'">
      <text x="15" y="45" font-size="32" fill="currentColor" font-weight="bold" font-family="serif">Aa</text>
      <path d="M15,52 Q50,62 85,52" stroke="currentColor" stroke-width="4" fill="none" />
      <text x="22" y="78" font-size="14" fill="currentColor" font-family="monospace">ASCII</text>
    </g>

    <!-- unicode -->
    <g v-else-if="tool === 'unicode'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="28" y="65" font-size="32" fill="#1a1a1a" font-weight="bold">U+</text>
    </g>

    <!-- link-broken -->
    <g v-else-if="tool === 'link-broken'">
      <path d="M22,38 L32,28 Q37,23 42,28 L48,34" stroke="currentColor" stroke-width="8" stroke-linecap="round" fill="none" />
      <path d="M78,62 L68,72 Q63,77 58,72 L52,66" stroke="currentColor" stroke-width="8" stroke-linecap="round" fill="none" />
      <line x1="40" y1="60" x2="60" y2="40" stroke="currentColor" stroke-width="8" stroke-linecap="round" stroke-dasharray="4,10" />
    </g>

    <!-- angle-to-bracket -->
    <g v-else-if="tool === 'angle-to-bracket'">
      <path d="M15,28 L30,50 L15,72" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
      <path d="M25,28 L40,50 L25,72" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
      <path d="M55,35 L70,35 L70,65 L55,65" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
      <path d="M75,35 L90,35 L90,65 L75,65" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
    </g>

    <!-- bracket-to-angle -->
    <g v-else-if="tool === 'bracket-to-angle'">
      <path d="M10,35 L25,35 L25,65 L10,65" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
      <path d="M30,35 L45,35 L45,65 L30,65" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
      <path d="M60,28 L75,50 L60,72" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
      <path d="M70,28 L85,50 L70,72" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" />
    </g>

    <!-- regex -->
    <g v-else-if="tool === 'regex'">
      <circle cx="50" cy="50" r="34" fill="none" stroke="currentColor" stroke-width="6" />
      <text x="24" y="65" font-size="36" fill="currentColor" font-weight="bold" font-family="monospace">.*</text>
    </g>

    <!-- regex-book -->
    <g v-else-if="tool === 'regex-book'">
      <rect x="20" y="15" width="60" height="70" rx="4" fill="currentColor" />
      <rect x="28" y="12" width="8" height="76" fill="currentColor" opacity="0.6" />
      <text x="38" y="58" font-size="24" fill="#1a1a1a" font-weight="bold" font-family="monospace">.*</text>
    </g>

    <!-- markdown -->
    <g v-else-if="tool === 'markdown'">
      <text x="14" y="70" font-size="68" fill="currentColor" font-weight="bold" font-family="serif">M↓</text>
    </g>

    <!-- certificate -->
    <g v-else-if="tool === 'certificate'">
      <rect x="18" y="18" width="64" height="50" rx="6" fill="currentColor" />
      <circle cx="50" cy="82" r="12" fill="currentColor" />
      <path d="M50,68 L42,82 L50,78 L58,82 Z" fill="currentColor" />
      <line x1="30" y1="35" x2="70" y2="35" stroke="#1a1a1a" stroke-width="3" />
      <line x1="30" y1="48" x2="60" y2="48" stroke="#1a1a1a" stroke-width="3" />
    </g>

    <!-- numbers -->
    <g v-else-if="tool === 'numbers'">
      <text x="12" y="55" font-size="52" fill="currentColor" font-weight="bold" font-family="sans-serif">123</text>
    </g>

    <!-- ethernet -->
    <g v-else-if="tool === 'ethernet'">
      <rect x="25" y="35" width="50" height="30" rx="4" fill="currentColor" />
      <rect x="38" y="25" width="24" height="12" rx="2" fill="currentColor" />
      <line x1="35" y1="48" x2="35" y2="58" stroke="#1a1a1a" stroke-width="3" />
      <line x1="45" y1="48" x2="45" y2="58" stroke="#1a1a1a" stroke-width="3" />
      <line x1="55" y1="48" x2="55" y2="58" stroke="#1a1a1a" stroke-width="3" />
      <line x1="65" y1="48" x2="65" y2="58" stroke="#1a1a1a" stroke-width="3" />
    </g>

    <!-- binary-code -->
    <g v-else-if="tool === 'binary-code'">
      <rect x="15" y="20" width="70" height="60" rx="6" fill="currentColor" />
      <text x="22" y="42" font-size="10" fill="#1a1a1a" font-family="monospace">0101</text>
      <text x="22" y="55" font-size="10" fill="#1a1a1a" font-family="monospace">1100</text>
      <text x="22" y="68" font-size="10" fill="#1a1a1a" font-family="monospace">1010</text>
    </g>

    <!-- id-card -->
    <g v-else-if="tool === 'id-card'">
      <rect x="15" y="25" width="70" height="50" rx="5" fill="currentColor" />
      <circle cx="32" cy="45" r="10" fill="#1a1a1a" />
      <line x1="50" y1="38" x2="75" y2="38" stroke="#1a1a1a" stroke-width="3" />
      <line x1="50" y1="48" x2="70" y2="48" stroke="#1a1a1a" stroke-width="3" />
      <line x1="50" y1="58" x2="75" y2="58" stroke="#1a1a1a" stroke-width="3" />
    </g>

    <!-- bank -->
    <g v-else-if="tool === 'bank'">
      <path d="M50,15 L85,35 L80,35 L80,70 L20,70 L20,35 L15,35 Z" fill="currentColor" />
      <rect x="28" y="42" width="8" height="28" fill="#1a1a1a" />
      <rect x="46" y="42" width="8" height="28" fill="#1a1a1a" />
      <rect x="64" y="42" width="8" height="28" fill="#1a1a1a" />
      <rect x="15" y="73" width="70" height="8" fill="currentColor" />
    </g>

    <!-- eye-slash -->
    <g v-else-if="tool === 'eye-slash'">
      <path d="M50,35 Q30,50 50,65 Q70,50 50,35" fill="currentColor" />
      <circle cx="50" cy="50" r="8" fill="#1a1a1a" />
      <line x1="20" y1="20" x2="80" y2="80" stroke="currentColor" stroke-width="8" stroke-linecap="round" />
    </g>

    <!-- file-diff -->
    <g v-else-if="tool === 'file-diff'">
      <path d="M20,10 L50,10 L65,25 L65,50 L20,50 Z" fill="currentColor" />
      <path d="M35,50 L65,50 L80,65 L80,90 L35,90 Z" fill="currentColor" opacity="0.7" />
      <line x1="30" y1="28" x2="55" y2="28" stroke="#1a1a1a" stroke-width="2" />
      <line x1="45" y1="70" x2="70" y2="70" stroke="#1a1a1a" stroke-width="2" />
    </g>

    <!-- smiley -->
    <g v-else-if="tool === 'smiley'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <circle cx="38" cy="42" r="5" fill="#1a1a1a" />
      <circle cx="62" cy="42" r="5" fill="#1a1a1a" />
      <path d="M35,58 Q50,68 65,58" fill="none" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" />
    </g>

    <!-- shield-check -->
    <g v-else-if="tool === 'shield-check'">
      <path d="M50,12 L78,27 L78,52 Q78,72 50,88 Q22,72 22,52 L22,27 Z" fill="currentColor" />
      <path d="M38,50 L46,58 L64,38" fill="none" stroke="#1a1a1a" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
    </g>

    <!-- yaml-toml, json-toml, toml-yaml, toml-json, table-convert -->
    <g v-else-if="tool === 'yaml-toml'">
      <rect x="10" y="35" width="35" height="30" rx="3" fill="currentColor" />
      <text x="15" y="55" font-size="12" fill="#1a1a1a" font-weight="bold">YML</text>
      <path d="M50,50 L70,50" stroke="currentColor" stroke-width="5" marker-end="url(#arrow)" />
      <rect x="75" y="35" width="15" height="30" rx="3" fill="currentColor" />
      <text x="77" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">T</text>
    </g>

    <g v-else-if="tool === 'json-toml'">
      <rect x="10" y="35" width="35" height="30" rx="3" fill="currentColor" />
      <text x="13" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">JSON</text>
      <path d="M50,50 L70,50" stroke="currentColor" stroke-width="5" />
      <rect x="75" y="35" width="15" height="30" rx="3" fill="currentColor" />
      <text x="77" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">T</text>
    </g>

    <g v-else-if="tool === 'toml-yaml'">
      <rect x="10" y="35" width="15" height="30" rx="3" fill="currentColor" />
      <text x="12" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">T</text>
      <path d="M30,50 L50,50" stroke="currentColor" stroke-width="5" />
      <rect x="55" y="35" width="35" height="30" rx="3" fill="currentColor" />
      <text x="60" y="55" font-size="12" fill="#1a1a1a" font-weight="bold">YML</text>
    </g>

    <g v-else-if="tool === 'toml-json'">
      <rect x="10" y="35" width="15" height="30" rx="3" fill="currentColor" />
      <text x="12" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">T</text>
      <path d="M30,50 L50,50" stroke="currentColor" stroke-width="5" />
      <rect x="55" y="35" width="35" height="30" rx="3" fill="currentColor" />
      <text x="58" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">JSON</text>
    </g>

    <g v-else-if="tool === 'table-convert'">
      <rect x="15" y="25" width="70" height="50" rx="4" fill="currentColor" />
      <line x1="15" y1="40" x2="85" y2="40" stroke="#1a1a1a" stroke-width="2" />
      <line x1="15" y1="55" x2="85" y2="55" stroke="#1a1a1a" stroke-width="2" />
      <line x1="40" y1="25" x2="40" y2="75" stroke="#1a1a1a" stroke-width="2" />
      <line x1="65" y1="25" x2="65" y2="75" stroke="#1a1a1a" stroke-width="2" />
    </g>

    <!-- video-camera -->
    <g v-else-if="tool === 'video-camera'">
      <rect x="15" y="32" width="50" height="36" rx="6" fill="currentColor" />
      <path d="M65,42 L85,32 L85,68 L65,58 Z" fill="currentColor" />
      <circle cx="35" cy="50" r="8" fill="#1a1a1a" />
    </g>

    <!-- list-alt -->
    <g v-else-if="tool === 'list-alt'">
      <rect x="15" y="20" width="70" height="60" rx="5" fill="currentColor" />
      <circle cx="27" cy="35" r="4" fill="#1a1a1a" />
      <line x1="38" y1="35" x2="75" y2="35" stroke="#1a1a1a" stroke-width="3" />
      <circle cx="27" cy="50" r="4" fill="#1a1a1a" />
      <line x1="38" y1="50" x2="75" y2="50" stroke="#1a1a1a" stroke-width="3" />
      <circle cx="27" cy="65" r="4" fill="#1a1a1a" />
      <line x1="38" y1="65" x2="75" y2="65" stroke="#1a1a1a" stroke-width="3" />
    </g>

    <!-- phone-alt -->
    <g v-else-if="tool === 'phone-alt'">
      <rect x="30" y="12" width="40" height="76" rx="8" fill="currentColor" />
      <rect x="35" y="18" width="30" height="52" rx="3" fill="#1a1a1a" />
      <circle cx="50" cy="78" r="5" fill="#1a1a1a" />
      <rect x="44" y="14" width="12" height="3" rx="2" fill="#1a1a1a" />
    </g>

    <!-- json-compare -->
    <g v-else-if="tool === 'json-compare'">
      <rect x="10" y="25" width="35" height="50" rx="4" fill="currentColor" />
      <text x="18" y="55" font-size="18" fill="#1a1a1a" font-weight="bold">{}</text>
      <rect x="55" y="25" width="35" height="50" rx="4" fill="currentColor" />
      <text x="63" y="55" font-size="18" fill="#1a1a1a" font-weight="bold">{}</text>
      <path d="M42,35 L48,35 M42,50 L48,50 M42,65 L48,65" stroke="currentColor" stroke-width="3" />
    </g>

    <!-- network-wired -->
    <g v-else-if="tool === 'network-wired'">
      <rect x="10" y="20" width="20" height="15" rx="2" fill="currentColor" />
      <rect x="70" y="20" width="20" height="15" rx="2" fill="currentColor" />
      <rect x="10" y="65" width="20" height="15" rx="2" fill="currentColor" />
      <rect x="70" y="65" width="20" height="15" rx="2" fill="currentColor" />
      <circle cx="50" cy="50" r="8" fill="currentColor" />
      <line x1="30" y1="27" x2="42" y2="50" stroke="currentColor" stroke-width="3" />
      <line x1="70" y1="27" x2="58" y2="50" stroke="currentColor" stroke-width="3" />
      <line x1="30" y1="72" x2="42" y2="50" stroke="currentColor" stroke-width="3" />
      <line x1="70" y1="72" x2="58" y2="50" stroke="currentColor" stroke-width="3" />
    </g>

    <!-- http -->
    <g v-else-if="tool === 'http'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="20" y="65" font-size="24" fill="#1a1a1a" font-weight="bold">HTTP</text>
    </g>

    <!-- yaml-json, json-yaml -->
    <g v-else-if="tool === 'yaml-json'">
      <rect x="8" y="35" width="38" height="30" rx="4" fill="currentColor" />
      <text x="13" y="55" font-size="12" fill="#1a1a1a" font-weight="bold">YAML</text>
      <polygon points="50,50 58,45 58,55" fill="currentColor" />
      <rect x="62" y="35" width="30" height="30" rx="4" fill="currentColor" />
      <text x="67" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">JSON</text>
    </g>

    <g v-else-if="tool === 'json-yaml'">
      <rect x="8" y="35" width="30" height="30" rx="4" fill="currentColor" />
      <text x="13" y="55" font-size="10" fill="#1a1a1a" font-weight="bold">JSON</text>
      <polygon points="42,50 50,45 50,55" fill="currentColor" />
      <rect x="54" y="35" width="38" height="30" rx="4" fill="currentColor" />
      <text x="59" y="55" font-size="12" fill="#1a1a1a" font-weight="bold">YAML</text>
    </g>

    <!-- ipv6, ipv4 -->
    <g v-else-if="tool === 'ipv6'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="24" y="65" font-size="28" fill="#1a1a1a" font-weight="bold">IPv6</text>
    </g>

    <g v-else-if="tool === 'ipv4'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="24" y="65" font-size="28" fill="#1a1a1a" font-weight="bold">IPv4</text>
    </g>

    <!-- stopwatch -->
    <g v-else-if="tool === 'stopwatch'">
      <circle cx="50" cy="55" r="32" fill="currentColor" />
      <rect x="43" y="18" width="14" height="10" rx="3" fill="currentColor" />
      <circle cx="50" cy="55" r="3" fill="#1a1a1a" />
      <line x1="50" y1="55" x2="50" y2="35" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" />
      <line x1="50" y1="55" x2="65" y2="55" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
    </g>

    <!-- browser -->
    <g v-else-if="tool === 'browser'">
      <rect x="15" y="25" width="70" height="55" rx="5" fill="currentColor" />
      <rect x="15" y="25" width="70" height="12" rx="5" fill="currentColor" opacity="0.7" />
      <circle cx="24" cy="31" r="2.5" fill="#1a1a1a" />
      <circle cx="33" cy="31" r="2.5" fill="#1a1a1a" />
      <circle cx="42" cy="31" r="2.5" fill="#1a1a1a" />
      <line x1="25" y1="50" x2="75" y2="50" stroke="#1a1a1a" stroke-width="2" />
      <line x1="25" y1="60" x2="65" y2="60" stroke="#1a1a1a" stroke-width="2" />
      <line x1="25" y1="70" x2="75" y2="70" stroke="#1a1a1a" stroke-width="2" />
    </g>

    <!-- subnet -->
    <g v-else-if="tool === 'subnet'">
      <rect x="20" y="15" width="25" height="20" rx="3" fill="currentColor" />
      <rect x="55" y="15" width="25" height="20" rx="3" fill="currentColor" />
      <rect x="20" y="65" width="25" height="20" rx="3" fill="currentColor" />
      <rect x="55" y="65" width="25" height="20" rx="3" fill="currentColor" />
      <circle cx="50" cy="50" r="10" fill="currentColor" />
      <line x1="32" y1="35" x2="42" y2="45" stroke="currentColor" stroke-width="3" />
      <line x1="68" y1="35" x2="58" y2="45" stroke="currentColor" stroke-width="3" />
      <line x1="32" y1="65" x2="42" y2="55" stroke="currentColor" stroke-width="3" />
      <line x1="68" y1="65" x2="58" y2="55" stroke="currentColor" stroke-width="3" />
    </g>

    <!-- docker -->
    <g v-else-if="tool === 'docker'">
      <rect x="20" y="40" width="12" height="12" fill="currentColor" />
      <rect x="34" y="40" width="12" height="12" fill="currentColor" />
      <rect x="48" y="40" width="12" height="12" fill="currentColor" />
      <rect x="62" y="40" width="12" height="12" fill="currentColor" />
      <rect x="34" y="26" width="12" height="12" fill="currentColor" />
      <rect x="48" y="26" width="12" height="12" fill="currentColor" />
      <path d="M12,52 L88,52 Q92,52 92,58 L92,68 Q92,72 88,72 L12,72 Q8,72 8,68 L8,58 Q8,52 12,52" fill="currentColor" />
    </g>

    <!-- edit -->
    <g v-else-if="tool === 'edit'">
      <path d="M68,18 L82,32 L42,72 L20,78 L26,56 Z" fill="currentColor" />
      <rect x="72" y="12" width="18" height="8" rx="2" fill="currentColor" transform="rotate(45 81 16)" />
      <line x1="28" y1="68" x2="38" y2="58" stroke="#1a1a1a" stroke-width="3" />
    </g>

    <!-- key-pair -->
    <g v-else-if="tool === 'key-pair'">
      <circle cx="28" cy="28" r="14" fill="currentColor" />
      <circle cx="28" cy="28" r="6" fill="#1a1a1a" />
      <rect x="35" y="23" width="35" height="10" rx="2" fill="currentColor" />
      <rect x="58" y="18" width="6" height="20" rx="1" fill="currentColor" />
      <circle cx="72" cy="72" r="14" fill="currentColor" />
      <circle cx="72" cy="72" r="6" fill="#1a1a1a" />
      <rect x="30" y="67" width="35" height="10" rx="2" fill="currentColor" />
      <rect x="36" y="62" width="6" height="20" rx="1" fill="currentColor" />
    </g>

    <!-- radio -->
    <g v-else-if="tool === 'radio'">
      <rect x="25" y="35" width="50" height="30" rx="15" fill="currentColor" />
      <line x1="35" y1="25" x2="35" y2="35" stroke="currentColor" stroke-width="5" />
      <circle cx="40" cy="50" r="6" fill="#1a1a1a" />
      <circle cx="60" cy="50" r="6" fill="#1a1a1a" />
      <path d="M15,50 Q10,40 15,30 M20,50 Q17,43 20,36" stroke="currentColor" stroke-width="3" fill="none" stroke-linecap="round" />
      <path d="M85,50 Q90,40 85,30 M80,50 Q83,43 80,36" stroke="currentColor" stroke-width="3" fill="none" stroke-linecap="round" />
    </g>

    <!-- link-simple -->
    <g v-else-if="tool === 'link-simple'">
      <path d="M35,30 L45,20 Q50,15 55,20 L65,30" stroke="currentColor" stroke-width="10" stroke-linecap="round" fill="none" />
      <path d="M65,70 L55,80 Q50,85 45,80 L35,70" stroke="currentColor" stroke-width="10" stroke-linecap="round" fill="none" />
      <line x1="40" y1="60" x2="60" y2="40" stroke="currentColor" stroke-width="10" stroke-linecap="round" />
    </g>

    <!-- keyboard -->
    <g v-else-if="tool === 'keyboard'">
      <rect x="12" y="32" width="76" height="36" rx="5" fill="currentColor" />
      <rect x="18" y="40" width="8" height="8" rx="1" fill="#1a1a1a" />
      <rect x="29" y="40" width="8" height="8" rx="1" fill="#1a1a1a" />
      <rect x="40" y1="40" width="8" height="8" rx="1" fill="#1a1a1a" />
      <rect x="51" y="40" width="8" height="8" rx="1" fill="#1a1a1a" />
      <rect x="62" y="40" width="8" height="8" rx="1" fill="#1a1a1a" />
      <rect x="73" y="40" width="8" height="8" rx="1" fill="#1a1a1a" />
      <rect x="28" y="52" width="44" height="8" rx="1" fill="#1a1a1a" />
    </g>

    <!-- compress -->
    <g v-else-if="tool === 'compress'">
      <rect x="20" y="20" width="60" height="60" rx="6" fill="currentColor" />
      <path d="M35,50 L45,40 L45,47 M45,40 L52,40" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
      <path d="M65,50 L55,60 L55,53 M55,60 L48,60" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
    </g>

    <!-- hash-lock -->
    <g v-else-if="tool === 'hash-lock'">
      <rect x="28" y="48" width="44" height="38" rx="5" fill="currentColor" />
      <path d="M33,48 L33,36 C33,25 42,18 50,18 C58,18 67,25 67,36 L67,48" fill="none" stroke="currentColor" stroke-width="7" />
      <text x="40" y="74" font-size="20" fill="#1a1a1a" font-weight="bold">#</text>
    </g>

    <!-- seed -->
    <g v-else-if="tool === 'seed'">
      <ellipse cx="50" cy="65" rx="20" ry="12" fill="currentColor" />
      <path d="M50,65 L50,30 Q50,20 58,18 L60,18" stroke="currentColor" stroke-width="5" fill="none" stroke-linecap="round" />
      <ellipse cx="58" cy="23" rx="8" ry="5" fill="currentColor" />
      <path d="M50,40 Q50,35 42,33" stroke="currentColor" stroke-width="4" fill="none" stroke-linecap="round" />
      <ellipse cx="42" cy="33" rx="6" ry="4" fill="currentColor" />
    </g>

    <!-- text-case -->
    <g v-else-if="tool === 'text-case'">
      <rect x="15" y="20" width="70" height="60" rx="6" fill="currentColor" />
      <text x="25" y="52" font-size="20" fill="#1a1a1a" font-weight="bold">Aa</text>
      <path d="M28,58 L45,58 M48,58 L65,58" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <text x="25" y="72" font-size="12" fill="#1a1a1a">Case</text>
    </g>

    <!-- permissions -->
    <g v-else-if="tool === 'permissions'">
      <rect x="20" y="20" width="60" height="60" rx="6" fill="currentColor" />
      <text x="25" y="52" font-size="26" fill="#1a1a1a" font-weight="bold" font-family="monospace">rwx</text>
    </g>

    <!-- timer -->
    <g v-else-if="tool === 'timer'">
      <circle cx="50" cy="52" r="34" fill="currentColor" />
      <rect x="45" y="15" width="10" height="8" rx="2" fill="currentColor" />
      <circle cx="50" cy="52" r="4" fill="#1a1a1a" />
      <line x1="50" y1="52" x2="50" y2="30" stroke="#1a1a1a" stroke-width="4" stroke-linecap="round" />
      <line x1="50" y1="52" x2="68" y2="52" stroke="#1a1a1a" stroke-width="3" stroke-linecap="round" />
      <circle cx="50" cy="52" r="28" fill="none" stroke="#1a1a1a" stroke-width="2" opacity="0.3" />
    </g>

    <!-- color-wheel -->
    <g v-else-if="tool === 'color-wheel'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <circle cx="50" cy="50" r="24" fill="#1a1a1a" />
      <path d="M50,26 L50,14 M26,50 L14,50 M50,74 L50,86 M74,50 L86,50" stroke="currentColor" stroke-width="4" stroke-linecap="round" />
      <circle cx="50" cy="14" r="5" fill="#ff0000" />
      <circle cx="14" cy="50" r="5" fill="#00ff00" />
      <circle cx="50" cy="86" r="5" fill="#0000ff" />
      <circle cx="86" cy="50" r="5" fill="#ffff00" />
    </g>

    <!-- cron -->
    <g v-else-if="tool === 'cron'">
      <circle cx="50" cy="50" r="35" fill="currentColor" />
      <text x="20" y="62" font-size="24" fill="#1a1a1a" font-weight="bold" font-family="monospace">*/5</text>
    </g>

    <!-- calendar-clock -->
    <g v-else-if="tool === 'calendar-clock'">
      <rect x="18" y="20" width="50" height="55" rx="4" fill="currentColor" />
      <rect x="18" y="20" width="50" height="15" rx="4" fill="currentColor" opacity="0.8" />
      <rect x="28" y="15" width="5" height="12" rx="2" fill="currentColor" />
      <rect x="53" y="15" width="5" height="12" rx="2" fill="currentColor" />
      <line x1="26" y1="48" x2="34" y2="48" stroke="#1a1a1a" stroke-width="2" />
      <line x1="40" y1="48" x2="48" y2="48" stroke="#1a1a1a" stroke-width="2" />
      <circle cx="72" cy="72" r="18" fill="currentColor" />
      <circle cx="72" cy="72" r="2" fill="#1a1a1a" />
      <line x1="72" y1="72" x2="72" y2="60" stroke="#1a1a1a" stroke-width="3" />
      <line x1="72" y1="72" x2="82" y2="72" stroke="#1a1a1a" stroke-width="2" />
    </g>

    <!-- device -->
    <g v-else-if="tool === 'device'">
      <rect x="25" y="15" width="50" height="70" rx="8" fill="currentColor" />
      <rect x="30" y="22" width="40" height="54" rx="3" fill="#1a1a1a" />
      <circle cx="50" cy="82" r="4" fill="#1a1a1a" />
    </g>

    <!-- padlock -->
    <g v-else-if="tool === 'padlock'">
      <rect x="28" y="50" width="44" height="38" rx="6" fill="currentColor" />
      <path d="M33,50 L33,35 C33,23 40,15 50,15 C60,15 67,23 67,35 L67,50" fill="none" stroke="currentColor" stroke-width="8" stroke-linecap="round" />
      <circle cx="50" cy="68" r="6" fill="#1a1a1a" />
      <rect x="48" y="68" width="4" height="12" rx="1" fill="#1a1a1a" />
    </g>

    <!-- hourglass -->
    <g v-else-if="tool === 'hourglass'">
      <path d="M30,15 L70,15 L65,30 L50,50 L65,70 L70,85 L30,85 L35,70 L50,50 L35,30 Z" fill="currentColor" />
      <path d="M38,25 Q50,35 62,25" fill="#1a1a1a" />
    </g>

    <!-- percentage -->
    <g v-else-if="tool === 'percentage'">
      <circle cx="32" cy="32" r="14" fill="currentColor" />
      <circle cx="68" cy="68" r="14" fill="currentColor" />
      <line x1="25" y1="75" x2="75" y2="25" stroke="currentColor" stroke-width="8" stroke-linecap="round" />
      <text x="42" y="58" font-size="24" fill="currentColor" font-weight="bold">%</text>
    </g>

    <!-- git-branch -->
    <g v-else-if="tool === 'git-branch'">
      <circle cx="25" cy="25" r="10" fill="currentColor" />
      <circle cx="25" cy="75" r="10" fill="currentColor" />
      <circle cx="75" cy="50" r="10" fill="currentColor" />
      <line x1="25" y1="35" x2="25" y2="65" stroke="currentColor" stroke-width="5" />
      <path d="M25,45 Q25,50 30,50 L65,50" stroke="currentColor" stroke-width="5" fill="none" />
    </g>

    <!-- hashtag -->
    <g v-else-if="tool === 'hashtag'">
      <text x="18" y="75" font-size="72" fill="currentColor" font-weight="bold">#</text>
    </g>

    <!-- signature -->
    <g v-else-if="tool === 'signature'">
      <rect x="15" y="20" width="70" height="60" rx="5" fill="currentColor" />
      <path d="M25,45 Q35,35 45,45 Q55,55 65,45" stroke="#1a1a1a" stroke-width="4" fill="none" stroke-linecap="round" />
      <line x1="25" y1="65" x2="75" y2="65" stroke="#1a1a1a" stroke-width="2" stroke-dasharray="3,3" />
    </g>

    <!-- html -->
    <g v-else-if="tool === 'html'">
      <path d="M20,28 L35,50 L20,72" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" stroke-linejoin="round" />
      <path d="M80,28 L65,50 L80,72" stroke="currentColor" stroke-width="7" fill="none" stroke-linecap="round" stroke-linejoin="round" />
      <line x1="45" y1="30" x2="40" y2="70" stroke="currentColor" stroke-width="6" stroke-linecap="round" />
      <line x1="55" y1="30" x2="60" y2="70" stroke="currentColor" stroke-width="6" stroke-linecap="round" />
    </g>

    <!-- base-convert -->
    <g v-else-if="tool === 'base-convert'">
      <circle cx="30" cy="50" r="22" fill="currentColor" />
      <text x="20" y="60" font-size="20" fill="#1a1a1a" font-weight="bold">10</text>
      <polygon points="50,50 60,45 60,55" fill="currentColor" />
      <circle cx="75" cy="50" r="22" fill="currentColor" />
      <text x="66" y="60" font-size="20" fill="#1a1a1a" font-weight="bold">16</text>
    </g>

    <!-- json-tree -->
    <g v-else-if="tool === 'json-tree'">
      <circle cx="50" cy="20" r="8" fill="currentColor" />
      <circle cx="30" cy="50" r="8" fill="currentColor" />
      <circle cx="70" cy="50" r="8" fill="currentColor" />
      <circle cx="20" cy="80" r="6" fill="currentColor" />
      <circle cx="40" cy="80" r="6" fill="currentColor" />
      <circle cx="60" cy="80" r="6" fill="currentColor" />
      <circle cx="80" cy="80" r="6" fill="currentColor" />
      <line x1="50" y1="28" x2="30" y2="42" stroke="currentColor" stroke-width="3" />
      <line x1="50" y1="28" x2="70" y2="42" stroke="currentColor" stroke-width="3" />
      <line x1="30" y1="58" x2="20" y2="74" stroke="currentColor" stroke-width="2" />
      <line x1="30" y1="58" x2="40" y2="74" stroke="currentColor" stroke-width="2" />
      <line x1="70" y1="58" x2="60" y2="74" stroke="currentColor" stroke-width="2" />
      <line x1="70" y1="58" x2="80" y2="74" stroke="currentColor" stroke-width="2" />
    </g>

    <!-- jwt -->
    <g v-else-if="tool === 'jwt'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="24" y="65" font-size="28" fill="#1a1a1a" font-weight="bold">JWT</text>
    </g>

    <!-- paragraph -->
    <g v-else-if="tool === 'paragraph'">
      <rect x="20" y="25" width="60" height="50" rx="4" fill="currentColor" />
      <line x1="28" y1="38" x2="72" y2="38" stroke="#1a1a1a" stroke-width="3" />
      <line x1="28" y1="48" x2="70" y2="48" stroke="#1a1a1a" stroke-width="3" />
      <line x1="28" y1="58" x2="72" y2="58" stroke="#1a1a1a" stroke-width="3" />
      <line x1="28" y1="68" x2="55" y2="68" stroke="#1a1a1a" stroke-width="3" />
    </g>

    <!-- function -->
    <g v-else-if="tool === 'function'">
      <circle cx="50" cy="50" r="35" fill="currentColor" />
      <text x="32" y="68" font-size="36" fill="#1a1a1a" font-weight="bold" font-style="italic">f(x)</text>
    </g>

    <!-- meta -->
    <g v-else-if="tool === 'meta'">
      <rect x="20" y="25" width="60" height="50" rx="5" fill="currentColor" />
      <path d="M30,35 L40,35 L40,45 L30,45 Z M50,35 L60,35 L60,45 L50,45 Z M30,55 L60,55 L60,65 L30,65 Z" fill="#1a1a1a" />
      <text x="25" y="20" font-size="10" fill="currentColor" font-weight="bold">META</text>
    </g>

    <!-- file-type -->
    <g v-else-if="tool === 'file-type'">
      <path d="M25,10 L60,10 L75,25 L75,90 L25,90 Z" fill="currentColor" />
      <path d="M60,10 L60,25 L75,25" fill="#1a1a1a" />
      <text x="35" y="62" font-size="20" fill="#1a1a1a" font-weight="bold">.txt</text>
    </g>

    <!-- otp -->
    <g v-else-if="tool === 'otp'">
      <rect x="20" y="30" width="60" height="40" rx="5" fill="currentColor" />
      <text x="28" y="62" font-size="32" fill="#1a1a1a" font-weight="bold" font-family="monospace">123</text>
    </g>

    <!-- qr -->
    <g v-else-if="tool === 'qr'">
      <rect x="15" y="15" width="28" height="28" rx="3" fill="currentColor" />
      <rect x="57" y="15" width="28" height="28" rx="3" fill="currentColor" />
      <rect x="15" y="57" width="28" height="28" rx="3" fill="currentColor" />
      <rect x="21" y="21" width="16" height="16" rx="2" fill="#1a1a1a" />
      <rect x="63" y="21" width="16" height="16" rx="2" fill="#1a1a1a" />
      <rect x="21" y="63" width="16" height="16" rx="2" fill="#1a1a1a" />
      <rect x="57" y="57" width="12" height="12" fill="currentColor" />
      <rect x="73" y="57" width="12" height="12" fill="currentColor" />
      <rect x="57" y="73" width="12" height="12" fill="currentColor" />
      <rect x="73" y="73" width="12" height="12" fill="currentColor" />
    </g>

    <!-- wifi-qr -->
    <g v-else-if="tool === 'wifi-qr'">
      <rect x="18" y="18" width="24" height="24" rx="2" fill="currentColor" />
      <rect x="58" y="58" width="24" height="24" rx="2" fill="currentColor" />
      <rect x="22" y="22" width="16" height="16" fill="#1a1a1a" />
      <rect x="62" y="62" width="16" height="16" fill="#1a1a1a" />
      <path d="M50,75 M35,60 Q50,45 65,60 M25,50 Q50,30 75,50" stroke="currentColor" stroke-width="5" fill="none" stroke-linecap="round" />
      <circle cx="50" cy="82" r="4" fill="currentColor" />
    </g>

    <!-- port -->
    <g v-else-if="tool === 'port'">
      <rect x="25" y="35" width="50" height="30" rx="4" fill="currentColor" />
      <circle cx="40" cy="50" r="6" fill="#1a1a1a" />
      <circle cx="60" cy="50" r="6" fill="#1a1a1a" />
      <text x="28" y="28" font-size="14" fill="currentColor" font-weight="bold">:8080</text>
    </g>

    <!-- roman -->
    <g v-else-if="tool === 'roman'">
      <text x="18" y="70" font-size="56" fill="currentColor" font-weight="bold" font-family="serif">XII</text>
    </g>

    <!-- sql -->
    <g v-else-if="tool === 'sql'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="26" y="65" font-size="28" fill="#1a1a1a" font-weight="bold">SQL</text>
    </g>

    <!-- svg -->
    <g v-else-if="tool === 'svg'">
      <circle cx="50" cy="50" r="36" fill="currentColor" />
      <text x="26" y="65" font-size="28" fill="#1a1a1a" font-weight="bold">SVG</text>
    </g>

    <!-- thermometer -->
    <g v-else-if="tool === 'thermometer'">
      <rect x="42" y="20" width="16" height="50" rx="8" fill="currentColor" />
      <circle cx="50" cy="78" r="15" fill="currentColor" />
      <rect x="46" y="50" width="8" height="28" fill="#ff0000" />
      <circle cx="50" cy="78" r="10" fill="#ff0000" />
      <line x1="60" y1="35" x2="68" y2="35" stroke="currentColor" stroke-width="2" />
      <line x1="60" y1="45" x2="68" y2="45" stroke="currentColor" stroke-width="2" />
      <line x1="60" y1="55" x2="68" y2="55" stroke="currentColor" stroke-width="2" />
    </g>

    <!-- stats -->
    <g v-else-if="tool === 'stats'">
      <rect x="15" y="15" width="70" height="70" rx="5" fill="currentColor" />
      <rect x="22" y="60" width="10" height="20" fill="#1a1a1a" />
      <rect x="35" y="48" width="10" height="32" fill="#1a1a1a" />
      <rect x="48" y="35" width="10" height="45" fill="#1a1a1a" />
      <rect x="61" y="52" width="10" height="28" fill="#1a1a1a" />
      <path d="M27,55 L40,43 L53,30 L66,47" stroke="#ff0000" stroke-width="3" fill="none" />
    </g>

    <!-- token -->
    <g v-else-if="tool === 'token'">
      <circle cx="50" cy="50" r="35" fill="currentColor" />
      <text x="26" y="62" font-size="20" fill="#1a1a1a" font-weight="bold">TOK</text>
      <path d="M50,20 L50,80 M20,50 L80,50" stroke="#1a1a1a" stroke-width="2" opacity="0.3" />
    </g>

    <!-- url-encode -->
    <g v-else-if="tool === 'url-encode'">
      <rect x="15" y="30" width="70" height="40" rx="5" fill="currentColor" />
      <text x="22" y="58" font-size="18" fill="#1a1a1a" font-weight="bold" font-family="monospace">%20</text>
    </g>

    <!-- url-parse -->
    <g v-else-if="tool === 'url-parse'">
      <rect x="12" y="28" width="76" height="44" rx="5" fill="currentColor" />
      <line x1="20" y1="45" x2="80" y2="45" stroke="#1a1a1a" stroke-width="2" />
      <line x1="20" y1="60" x2="70" y2="60" stroke="#1a1a1a" stroke-width="2" />
      <circle cx="24" cy="38" r="3" fill="#1a1a1a" />
      <circle cx="35" cy="38" r="3" fill="#1a1a1a" />
      <circle cx="46" cy="38" r="3" fill="#1a1a1a" />
    </g>

    <!-- uuid -->
    <g v-else-if="tool === 'uuid'">
      <rect x="15" y="30" width="70" height="40" rx="5" fill="currentColor" />
      <text x="18" y="55" font-size="12" fill="#1a1a1a" font-weight="bold" font-family="monospace">abc-123</text>
    </g>

    <!-- mac-lookup -->
    <g v-else-if="tool === 'mac-lookup'">
      <circle cx="50" cy="50" r="30" fill="none" stroke="currentColor" stroke-width="8" />
      <circle cx="50" cy="50" r="18" fill="none" stroke="currentColor" stroke-width="6" />
      <line x1="56" y1="56" x2="75" y2="75" stroke="currentColor" stroke-width="10" stroke-linecap="round" />
      <text x="32" y="54" font-size="12" fill="currentColor" font-weight="bold">MAC</text>
    </g>

    <!-- xml -->
    <g v-else-if="tool === 'xml'">
      <path d="M15,28 L30,50 L15,72" stroke="currentColor" stroke-width="8" fill="none" stroke-linecap="round" />
      <path d="M85,28 L70,50 L85,72" stroke="currentColor" stroke-width="8" fill="none" stroke-linecap="round" />
      <text x="38" y="62" font-size="20" fill="currentColor" font-weight="bold">xml</text>
    </g>

    <!-- yaml -->
    <g v-else-if="tool === 'yaml'">
      <rect x="20" y="25" width="60" height="50" rx="5" fill="currentColor" />
      <text x="26" y="60" font-size="24" fill="#1a1a1a" font-weight="bold">YAML</text>
    </g>

    <!-- wrench (fallback) -->
    <g v-else-if="tool === 'wrench'">
      <path
        d="M85,25 C85,20 82,15 77,13 L65,25 L60,20 L72,8 C70,5 67,3 63,3 C55,3 48,10 48,18 C48,20 48.5,22 49,24 L10,63 L5,68 L5,75 L10,80 L17,80 L22,75 L25,72 L30,77 L35,82 L42,82 L47,77 L42,72 L76,38 C78,38.5 80,39 82,39 C90,39 97,32 97,24 C97,20 95,16 92,13 L80,25 L75,20 L87,8 C85,6 83,5 80,5 L85,25 Z"
        fill="currentColor"
      />
    </g>

    <!-- Default tool icon -->
    <g v-else>
      <rect x="20" y="20" width="60" height="60" rx="8" fill="currentColor" />
      <path d="M35,40 L65,40 M35,50 L65,50 M35,60 L65,60" stroke="#2d2d2d" stroke-width="4" stroke-linecap="round" />
    </g>
  </svg>
</template>

<style scoped lang="less">
.tool-silhouette {
  transition: all 0.3s ease;
}
</style>
