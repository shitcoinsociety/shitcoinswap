<script context="module">
  import Onboarding from '$/layouts/onboarding.svelte'
  export const layout = [Onboarding]
</script>

<script>
  import { useForm, page } from '@inertiajs/svelte'
  import { slide } from 'svelte/transition'

  export let flash

  let form = useForm('user', {email: '', password: ''})

  function loginWith(provider) {
    let url = `/session/new?provider=${provider}`
    let height = 820
    let width = 520
    var left = ( screen.width - width ) / 2
    var top = ( screen.height - height ) / 2
    window.open( url, "Log in to Shitcoin Swap", 'resizable=1,scrollbars=no,width=' + width + ', height=' + height + ', top='+ top + ', left=' + left)
  }
</script>

<main>
  
  <form on:submit|preventDefault={() => $form.post(`/session`)} class="">
    <h2 class="text-center mb-2">Log in</h2>
    <input class="w-full mb-2" name="email" type="email" placeholder="Email address" bind:value={$form.email}>
    <input class="w-full mb-2" name="password" type="password" placeholder="Password" bind:value={$form.password}>
    {#if flash.error}
    <p class="text-red-500 italic mb-2" transition:slide>
      {flash.error}
    </p>
    {/if}
    <button class="btn" name="login">Log in</button>
    <p class="text-right">
      <a href="/password_resets/new">Forgot your password?</a>
    </p>
  </form>

  
  <div class="flex flex-col gap-2 mt-8">
    <div class="text-center">
      Log in with
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
    Don't have an account? <a href="/users/new">Sign up</a>.
  </p>
</main>


<style>

</style>