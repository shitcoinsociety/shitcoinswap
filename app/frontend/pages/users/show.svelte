<script>
  import { Frame } from 'inertiax-svelte'
  import { htmlify } from '~/lib/helpers'
  import tippy from '~/lib/tippy'

  export let user
  export let current_user

  let editingProfile = false

  $: canEdit = user.id === current_user?.id
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
        Join club
        <div use:tippy={`As a club member you automatically copy ${user.nickname}'s portfolio and make the same trades.`} class="i-material-symbols:info opacity-60 hover:opacity-80 ml-1 w-1.2em h-1.2em"></div>
      </div>
    </div>
  </div>
  <div class="p-4">
    {#if canEdit && !user.bio}
      <div class="text-#666">
        Let others know a little bit about you by adding a bio.
      </div>
    {:else if user.bio}
      {@html htmlify(user.bio)}
    {:else}
    <div class="text-#666">

      This user has not yet filled out their profile.
    </div>
    {/if}
    {#if canEdit}
      <button class="btn mt-2 alternative inline-block" on:click={() => editingProfile = true}>
        {user.bio ? 'Edit bio' : 'Write bio'}
      </button>
    {/if}
  </div>
</div>

{#if editingProfile}
<div class="modal_bg"></div>
<div class="modal">
  <div class="pattern p-6">
    <Frame src="/users/{user.id}/edit" onSuccess={() => editingProfile = false} />
  </div>
</div>
{/if}

<style>
  .modal_bg {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.6);
    z-index: 10;
  }
  .modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: grid;
    place-items: center;
    z-index: 11;
  }
</style>