<script lang="ts">
  import { Switch as ShadcnSwitch } from "$lib/components/ui/switch";

  let {
    checked = $bindable(false),
    disabled = false,
    onchange,
    ...restProps
  }: {
    checked?: boolean;
    disabled?: boolean;
    onchange?: (val: boolean) => void;
    [key: string]: any;
  } = $props();

  function handleCheckedChange(val: boolean) {
    checked = val;
    onchange?.(val);
  }
</script>

<ShadcnSwitch
  bind:checked
  {disabled}
  onCheckedChange={handleCheckedChange}
  {...restProps}
/>
