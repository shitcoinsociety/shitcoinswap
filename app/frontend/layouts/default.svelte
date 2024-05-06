<script>
  export let current_user

  import { router, Frame } from '@inertiajs/svelte'
</script>



<section>
  <nav>
    {#if current_user}
    
      <div class="flex-1"></div>
    <!-- <a href="/currencies">Explore</a> -->
      <button class="btn" on:click={() => router.delete('/session')}>Log out</button>
    {:else}
      <div class="flex-1"></div>
      <a href="/users/new" class="btn primary">Sign up</a>
      <!-- <div class="flex-1"></div> -->
    {/if}
  </nav>

  <slot />

</section>

<style>
  nav {
    position: fixed;
    bottom: 0.2rem;
    left: 0.2rem;
    right: 0.2rem;
    /* background: rgb(42, 40, 39); */
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 4px rgba(0, 0, 0, .65);
    padding: 0.2rem;
    display: flex;
    align-items: center;
    background: #ddd;
    border-radius: 0.3rem;
  }
  section {
    min-height: 100dvh;
  }

  @media (min-width: 768px) {
    section {
      display: grid;
      grid-template-columns: 200px 1fr;
    }
    nav {
      position: sticky;
      top: 0.4rem;
      left: 0.4rem;
      padding: 0.4rem;
      height: calc(100dvh - 0.8rem);
      flex-direction: column;
      .btn {
        width: 100%;
      }
    }
  }
</style>