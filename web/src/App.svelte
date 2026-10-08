<script lang="ts">
  import { onMount } from "svelte";
  import type {
    EnvironmentalData,
    TabType,
    TimeSettings,
    WeatherManagerSettings,
  } from "./types";
  import Sidebar from "./components/Sidebar.svelte";
  import HeaderBar from "./components/HeaderBar.svelte";
  import WeatherView from "./components/WeatherView.svelte";
  import TimeView from "./components/TimeView.svelte";
  import ScheduleView from "./components/ScheduleView.svelte";
  import { fetchNui } from "./utils/fetchNui";
  import { useNuiEvent } from "./utils/useNuiEvent";
  import { isEnvBrowser } from "./utils/misc";

  let visible = $state(true);
  let activeTab = $state<TabType>("weather");
  let selectedWeather = $state("CLEAR");

  let environmentalData = $state<EnvironmentalData>({
    temperature: 32,
    feelsLike: 28,
    windPercentage: 44,
    humidity: 12,
    currentWeather: "CLEAR",
    dayName: "Tuesday",
    currentTime: "12:21 PM",
    locationName: "Ocean Hwy",
    currentDate: "Tuesday, September 10th",
  });

  let managerSettings = $state<WeatherManagerSettings>({
    freezeWeather: true,
    instantChange: false,
    enableBlackout: false,
    forceSnow: true,
  });

  let timeSettings = $state<TimeSettings>({
    hours: 12,
    minutes: 21,
    freezeTime: false,
    timeScale: 1,
  });

  let isNightBg = $state(false);

  function handleClose() {
    visible = false;
    fetchNui("close").catch(() => {});
  }

  function handleKeyDown(event: KeyboardEvent) {
    if (event.key === "Escape") {
      handleClose();
    }
  }

  function toggleBrowserBackground() {
    isNightBg = !isNightBg;
    const root = document.getElementById("app");
    if (root) {
      root.style.backgroundImage = `url("background/${isNightBg ? "night" : "day"}.png")`;
    }
  }

  useNuiEvent<boolean>("setVisible", (state) => {
    visible = state;
  });

  useNuiEvent<Partial<EnvironmentalData>>("updateEnvironment", (data) => {
    environmentalData = { ...environmentalData, ...data };
  });

  useNuiEvent<Partial<WeatherManagerSettings>>(
    "updateManagerSettings",
    (data) => {
      managerSettings = { ...managerSettings, ...data };
    },
  );

  useNuiEvent<Partial<TimeSettings>>("updateTimeSettings", (data) => {
    timeSettings = { ...timeSettings, ...data };
  });

  onMount(() => {
    window.addEventListener("keydown", handleKeyDown);
    return () => {
      window.removeEventListener("keydown", handleKeyDown);
    };
  });
</script>

{#if visible}
  <main
    class="fixed inset-0 flex items-center justify-center p-6 select-none font-sans"
  >
    <div
      class="relative flex h-[640px] w-full max-w-[1020px] overflow-hidden rounded-[28px] border border-white/[0.08] bg-[#12141a]/95 shadow-[0_25px_60px_-15px_rgba(0,0,0,0.85)] backdrop-blur-2xl"
    >
      <div
        class="pointer-events-none absolute inset-x-0 top-0 h-48 bg-[radial-gradient(ellipse_70%_40%_at_50%_0%,rgba(38,70,83,0.35),transparent_75%)]"
      ></div>

      <Sidebar
        bind:activeTab
        locationName={environmentalData.locationName}
        currentDate={environmentalData.currentDate}
      />

      <section class="flex flex-1 flex-col p-7 min-w-0">
        <HeaderBar
          {activeTab}
          currentTime={environmentalData.currentTime}
          onClose={handleClose}
        />

        <div class="flex-1 overflow-y-auto pr-1">
          {#if activeTab === "weather"}
            <WeatherView
              bind:environmentalData
              bind:managerSettings
              bind:selectedWeather
            />
          {:else if activeTab === "time"}
            <TimeView bind:timeSettings />
          {:else if activeTab === "schedule"}
            <ScheduleView />
          {/if}
        </div>
      </section>
    </div>
  </main>
{/if}

{#if isEnvBrowser()}
  <div class="fixed bottom-4 left-4 z-50 flex items-center gap-2">
    {#if !visible}
      <button
        type="button"
        onclick={() => (visible = true)}
        class="rounded-xl border border-white/10 bg-[#161922] px-3.5 py-1.5 text-xs font-semibold text-white shadow hover:bg-[#1e2330]"
      >
        Open Tablet
      </button>
    {/if}
    <button
      type="button"
      onclick={toggleBrowserBackground}
      class="rounded-xl border border-white/10 bg-[#161922]/80 px-3 py-1.5 text-xs text-neutral-300 backdrop-blur hover:text-white"
    >
      Toggle Background ({isNightBg ? "Night" : "Day"})
    </button>
  </div>
{/if}
