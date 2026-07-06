<script>
  const { children } = $props()
</script>

<svelte:head>
  <title>Shitcoin Society</title>
</svelte:head>

<nav>
  <section class="container">
    <menu>
      <a href="/" class="brand">
        <span>Shitcoin Society</span>
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
