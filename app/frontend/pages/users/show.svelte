<script>
  export let user

  $: displayName = user.name || user.nickname
</script>

<div class="container bg-white rounded-2">
  <div class="p-4  pattern">
    <div class="flex items-center gap-4">
      <img src={user.profile_image_url} alt={user.name} class="w-18 h-18 rounded-2 bg-white" />
      <div class="flex-1 leading-1.75em">
        <h1>{displayName}</h1>
        <p>@{user.nickname}</p>
      </div>
    </div>
    <div class="pt-4">
      <strong>0</strong>
      Members
      <div class="btn mt-2">
        Join group
      </div>
    </div>
  </div>
  <div class="p-4">
    This user has not yet filled out their profile.
  </div>
</div>