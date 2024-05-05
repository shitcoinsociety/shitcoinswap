<script>

</script>

<div class="panels">
  <div class="top relative">
    <div class="relative text-center">

      <div class="text-center">
        <img src="$assets/logo.png?h=32" alt="Logo" class="inline-block" /><br>
        <img src="$assets/textmark.png?h=32" alt="Shitcoin Swap" class="inline-block" />
      </div>
      <div class="text-white">
        The humble poop-branded social trading platform
      </div>
    </div>
  </div>
  
  <div class="main">
    <slot />
  </div>
</div>

<style>
  .panels {
    height: 100dvh;
    display: grid;
    grid-template-areas:
    "top"
    "main";
  }
  .panels > * {
    display: grid;
    place-items: center;
  }
  .top {
    grid-area: top;
    background-color: rgb(42, 40, 39);
  }
  .main {
    padding: 1rem;
    grid-area: main;
  }
  .bottom {
    grid-area: bottom;
  }
  @media (min-width: 768px) {
    .panels {
      grid-template-columns: 1fr 1fr;
      grid-template-areas:
        "top main";
    }
  }
</style>