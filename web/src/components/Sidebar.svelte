<script lang="ts">
  import type { TabType } from '../types';
  import WeatherIcons from './icons/WeatherIcons.svelte';
  import { Button } from '$lib/components/ui/button';
  import { Separator } from '$lib/components/ui/separator';

  let {
    activeTab = $bindable('weather'),
    locationName = 'Ocean Hwy',
    currentDate = 'Tuesday, September 10th',
    onTabSelect,
  }: {
    activeTab: TabType;
    locationName?: string;
    currentDate?: string;
    onTabSelect?: (tab: TabType) => void;
  } = $props();

  function selectTab(tab: TabType) {
    activeTab = tab;
    onTabSelect?.(tab);
  }
</script>

<aside class="flex w-64 flex-col justify-between border-r border-white/[0.06] p-7">
  <div>
    <div class="flex items-center gap-3">
      <div class="text-amber-400">
        <WeatherIcons name="climatime-logo" className="h-7 w-7" />
      </div>
      <h1 class="text-2xl font-bold tracking-tight text-white">Climatime</h1>
    </div>

    <nav class="mt-8 flex flex-col gap-1.5" aria-label="Tablet navigation">
      <Button
        variant={activeTab === 'weather' ? 'secondary' : 'ghost'}
        onclick={() => selectTab('weather')}
        class="w-full justify-start gap-3.5 rounded-xl px-4 py-2.5 text-sm font-medium transition-colors {activeTab ===
        'weather'
          ? 'bg-[#1e232e] text-white shadow-xs'
          : 'text-neutral-400 hover:bg-white/[0.04] hover:text-white'}"
      >
        <svg
          class="h-4 w-4 shrink-0"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z" />
        </svg>
        <span>Weather</span>
      </Button>

      <Button
        variant={activeTab === 'time' ? 'secondary' : 'ghost'}
        onclick={() => selectTab('time')}
        class="w-full justify-start gap-3.5 rounded-xl px-4 py-2.5 text-sm font-medium transition-colors {activeTab ===
        'time'
          ? 'bg-[#1e232e] text-white shadow-xs'
          : 'text-neutral-400 hover:bg-white/[0.04] hover:text-white'}"
      >
        <svg
          class="h-4 w-4 shrink-0"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <circle cx="12" cy="12" r="10" />
          <polyline points="12 6 12 12 16 14" />
        </svg>
        <span>Time</span>
      </Button>

      <Button
        variant={activeTab === 'schedule' ? 'secondary' : 'ghost'}
        onclick={() => selectTab('schedule')}
        class="w-full justify-start gap-3.5 rounded-xl px-4 py-2.5 text-sm font-medium transition-colors {activeTab ===
        'schedule'
          ? 'bg-[#1e232e] text-white shadow-xs'
          : 'text-neutral-400 hover:bg-white/[0.04] hover:text-white'}"
      >
        <svg
          class="h-4 w-4 shrink-0"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <rect width="18" height="18" x="3" y="4" rx="2" ry="2" />
          <line x1="16" y1="2" x2="16" y2="6" />
          <line x1="8" y1="2" x2="8" y2="6" />
          <line x1="3" y1="10" x2="21" y2="10" />
        </svg>
        <span>Schedule</span>
      </Button>
    </nav>
  </div>

  <div>
    <Separator class="mb-5 bg-white/[0.06]" />
    <div class="flex items-center gap-3">
      <div
        class="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-white/[0.04] text-neutral-400"
      >
        <svg
          class="h-4 w-4"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z" />
          <circle cx="12" cy="10" r="3" />
        </svg>
      </div>
      <div class="min-w-0">
        <p class="truncate text-sm font-semibold text-white">{locationName}</p>
        <p class="truncate text-xs text-neutral-400">{currentDate}</p>
      </div>
    </div>
  </div>
</aside>
