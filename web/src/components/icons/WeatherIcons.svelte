<script lang="ts">
  let { name, className = 'w-6 h-6' }: { name: string; className?: string } = $props();
</script>

{#if name === 'clear'}
  <svg class={className} viewBox="0 0 24 24" fill="currentColor">
    <circle cx="12" cy="12" r="4.5" />
    <path
      d="M12 2v2.5M12 19.5V22M2 12h2.5M19.5 12H22M4.93 4.93l1.77 1.77M17.3 17.3l1.77 1.77M4.93 19.07l1.77-1.77M17.3 6.7l1.77-1.77"
      stroke="currentColor"
      stroke-width="2.5"
      stroke-linecap="round"
    />
  </svg>
{:else if name === 'extrasunny'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <circle cx="12" cy="12" r="5" />
      <path
        d="M12 1.5l1.6 3.4 3.7-1-1 3.7 3.4 1.6-3.4 1.6 1 3.7-3.7-1-1.6 3.4-1.6-3.4-3.7 1 1-3.7-3.4-1.6 3.4-1.6-1-3.7 3.7 1z"
        opacity="0.9"
      />
    </svg>
  {:else if name === 'cloudy'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path
        d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96z"
      />
    </svg>
  {:else if name === 'overcast'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path
        d="M19 12c0-2.8-2.2-5-5-5-1.9 0-3.6 1.1-4.4 2.7C9.2 9.4 8.6 9.3 8 9.3c-2.6 0-4.7 2.1-4.7 4.7 0 2.6 2.1 4.7 4.7 4.7h11c2.2 0 4-1.8 4-4 0-1.9-1.3-3.5-3-3.9-.2-.3-.5-.6-.8-.8z"
        opacity="0.65"
      />
      <path
        d="M16.5 15.2c-.4-2.3-2.4-4-4.8-4-1.9 0-3.6 1.1-4.4 2.8C7 14 6.6 14 6.2 14 4.4 14 3 15.4 3 17.2s1.4 3.2 3.2 3.2h10.3c1.7 0 3-1.3 3-3 0-1.5-1.1-2.7-2.6-2.9-.1-.1-.3-.2-.4-.3z"
      />
    </svg>
  {:else if name === 'rain'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path
        d="M19.35 8.04C18.67 4.59 15.64 2 12 2 9.11 2 6.6 3.64 5.35 6.04 2.34 6.36 0 8.91 0 12c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96z"
      />
      <path
        d="M6 19.5l-1.5 3M11 19.5l-1.5 3M16 19.5l-1.5 3"
        stroke="currentColor"
        stroke-width="2.5"
        stroke-linecap="round"
      />
    </svg>
  {:else if name === 'snow'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path
        d="M19.35 7.04C18.67 3.59 15.64 1 12 1 9.11 1 6.6 2.64 5.35 5.04 2.34 5.36 0 7.91 0 11c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96z"
      />
      <circle cx="7" cy="20" r="1.5" />
      <circle cx="12" cy="21" r="1.5" />
      <circle cx="17" cy="20" r="1.5" />
    </svg>
  {:else if name === 'thunder'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path
        d="M19.35 7.04C18.67 3.59 15.64 1 12 1 9.11 1 6.6 2.64 5.35 5.04 2.34 5.36 0 7.91 0 11c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96z"
      />
      <path
        d="M13 14l-3 4h3l-2 5 6-6h-3.5l2.5-3z"
        stroke="currentColor"
        stroke-width="1.5"
        stroke-linejoin="round"
      />
    </svg>
  {:else if name === 'foggy'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path
        d="M19 10.5c0-2.5-1.9-4.5-4.4-4.5-1.7 0-3.2 1-3.9 2.4-.4-.3-.9-.4-1.4-.4-2.3 0-4.1 1.8-4.1 4.1 0 .2 0 .4.1.6h13.7z"
        opacity="0.8"
      />
      <path
        d="M4 14.5h16M2 17.5h20M5 20.5h14"
        stroke="currentColor"
        stroke-width="2.5"
        stroke-linecap="round"
      />
    </svg>
  {:else if name === 'moon'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" />
    </svg>
  {:else if name === 'climatime-logo'}
    <svg class={className} viewBox="0 0 24 24" fill="currentColor">
      <circle cx="12" cy="12" r="5" />
      <circle cx="12" cy="3" r="1.5" />
      <circle cx="12" cy="21" r="1.5" />
      <circle cx="3" cy="12" r="1.5" />
      <circle cx="21" cy="12" r="1.5" />
      <circle cx="5.6" cy="5.6" r="1.5" />
      <circle cx="18.4" cy="18.4" r="1.5" />
      <circle cx="5.6" cy="18.4" r="1.5" />
      <circle cx="18.4" cy="5.6" r="1.5" />
    </svg>
  {:else}
    <svg class={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <circle cx="12" cy="12" r="9" />
    </svg>
  {/if}
