<script>
  export let current_user

  import { router } from '@inertiajs/svelte'
</script>

{#if current_user}
  <button on:click={() => router.delete('/session')}>Log out</button>
{/if}

<slot />