<script lang="ts">
  let {
    checked = $bindable(false),
    disabled = false,
    onchange,
  }: {
    checked?: boolean;
    disabled?: boolean;
    onchange?: (val: boolean) => void;
  } = $props();

  function toggle() {
    if (disabled) return;
    checked = !checked;
    onchange?.(checked);
  }
</script>

<button
  type="button"
  role="switch"
  aria-label="Toggle setting"
  aria-checked={checked}
  aria-disabled={disabled}
  onclick={toggle}
  class="relative inline-flex h-5 w-9 shrink-0 cursor-pointer items-center rounded-md border transition-colors duration-200 focus:outline-none {checked
    ? 'border-white/20 bg-[#161a24]'
    : 'border-white/5 bg-[#0f1117]'} {disabled ? 'cursor-not-allowed opacity-50' : ''}"
>
  <span
    class="pointer-events-none inline-block h-3 w-3 transform rounded-[2px] transition duration-200 ease-in-out {checked
      ? 'translate-x-[20px] bg-white shadow-sm'
      : 'translate-x-[3px] bg-neutral-600'}"
  ></span>
</button>
