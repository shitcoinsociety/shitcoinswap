<script>

</script>

<div class="panels">
  <div class="top">
    
  </div>
  
  <div class="main">
    <slot />
  </div>

  <div class="bottom">
  </div>
</div>

<style>
  .panels {
    height: 100dvh;
    display: grid;
    grid-template-areas:
      "top"
      "main"
      "bottom";
  }
  .panels > * {
    display: grid;
    place-items: center;
  }
  .top {
    grid-area: top;
    background-color: beige;
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
      grid-template-areas:
        "top main"
        "top bottom";
    }
  }
</style>