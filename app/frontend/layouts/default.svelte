<script>
  import { modal } from 'inertiax-ui'
  const { children } = $props()
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
        Tokenize your stock
      </a>
    </menu>
  </section>
</nav>

<main>
  {@render children()}
</main>


<footer>
  <section class="container">
    <div class="flex flex-col gap-4 md:flex-row justify-between w-full">
      <div>
        <p>&copy; 2026 Shitcoin Society</p>
      </div>
      <div>
        <h4>Resources</h4>  
        <ul>
          <li>
            <a href="https://github.com/shitcoinsociety" target="_blank" rel="noopener noreferrer">GitHub</a>
          </li>
        </ul>
      </div>
    </div>
  </section>
</footer>

<style>
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