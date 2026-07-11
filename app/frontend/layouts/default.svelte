<script>
  import { modal } from "inertiax-ui";
  const { children } = $props();
</script>

<svelte:head>
  <title>Shitcoin Society</title>
</svelte:head>

<nav>
  <section class="container">
    <menu>
      <a href="/" class="brand">
        <img src={"/logo_black.svg"} class="h-8" alt="Shitcoin Society" />
      </a>
      <a href="/assets/new" use:modal class="btn btn-dark">
        Tokenize your Startup
      </a>
    </menu>
  </section>
</nav>

<main>
  {@render children()}
</main>

<footer>
  <section class="container">
    <div class="flex flex-col items-center sm:items-start">
      <img src={"/logo_white.svg"} class="h-10" alt="Shitcoin Society" />
      <span>
        Make something nobody asked for.
      </span>
    </div>
  </section>
  <section class="container border-t border-t-white/20 !mt-8 pt-8 text-sm flex justify-between items-center flex-col sm:flex-row gap-4">
    <div>
      &copy; 2026 Shitcoin Society
    </div>
    <div class="flex gap-4">
      <a href="https://x.com/shitcoinswap" target="_blank" rel="noopener noreferrer">
        <div class="text-xl i-bi:twitter-x">X</div>
      </a>
      <a href="https://www.youtube.com/@shitcoinsociety" target="_blank" rel="noopener noreferrer">
        <div class="text-xl i-bi:youtube">YouTube</div>
      </a>
      <a href="https://github.com/shitcoinsociety" target="_blank" rel="noopener noreferrer">
        <div class="text-xl i-bi:github">GitHub</div>
      </a>
    </div>

  </section>
</footer>

<style>
  footer {
    background: #000000;
    color: white;
    padding-block: 4rem;
    margin-top: 4rem;
    border-top: 1px solid #e0e0e0;
  }

  nav {
    width: 100%;
    z-index: 1000;
  }
  :global(nav:has(+ main .hero)) {
    position: absolute;
    filter: invert(1);
    .btn {
      display: none;
    }
  }
</style>
