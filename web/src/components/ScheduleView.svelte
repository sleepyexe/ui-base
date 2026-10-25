<script lang="ts">
  import { Switch } from '$lib/components/ui/switch';
  import { Card, CardContent } from '$lib/components/ui/card';
  import { Badge } from '$lib/components/ui/badge';
  import { Slider } from '$lib/components/ui/slider';
  import WeatherIcons from './icons/WeatherIcons.svelte';
  import { fetchNui } from '../utils/fetchNui';

  let autoCycle = $state(true);
  let cycleInterval = $state(30);
  let transitionDuration = $state(15);

  const forecastQueue = [
    { time: 'Current', weather: 'Clear', temp: '32°', icon: 'clear', status: 'Active' },
    { time: '+30 Min', weather: 'Cloudy', temp: '28°', icon: 'cloudy', status: 'Queued' },
    { time: '+60 Min', weather: 'Overcast', temp: '24°', icon: 'overcast', status: 'Queued' },
    { time: '+90 Min', weather: 'Rain', temp: '20°', icon: 'rain', status: 'Queued' },
  ];

  function toggleAutoCycle(val: boolean) {
    autoCycle = val;
    fetchNui('toggleAutoWeatherCycle', { enabled: val, interval: cycleInterval }).catch(() => {});
  }

  function handleIntervalChange(val: number) {
    cycleInterval = val;
    fetchNui('toggleAutoWeatherCycle', { enabled: autoCycle, interval: val }).catch(() => {});
  }

  function handleDurationChange(val: number) {
    transitionDuration = val;
    fetchNui('setWeatherTransitionDuration', { duration: val }).catch(() => {});
  }
</script>

<div class="space-y-6">
  <section aria-labelledby="schedule-heading">
    <h2 id="schedule-heading" class="text-xl font-bold tracking-tight text-white">
      Weather Scheduling
    </h2>
    <p class="text-xs text-neutral-400">Automate dynamic meteorological transitions.</p>

    <div class="mt-3 grid grid-cols-2 gap-4">
      <Card class="rounded-2xl border-white/[0.06] bg-[#161922]/90 backdrop-blur-xs shadow-xs">
        <CardContent class="p-5">
          <div class="flex items-center justify-between">
            <span class="text-sm font-semibold text-white">Dynamic Weather Cycle</span>
            <div class="flex items-center gap-3">
              <span class="text-xs {autoCycle ? 'text-white' : 'text-neutral-500'}">
                {autoCycle ? 'Enabled' : 'Disabled'}
              </span>
              <Switch checked={autoCycle} onCheckedChange={toggleAutoCycle} />
            </div>
          </div>

          <div class="mt-5 space-y-4">
            <div>
              <div class="flex justify-between text-xs text-neutral-400 mb-2">
                <span>Cycle Interval</span>
                <span class="text-white font-medium">{cycleInterval} mins</span>
              </div>
              <Slider
                type="single"
                min={5}
                max={60}
                step={5}
                bind:value={cycleInterval}
                onValueChange={handleIntervalChange}
                class="py-1 cursor-pointer"
              />
            </div>

            <div>
              <div class="flex justify-between text-xs text-neutral-400 mb-2">
                <span>Transition Smoothing Duration</span>
                <span class="text-white font-medium">{transitionDuration} seconds</span>
              </div>
              <Slider
                type="single"
                min={5}
                max={60}
                step={5}
                bind:value={transitionDuration}
                onValueChange={handleDurationChange}
                class="py-1 cursor-pointer"
              />
            </div>
          </div>
        </CardContent>
      </Card>

      <Card class="rounded-2xl border-white/[0.06] bg-[#161922]/90 backdrop-blur-xs shadow-xs">
        <CardContent class="p-5">
          <div class="flex items-center justify-between mb-3">
            <span class="text-sm font-semibold text-white">Forecast Queue</span>
            <Badge variant="outline" class="border-white/10 text-neutral-400 text-xs">
              4 Stages
            </Badge>
          </div>

          <div class="space-y-2">
            {#each forecastQueue as stage}
              <div
                class="flex items-center justify-between rounded-xl border border-white/[0.04] bg-[#11131a] px-3.5 py-2"
              >
                <div class="flex items-center gap-3">
                  <div class="text-neutral-300">
                    <WeatherIcons name={stage.icon} className="h-4 w-4" />
                  </div>
                  <div>
                    <span class="text-xs font-semibold text-white">{stage.weather}</span>
                    <span class="ml-2 text-[10px] text-neutral-400">{stage.time}</span>
                  </div>
                </div>

                <div class="flex items-center gap-2">
                  <span class="text-xs font-mono text-neutral-300">{stage.temp}</span>
                  <Badge
                    variant={stage.status === 'Active' ? 'default' : 'secondary'}
                    class="rounded-md px-1.5 py-0.5 text-[10px] font-medium {stage.status === 'Active'
                      ? 'bg-amber-400/10 text-amber-400 hover:bg-amber-400/20'
                      : 'bg-white/5 text-neutral-400'}"
                  >
                    {stage.status}
                  </Badge>
                </div>
              </div>
            {/each}
          </div>
        </CardContent>
      </Card>
    </div>
  </section>
</div>
