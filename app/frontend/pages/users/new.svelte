<script context="module">
  import Onboarding from '$/layouts/onboarding.svelte'
  export const layout = [Onboarding]
</script>


<script>
  import { Frame, useForm } from 'inertiax-svelte'
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
        theme: 'light',
        sitekey: '0x4AAAAAAAQHOuUYuYeDDJQ7',
        callback: function(token) {
          $form.turnstile_token = token
          captchaCompleted = true
        },
      });

    }
    if (window.RAILS_ENV == 'test') {
      captchaCompleted = true
    }
  })

  function loginWith(provider) {
    let url = `/session/new?provider=${provider}`
    let height = 820
    let width = 520
    var left = ( screen.width - width ) / 2
    var top = ( screen.height - height ) / 2
    window.open( url, "Log in to Shitcoin Swap", 'resizable=1,scrollbars=no,width=' + width + ', height=' + height + ', top='+ top + ', left=' + left)
  }
</script>

<main class="w-1/2 min-w-80">
  <form on:submit|preventDefault={() => $form.post(`/users`)} class="">
    <h2 class="text-center mb-2">Sign up</h2>
    <!-- <label for="email" class:error={$form.errors.email}>Email address {$form.errors.email  || ''}</label><br> -->
    <input class="w-full mb-2" name="email" type="email" placeholder="Email address" bind:value={$form.email}>

    <!-- <label for="password" class:error={$form.errors.password}>Password {$form.errors.password  || ''}</label><br> -->
    <input class="w-full mb-2" name="password" type="password" placeholder="Password" bind:value={$form.password}>
   
    <!-- <label for="password_confirmation" class:error={$form.errors.password_confirmation}>Password confirmation {$form.errors.password_confirmation  || ''}</label><br> -->
    <input class="w-full mb-2" name="password_confirmation" type="password" placeholder="Confirm password" bind:value={$form.password_confirmation}>

    <!-- Checking you're not a robot... -->
    <div id="turnstile_container"></div>
    {#if flash.turnstile_error}
      <div class="error">{flash.turnstile_error}</div>
    {/if}
    <button class="btn !mt-4" name="signup" disabled={!captchaCompleted}>Sign up</button><br>
  </form>


  <div class="flex flex-col gap-2 mt-8">
    <div class="text-center">
      Sign up with
    </div>
    <button on:click={() => loginWith('twitter')} class="twitter btn !px-2">
      <div class="flex w-full">
        <div class="i-pajamas:twitter w-1.5em h-1.5em align-middle"></div>
        <span class="flex-1">
          Twitter

        </span>

      </div>
    </button>
    
    <button on:click={() => loginWith('google_oauth2')} class="btn google">
      Google
    </button>
  </div>

  <p class="text-center mt-8">
    Already have an account? <a href="/session/new">Log in</a>.
  </p>

</main>


<style>
  .error {
    color: red;
  }
  :global(#turnstile_container iframe) {
    width: 100% !important;
  }
</style>