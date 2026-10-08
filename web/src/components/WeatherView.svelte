<script lang="ts">
  import type { EnvironmentalData, WeatherManagerSettings, WeatherTypeItem } from '../types';
  import Switch from './Switch.svelte';
  import WeatherIcons from './icons/WeatherIcons.svelte';
  import { fetchNui } from '../utils/fetchNui';

  let {
    environmentalData = $bindable(),
    managerSettings = $bindable(),
    selectedWeather = $bindable('CLEAR'),
  }: {
    environmentalData: EnvironmentalData;
    managerSettings: WeatherManagerSettings;
    selectedWeather: string;
  } = $props();

  const weatherTypes: WeatherTypeItem[] = [
    { id: 'CLEAR', name: 'Clear', category: 'Weather', icon: 'clear' },
    { id: 'CLOUDS', name: 'Cloudy', category: 'Weather', icon: 'cloudy' },
    { id: 'EXTRASUNNY', name: 'Extra Sunny', category: 'Weather', icon: 'extrasunny' },
    { id: 'OVERCAST', name: 'Overcast', category: 'Weather', icon: 'overcast' },
    { id: 'RAIN', name: 'Rain', category: 'Weather', icon: 'rain' },
    { id: 'XMAS', name: 'Snow', category: 'Weather', icon: 'snow' },
    { id: 'THUNDER', name: 'Thunder', category: 'Weather', icon: 'thunder' },
    { id: 'FOGGY', name: 'Foggy', category: 'Weather', icon: 'foggy' },
  ];

  function handleSelectWeather(id: string) {
    selectedWeather = id;
    fetchNui('setWeather', {
      weather: id,
      instant: managerSettings.instantChange,
    }).catch(() => {});
  }

  function handleToggleFreeze(val: boolean) {
    managerSettings.freezeWeather = val;
    fetchNui('toggleFreezeWeather', { freeze: val }).catch(() => {});
  }

  function handleToggleInstant(val: boolean) {
    managerSettings.instantChange = val;
    fetchNui('toggleInstantChange', { instant: val }).catch(() => {});
  }

  function handleToggleBlackout(val: boolean) {
    managerSettings.enableBlackout = val;
    fetchNui('toggleBlackout', { blackout: val }).catch(() => {});
  }

  function handleToggleSnow(val: boolean) {
    managerSettings.forceSnow = val;
    fetchNui('toggleSnow', { snow: val }).catch(() => {});
  }

  function handleReset() {
    managerSettings.freezeWeather = false;
    managerSettings.instantChange = false;
    managerSettings.enableBlackout = false;
    managerSettings.forceSnow = false;
    selectedWeather = 'CLEAR';
    fetchNui('resetWeatherSettings').catch(() => {});
  }
</script>

