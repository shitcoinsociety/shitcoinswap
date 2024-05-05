<script>
  export let current_user

  import { router, Frame } from '@inertiajs/svelte'
</script>


<slot />

<nav>
  {#if current_user}
  <a href="/currencies">Currencies</a>
    <button on:click={() => router.delete('/session')}>Log out</button>
  {:else}
    <a href="/session/new">Sign up</a>
  {/if}
</nav>

<style>
  nav {
    position: fixed;
    bottom: 1rem;
    left: 1rem;
    right: 1rem;
    border: 1px solid black;
  }
</style>