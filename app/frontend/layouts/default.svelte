<script>
  const { children } = $props()
</script>

<svelte:head>
  <title>Shitcoin Society</title>
</svelte:head>

{@render children()}

<footer>
  <section>
    <p>Copyright &copy; 2026 Shitcoin Society</p>
    <h3>Resources</h3>
    <ul>
      <li>
        <a href="https://bitcointalk.org/index.php?topic=5586736" target="_blank">Bitcointalk</a>
      </li>
      <li>
        <a href="https://github.com/shitcoinsociety" target="_blank">GitHub</a>
      </li>
    </ul>
  </section>
</footer>