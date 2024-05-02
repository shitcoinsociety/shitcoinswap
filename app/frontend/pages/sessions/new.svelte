<script context="module">
  export const layout = []
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

<svelte:head>
  <title>Log in to Shitcoin Swap</title>
</svelte:head>

<button on:click={() => loginWith('twitter')} class="twitter btn">
  <div class="i-pajamas:twitter w-1.5em h-1.5em align-middle"></div>
  Log in with Twitter
</button>

<button on:click={() => loginWith('google_oauth2')} class="google btn">
  <div class="i-pajamas:google w-1.5em h-1.5em align-middle"></div>
  Log in with Google
</button>

<form on:submit|preventDefault={() => $form.post(`/session`)} class="well flex-1">
  <input class="w-full mb-2" name="email" type="email" placeholder="Email address" bind:value={$form.email}>
  <input class="w-full mb-2" name="password" type="password" placeholder="Password" bind:value={$form.password}>
  <a class="float-right" href="/password_resets/new">Forgot your password?</a><br>
  {#if flash.error}
    <p class="text-red-500 italic mb-2" transition:slide>
      {flash.error}
    </p>
  {/if}
  <button class="btn" name="login">Log in</button><br>
</form>
<p class="text-right">
  Here for the first time? <a href="/users/new?flow=organizer">Create a new account</a>.
</p>

<style>
  .btn.twitter {
    background-color: #1DA1F2;
    padding: 0.8em 2em;
  }
</style>