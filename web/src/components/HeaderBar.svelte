<script lang="ts">
  import type { TabType } from "../types";

  let {
    activeTab = "weather",
    currentTime = "12:21 PM",
    onClose,
  }: {
    activeTab: TabType;
    currentTime?: string;
    onClose?: () => void;
  } = $props();

  const tabLabels: Record<TabType, string> = {
    weather: "Weather",
    time: "Time",
    schedule: "Schedule",
  };
</script>

<header class="flex items-center justify-between pb-4">
  <div class="flex items-center gap-2 text-xs font-medium text-neutral-400">
    <span>Climatime</span>
    <span class="text-neutral-600">&gt;</span>
    <span class="text-neutral-300">{tabLabels[activeTab]}</span>
  </div>

  <div class="flex items-center gap-5">
    {#if onClose}
      <button
        type="button"
        onclick={onClose}
        aria-label="Close tablet"
        title="Close Tablet (ESC)"
        class="flex h-6 w-6 items-center justify-center rounded-lg text-neutral-400 transition hover:bg-white/10 hover:text-white"
      >
        <svg
          class="h-3.5 w-3.5"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <line x1="18" y1="6" x2="6" y2="18" />
          <line x1="6" y1="6" x2="18" y2="18" />
        </svg>
      </button>
    {/if}
  </div>
</header>
