<script>
  export let title
</script>


<svelte:head>
  <title>{title || 'Shitcoin Swap'}</title>
</svelte:head>


<div class="panels">
  <div class="top relative md:m-4">
    <div class="relative p-4 flex flex-col justify-center flex-1">

      <div class="text-center">
        <img src="$assets/logo.png?h=54" alt="Logo" class="inline-block" />
        <img src="$assets/textmark.png?h=32" alt="Shitcoin Swap" class="inline-block" />
      </div>
      <div class="text-white text-center">
        The humble poop-branded trading platform
      </div>
    </div>
    <img src="$assets/onboarding/rave.webp" alt="" class="w-full rounded-2 hidden md:block">
  </div>
  
  <div class="main">
    <div class="fixed top-4 right-4">
      <a href="/"><i class="i-pajamas:close w-8 h-8"></i></a>
    </div>
    <slot />
    <a href="/privacy">Privacy Policy</a>
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
    place-items: center;
  }
  .top {
    display: flex;
    flex-direction: column;
    grid-area: top;
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 4px rgba(0, 0, 0, .65);
    background: linear-gradient(180deg, rgba(93, 78, 70, 1) 0%, rgb(42, 40, 39) 100%);
  }
  .main {
    display: grid;
    padding: 1rem;
    grid-area: main;
  }
  .bottom {
    grid-area: bottom;
  }
  @media (min-width: 768px) {
    .top {
      
      border-radius: 0.5rem;
    }
    .panels {
      grid-template-columns: 2fr 3fr;
      grid-template-areas:
        "top main";
    }
  }
</style>
