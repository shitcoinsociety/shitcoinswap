<script>

</script>

<div class="panels">
  <div class="top relative p-4">
    <div class="relative text-center">

      <div class="text-center">
        <img src="$assets/logo.png?h=54" alt="Logo" class="inline-block" />
        <img src="$assets/textmark.png?h=32" alt="Shitcoin Swap" class="inline-block" />
      </div>
      <div class="text-white">
        Your humble poop-branded social trading platform
      </div>
    </div>
  </div>
  
  <div class="main">
    <div class="fixed top-4 right-4">
      <a href="/"><i class="i-pajamas:close w-6 h-6"></i></a>
    </div>
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
