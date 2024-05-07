<script>
  export let current_user

  import { router, Frame } from '@inertiajs/svelte'
</script>



<section>
  <div class="md:p-4">
    <nav>
      <!-- <img src="$assets/logo.png?h=32" alt="Logo" class="inline-block" /> -->
      <img src="$assets/textmark.png?h=32" alt="Shitcoin Swap" class="hidden md:block w-full" />
      {#if current_user}
      
        <div class="flex-1"></div>
      <!-- <a href="/currencies">Explore</a> -->
        <button class="btn" on:click={() => router.delete('/session')}>Log out</button>
      {:else}
        <p class="">
          Already have an account?<br>
          <a href="/session/new">Log in</a>
        </p>
        <div class="flex-1"></div>
        <a href="/users/new" class="btn primary">Sign up</a>
        <!-- <div class="flex-1"></div> -->
      {/if}
    </nav>
  </div>
  <slot />

</section>

<style>
  nav {
    position: fixed;
    bottom: 0.7rem;
    left: 0.7rem;
    right: 0.7rem;
    /* background: rgb(42, 40, 39); */
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 4px rgba(0, 0, 0, .65);
    padding: 0.7rem;
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
      grid-template-columns: 250px 1fr;
    }
    nav {
      position: sticky;
      top: 1rem;
      /* width: 220px; */
      padding: 1rem;
      height: calc(100%);
      flex-direction: column;
      .btn {
        width: 100%;
      }
    }
  }
</style>