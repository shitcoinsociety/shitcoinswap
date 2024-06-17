<script>
  export let project
</script>

<div class="flex flex-col justify-center h-full container pattern bg-white">
  <h1>{project.name}</h1>
  <div class="badge">
    {project.stage}
  </div>
  <div class="btn">Buy</div>
</div>