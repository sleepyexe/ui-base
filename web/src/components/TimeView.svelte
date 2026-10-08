<script lang="ts">
  import type { TimeSettings } from '../types';
  import Switch from './Switch.svelte';
  import { fetchNui } from '../utils/fetchNui';

  let {
    timeSettings = $bindable(),
    onApply,
  }: {
    timeSettings: TimeSettings;
    onApply?: () => void;
  } = $props();

  const presets = [
    { label: 'Morning', hours: 8, minutes: 0 },
    { label: 'Noon', hours: 12, minutes: 0 },
    { label: 'Sunset', hours: 19, minutes: 30 },
    { label: 'Midnight', hours: 0, minutes: 0 },
  ];

  function applyPreset(h: number, m: number) {
    timeSettings.hours = h;
    timeSettings.minutes = m;
    fetchNui('setTime', { hours: h, minutes: m }).catch(() => {});
    onApply?.();
  }

  function handleSliderChange() {
    fetchNui('setTime', {
      hours: timeSettings.hours,
      minutes: timeSettings.minutes,
    }).catch(() => {});
    onApply?.();
  }

  function toggleFreeze(val: boolean) {
    timeSettings.freezeTime = val;
    fetchNui('toggleFreezeTime', { freeze: val }).catch(() => {});
  }

  function setScale(scale: number) {
    timeSettings.timeScale = scale;
    fetchNui('setTimeScale', { scale }).catch(() => {});
  }
</script>

<div class="space-y-6">
  <section aria-labelledby="time-control-heading">
    <h2 id="time-control-heading" class="text-xl font-bold tracking-tight text-white">
      Time Control
    </h2>
    <p class="text-xs text-neutral-400">Synchronize in-game world clock and cycle rate.</p>

    <div class="mt-3 grid grid-cols-2 gap-4">
      <div class="rounded-2xl border border-white/[0.06] bg-[#161922]/90 p-5 backdrop-blur-sm">
        <div class="flex items-center justify-between text-xs text-neutral-400">
          <span>Active Clock</span>
          <span>{timeSettings.hours < 12 ? 'AM' : 'PM'}</span>
        </div>

        <div class="my-4 text-center">
          <span class="font-mono text-5xl font-bold tracking-tight text-white">
            {String(timeSettings.hours).padStart(2, '0')}:{String(timeSettings.minutes).padStart(2, '0')}
          </span>
        </div>

        <div class="space-y-3 pt-1">
          <div>
            <div class="flex justify-between text-xs text-neutral-400 mb-1">
              <span>Hours</span>
              <span class="text-white font-mono">{timeSettings.hours}</span>
            </div>
            <input
              type="range"
              min="0"
              max="23"
              bind:value={timeSettings.hours}
              oninput={handleSliderChange}
              class="w-full accent-amber-400 cursor-pointer h-1.5 bg-neutral-700 rounded-lg appearance-none"
            />
          </div>

          <div>
            <div class="flex justify-between text-xs text-neutral-400 mb-1">
              <span>Minutes</span>
              <span class="text-white font-mono">{timeSettings.minutes}</span>
            </div>
            <input
              type="range"
              min="0"
              max="59"
              bind:value={timeSettings.minutes}
              oninput={handleSliderChange}
              class="w-full accent-amber-400 cursor-pointer h-1.5 bg-neutral-700 rounded-lg appearance-none"
            />
          </div>
        </div>
      </div>

      <div class="rounded-2xl border border-white/[0.06] bg-[#161922]/90 p-5 backdrop-blur-sm">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-2 text-sm font-semibold text-white">
            <svg class="h-4 w-4 text-neutral-300" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10" />
              <polyline points="12 6 12 12 16 14" />
            </svg>
            <span>Time Manager</span>
          </div>
        </div>

        <div class="mt-4 space-y-4">
          <div class="flex items-center justify-between">
            <span class="text-xs text-white">Freeze Time</span>
            <div class="flex items-center gap-3">
              <span class="text-xs {timeSettings.freezeTime ? 'text-white' : 'text-neutral-500'}">
                {timeSettings.freezeTime ? 'Enabled' : 'Disabled'}
              </span>
              <Switch checked={timeSettings.freezeTime} onchange={toggleFreeze} />
            </div>
          </div>

          <div>
            <span class="block text-xs text-white mb-2">Cycle Speed Multiplier</span>
            <div class="grid grid-cols-4 gap-2">
              {#each [1, 2, 5, 10] as scale}
                <button
                  type="button"
                  onclick={() => setScale(scale)}
                  class="rounded-xl border py-1.5 text-xs font-medium transition {timeSettings.timeScale === scale
                    ? 'border-white/30 bg-[#1e2330] text-white'
                    : 'border-white/[0.06] bg-[#12141c] text-neutral-400 hover:text-white'}"
                >
                  {scale}x
                </button>
              {/each}
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section aria-labelledby="time-presets-heading">
    <h2 id="time-presets-heading" class="text-xl font-bold tracking-tight text-white">
      Quick Presets
    </h2>
    <p class="text-xs text-neutral-400">Instantly snap the server to typical daily phases.</p>

    <div class="mt-3 grid grid-cols-4 gap-3.5">
      {#each presets as p}
        <button
          type="button"
          onclick={() => applyPreset(p.hours, p.minutes)}
          class="flex flex-col justify-between rounded-2xl border border-white/[0.06] bg-[#161922]/90 p-4 text-left transition hover:border-white/20 hover:bg-[#1b1f2b]"
        >
          <span class="text-[10px] uppercase tracking-wider text-neutral-500">Preset</span>
          <span class="text-sm font-semibold text-white">{p.label}</span>
          <span class="font-mono text-xs text-neutral-400">
            {String(p.hours).padStart(2, '0')}:{String(p.minutes).padStart(2, '0')}
          </span>
        </button>
      {/each}
    </div>
  </section>
</div>
