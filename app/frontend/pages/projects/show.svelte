<script>
  export let project
  export let current_user
</script>

<div class="flex flex-col justify-center container rounded-2 bg-white">
  <div class="pattern p-4 flex gap-3 items-center">
    <div class="w-16 h-16 bg-#fafafa border border-#ccc"></div>
    <div class="info">
      <h2>
        {project.symbol.toUpperCase()} 
        <span class="text-gray font-normal">
          {project.name}
        </span> 
      </h2>
      <p>No price information</p>
    </div>
  </div>
  <div class="p-4">
    Phase:
    <span class="badge">
       {project.stage}
    </span>
    {#if current_user}
    We're still collecting information about {project.name}.
    <!-- <div class="btn disabled">Buy</div> -->
    {:else}
    <p>Create an account to invest in {project.name}</p>
    <a href="/users/new?return_to_referer=true" class="btn">Create account</a>
    {/if}
  </div>
</div>

<style>
  .badge {
    display: inline-block;
    border-radius: 5px;
    padding: 5px 10px;
    background-color: #b5d9ff;
    color: #333;
    font-weight: bold;
    font-size: 0.9em;
  }
</style>