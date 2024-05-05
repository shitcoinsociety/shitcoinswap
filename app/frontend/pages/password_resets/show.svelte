<script context="module">
  import Onboarding from '$/layouts/onboarding.svelte'
  export const layout = [Onboarding]
</script>


<script>
  import { useForm } from '@inertiajs/svelte';
  export let flash
  import { slide } from 'svelte/transition'
  let form = useForm('reset', {password: '', password_confirmation: ''})
</script>


<main class="container flex justify-center py-24">
  <form on:submit|preventDefault={() => $form.delete(document.location)} class="well">
    <h2>Choose a new password</h2>
    <p>
      Please choose a new password. Make sure it's at least 8 characters long and contains at least one number and one special character.
    </p>
    
    <p class="my-4">
      <label for="password" class:error={$form.errors.password}>Password {$form.errors.password  || ''}</label><br>
      <input name="password" type="password" bind:value={$form.password} placeholder="New password"/>
    </p>

    <p class="my-4">
      <label for="password_confirmation" class:error={$form.errors.password_confirmation}>Password confirmation {$form.errors.password_confirmation  || ''}</label><br>
      <input name="password_confirmation" type="password" bind:value={$form.password_confirmation} placeholder="Confirm password"/>
    </p>
    
    {#if flash.error}
      <p class="text-red-500 italic mb-2" transition:slide>
        {flash.error}
      </p>
    {/if}

    <button class="btn" name="submit">Set new password</button>
  </form>
</main>