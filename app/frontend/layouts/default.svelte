<script>
  import { router } from 'inertiax-svelte'
    import { onMount } from 'svelte';
  import { fade } from 'svelte/transition';

  export let current_user
  export let controller
  export let title

  onMount(() => {
    router.on('navigate', () => menuOpen = false)
  })

  let menuOpen = false
</script>

<svelte:head>
  <title>{title || 'Shitcoin Swap'}</title>
</svelte:head>

<section>
    {#if menuOpen}
    <div on:click={() => menuOpen = false } class="md:hidden overlay text-white" transition:fade={{duration: 200}}>
      <button  class="i-pajamas:close w-8 h-8  fixed top-4 right-4"></button>
    </div>
    {/if}
    <nav class:menuOpen>
      <!-- <img src="$assets/logo.png?h=32" alt="Logo" class="inline-block" /> -->
      
      <div class="w-full ">
        <img src="$assets/textmark.png?h=32" alt="Shitcoin Swap" class="" />
      </div>
      
      {#if current_user}
      
      {:else}
      <a href="/session/new" class="login">
        <div class="profile_image">
          <div class="i-pajamas:profile w-2em h-2em"></div>
        </div>
        <p class="leading-none">
          <span class="text-lg">Have an account?</span><br>
          <span class="text-primary-link">Log in</span>
        </p>
      </a>
      {/if}

      <a class="navlink" href="/currencies" class:active={controller === 'currencies'}>
        <div class="i-material-symbols-light:currency-exchange w-1.3em h-1.3em"></div>
        Buy and sell
      </a>
      
      <a class="navlink" href="/portfolio" class:active={controller === 'portfolios'}>
        <div class="i-game-icons:chart w-1.3em h-1.3em"></div>
        My Portfolio
      </a>
      {#if current_user}
      
        <div class="flex-1"></div>
      <!-- <a href="/currencies">Explore</a> -->
        <button class="btn" id="logout" on:click={() => router.delete('/session')}>Log out</button>
      {:else}
        
        <div class="flex-1"></div>
        <a href="/privacy" class="mb-2">Privacy Policy</a>
        <a href="/users/new" class="btn primary">Sign up</a>
        <!-- <div class="flex-1"></div> -->
      {/if}
    </nav>
  
  <main>
    <header class="container mx-auto flex gap-3 items-center">
      <div class="flex-1">
        <button class="md:hidden" on:click={() => menuOpen = true}>
          <div class="i-pepicons-print:menu w-2em h-2em"></div>
        </button>
      </div>
      <img src="$assets/logo.png?h=40" alt="Logo" class="inline-block" />
      <img src="$assets/textmark.png?h=32" alt="Shitcoin Swap" class="inline-block" />
      <div class="flex-1"></div>
    </header>
    <div class="p-4">
      <slot />
    </div>
    <footer class="md:hidden">
      <a href="/users/new" class="btn primary">Sign up</a>
    </footer>
  </main>

</section>

<style>
  nav {
    position: fixed;
    /* background: rgb(42, 40, 39); */
    top: 0;
    left: 0;
    width: 280px;
    max-width: calc(100% - 4rem);
    transform: translateX(-100%);
    flex-direction: column;
    height: 100%;
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 4px rgba(0, 0, 0, .65);
    padding: 1.5rem;
    display: flex;
    align-items: center;
    background: linear-gradient(180deg, rgba(93, 78, 70, 1) 0%, rgb(42, 40, 39) 100%);
    color: white;
    border-radius: 0.5rem;
    z-index: 10;
    transition: transform .3s;
    .btn {
      width: 100%;
    }
    .navlink {
      padding-inline: 1rem;
      height: calc(100% + 4rem);
      display: flex;
      color: #ddd;
      /* background-color: red; */
      flex-direction: column;
      align-items: center;
      width: calc(100% + 3rem);
      padding: 1rem 1.5rem;
      height: auto;
      flex-direction: row;
      gap: 1rem;
      font-size: 1.3rem;
      transition: background-color .2s;
      &.active {
        color: white;
        font-weight: bold;
      }

      &:hover {
        background-color: rgba(255, 255, 255, .05);
      }
    }
  }
  nav.menuOpen {
    transform: translateX(0);
  }
  a.login {
    /* flex my-4 text-white gap-3 items-center w-full */
    display: flex;
    align-items: center;
    gap: 1rem;
    width: calc(100% + 3rem);
    padding: 1.5rem;
    color: white;
    margin-block: 1rem;
    background-color: rgba(255, 255, 255, .05);
  }
  main {

    display: grid;
    grid-template-rows: auto 1fr auto;
  }
  footer {
    padding: 1rem;
    position: sticky;
    bottom: 0;
    /* height: 70px; */
    box-shadow: 0 0 3px rgba(0, 0, 0, .04), 0 0 12px rgba(169, 169, 169, 0.65);
    /* background: rgba(255,255,255,0.4); */
    background-image: linear-gradient(180deg, rgb(255, 255, 255) 0%, rgb(156, 156, 156) 100%);
  }
  header {
    padding: 1rem;
    padding-bottom: 0rem;
    display: flex;
    align-items: center;
  }
  section {
    min-height: 100dvh;
    position: relative;
    flex-direction: column;
    justify-content: center;
    display: grid;
    grid-template-columns: 1fr;
    /* grid-template-rows: auto 1fr auto; */
  }
  .overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, .5);
  }

  @media (min-width: 768px) {
    section {
      grid-template-columns: auto 1fr;
    }
    nav {
      margin: 1rem;
      position: sticky;
      max-width: 320px;
      transform: translateX(0);
      top: 1rem;
      gap: 0;
      height: calc(100vh - 2rem);
    }
  }
</style>