<script context="module">
  import Onboarding from '$/layouts/onboarding.svelte'
  export const layout = [Onboarding]
</script>


<script>
  import { Frame, useForm } from '@inertiajs/svelte'
  import { onMount } from 'svelte'

  export let flash

  let form = useForm('user', {email: '', password: '', password_confirmation: '', turnstile_token: ''})

  let captchaCompleted = false
  onMount(function() {
    // load cloudflare turnstile js
    const script = document.createElement('script');
    script.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?onload=onloadTurnstileCallback'
    script.async = true;
    document.body.appendChild(script);
    window.onloadTurnstileCallback = function() {
      turnstile.render('#turnstile_container', {
        theme: 'dark',
        sitekey: '0x4AAAAAAASmMtQEqEQGtDRq',
        callback: function(token) {
          $form.turnstile_token = token
          captchaCompleted = true
        },

      });

    }
    if (window.RAILS_ENV !== 'production') {
      captchaCompleted = true
    }
  })

</script>

<svelte:head>
  <title>Sign up for Shitcoin Swap</title>
</svelte:head>


  <form on:submit|preventDefault={() => $form.post(`/users`)} class="well">

    <label for="email" class:error={$form.errors.email}>Email address {$form.errors.email  || ''}</label><br>
    <input class="w-full mb-2" name="email" type="email" placeholder="Email address" bind:value={$form.email}>

    <label for="password" class:error={$form.errors.password}>Password {$form.errors.password  || ''}</label><br>
    <input class="w-full mb-2" name="password" type="password" placeholder="Password" bind:value={$form.password}>
   
    <label for="password_confirmation" class:error={$form.errors.password_confirmation}>Password confirmation {$form.errors.password_confirmation  || ''}</label><br>
    <input class="w-full mb-2" name="password_confirmation" type="password" placeholder="Confirm password" bind:value={$form.password_confirmation}>

    Checking you're not a robot...
    <div id="turnstile_container"></div>
    {#if flash.turnstile_error}
      <div class="error">{flash.turnstile_error}</div>
    {/if}
    <button class="btn !mt-4" name="signup" disabled={!captchaCompleted}>Sign up</button><br>
  </form>

<style>
  .error {
    color: red;
  }
  :global(#turnstile_container iframe) {
    width: 100% !important;
  }
</style>