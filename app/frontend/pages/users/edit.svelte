<script>
  import { useForm } from 'inertiax-svelte'
  import { createEventDispatcher } from 'svelte'

  export let user
  export let onSuccess

  const dispatch = createEventDispatcher()

  $: form = useForm('user', user)
</script>


<form on:submit|preventDefault={() => $form.put(`/users/${user.id}`, {target: '_top', onSuccess})} >
  <h2>Update your profile</h2>

  <div class="form-control">
    <label for="bio">Bio</label>
    <textarea placeholder="Write a little bit about who you are and what your followers can expect to see." id="bio" name="bio" class="textarea" rows="5" bind:value={$form.bio}></textarea>
  </div>

  <button class="btn mt-2" name="submit">Save profile</button>
</form>