<div class="space-y-6">
  <section aria-labelledby="forecast-heading">
    <h2 id="forecast-heading" class="text-xl font-bold tracking-tight text-white">Forecast</h2>
    <p class="text-xs text-neutral-400">Lorem ipsum dolor sit amet consectetur.</p>

    <div class="mt-3 grid grid-cols-2 gap-4">
      <div class="rounded-2xl border border-white/10 bg-[#161922]/90 p-5 backdrop-blur-sm shadow-sm">
        <div class="flex items-center justify-between text-xs text-neutral-400">
          <span>{environmentalData.dayName}</span>
          <span>{environmentalData.currentTime}</span>
        </div>

        <div class="my-4 flex items-center justify-between">
          <span class="text-5xl font-bold tracking-tight text-white">
            {environmentalData.temperature}&deg;
          </span>
          <div class="text-white">
            <WeatherIcons name="moon" className="h-10 w-10" />
          </div>
        </div>

        <div class="space-y-1.5 pt-2 text-xs">
          <div class="flex items-center justify-between">
            <span class="text-neutral-400">Feels Like</span>
            <span class="font-medium text-white">{environmentalData.feelsLike}&deg;</span>
          </div>
          <div class="flex items-center justify-between">
            <span class="text-neutral-400">Wind Percentage</span>
            <span class="font-medium text-white">{environmentalData.windPercentage}%</span>
          </div>
          <div class="flex items-center justify-between">
            <span class="text-neutral-400">Humidity</span>
            <span class="font-medium text-white">{environmentalData.humidity}%</span>
          </div>
        </div>
      </div>

      <div class="rounded-2xl border border-white/10 bg-[#161922]/90 p-5 backdrop-blur-sm shadow-sm">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-2 text-sm font-semibold text-white">
            <svg
              class="h-4 w-4 text-neutral-300"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path
                d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z"
              />
              <circle cx="12" cy="12" r="3" />
            </svg>
            <span>Manager</span>
          </div>
          <button
            type="button"
            onclick={handleReset}
            class="text-xs text-neutral-400 transition hover:text-white"
          >
            Reset
          </button>
        </div>

        <div class="mt-4 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-xs text-white">Freeze Weather</span>
            <div class="flex items-center gap-3">
              <span class="text-xs {managerSettings.freezeWeather ? 'text-white' : 'text-neutral-500'}">
                {managerSettings.freezeWeather ? 'Enabled' : 'Disabled'}
              </span>
              <Switch
                checked={managerSettings.freezeWeather}
                onchange={handleToggleFreeze}
              />
            </div>
          </div>

          <div class="flex items-center justify-between">
            <span class="text-xs text-white">Instant Change</span>
            <div class="flex items-center gap-3">
              <span class="text-xs {managerSettings.instantChange ? 'text-white' : 'text-neutral-500'}">
                {managerSettings.instantChange ? 'Enabled' : 'Disabled'}
              </span>
              <Switch
                checked={managerSettings.instantChange}
                onchange={handleToggleInstant}
              />
            </div>
          </div>

          <div class="flex items-center justify-between">
            <span class="text-xs text-white">Enable Blackout</span>
            <div class="flex items-center gap-3">
              <span class="text-xs {managerSettings.enableBlackout ? 'text-white' : 'text-neutral-500'}">
                {managerSettings.enableBlackout ? 'Enabled' : 'Disabled'}
              </span>
              <Switch
                checked={managerSettings.enableBlackout}
                onchange={handleToggleBlackout}
              />
            </div>
          </div>

          <div class="flex items-center justify-between">
            <span class="text-xs text-white">Force Snow on Ground</span>
            <div class="flex items-center gap-3">
              <span class="text-xs {managerSettings.forceSnow ? 'text-white' : 'text-neutral-500'}">
                {managerSettings.forceSnow ? 'Enabled' : 'Disabled'}
              </span>
              <Switch
                checked={managerSettings.forceSnow}
                onchange={handleToggleSnow}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section aria-labelledby="weather-control-heading">
    <h2 id="weather-control-heading" class="text-xl font-bold tracking-tight text-white">
      Weather Control
    </h2>
    <p class="text-xs text-neutral-400">Lorem ipsum dolor sit amet consectetur.</p>

    <div class="mt-3 grid grid-cols-4 gap-3.5">
      {#each weatherTypes as item (item.id)}
        {@const isSelected = selectedWeather === item.id}
        <button
          type="button"
          onclick={() => handleSelectWeather(item.id)}
          class="group relative flex h-24 flex-col justify-between rounded-2xl border p-3.5 text-left transition-all duration-150 {isSelected
            ? 'border-white/40 bg-[#1e2330] shadow-md ring-1 ring-white/20'
            : 'border-white/10 bg-[#161922]/90 hover:border-white/25 hover:bg-[#1b1f2b]'}"
        >
          <div class="self-end text-white">
            <WeatherIcons name={item.icon} className="h-7 w-7" />
          </div>

          <div>
            <span class="block text-[10px] uppercase tracking-wider text-neutral-500">
              {item.category}
            </span>
            <span class="block text-xs font-semibold text-white">
              {item.name}
            </span>
          </div>
        </button>
      {/each}
    </div>
  </section>
</div>
