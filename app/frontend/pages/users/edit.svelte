<script>
  import { useForm } from 'inertiax-svelte'

  export let user
  export let onSuccess

  const form = useForm('user', user)
</script>

<form on:submit|preventDefault={() => $form.put(`/users/${user.id}`, {target: '_top', onSuccess})} >
  <h2>Update your profile</h2>

  <div class="form-control mb-2">
    <label for="name">Name</label>
    <input placeholder="Your name" bind:value={$form.name}>
  </div>

  <div class="form-control mb-2">
    <label for="nickname" class:error="{$form.errors.nickname}">
      Handle
      {#if $form.errors.nickname}
        {$form.errors.nickname}
      {/if}
    </label>
    <input placeholder="" bind:value={$form.nickname} on:change={() => $form.clearErrors('nickname')}>
    <p class="text-#666 text-sm">
      www.shitcoinswap.com/<span class="text-#000">@{$form.nickname}</span>
    </p>
  </div>


  <div class="form-control">
    <label for="bio">Bio</label>
    <textarea placeholder="Write a little bit about who you are and what your followers can expect to see." id="bio" name="bio" class="textarea" rows="5" bind:value={$form.bio}></textarea>
  </div>

  <button class="btn mt-2" name="submit">Save profile</button>
</form>

<style>
  .error {
    color: red;
  }
  .error + input {
    border-color: red;
  }
</style>