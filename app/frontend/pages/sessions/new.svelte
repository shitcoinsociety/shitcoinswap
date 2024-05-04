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

<svelte:head>
  <title>Log in to Shitcoin Swap</title>
</svelte:head>

<main>
  
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
    Here for the first time? <a href="/users/new">Create a new account</a>.
  </p>
  
  <div class="flex flex-col gap-4">
    <button on:click={() => loginWith('twitter')} class="twitter btn">
      <div class="i-pajamas:twitter w-1.5em h-1.5em align-middle"></div>
      Log in with Twitter
    </button>
    
    <button on:click={() => loginWith('google_oauth2')} class="google">
      Log in with Google
    </button>
  </div>
</main>


<style>
  .btn.twitter {
    background-color: #1DA1F2;
    padding: 0.8em 2em;
  }

  .google {
    cursor: pointer;
    transition: background-color .3s, box-shadow .3s;
        
    padding: 12px 16px 12px 42px;
    border: none;
    border-radius: 3px;
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 1px rgba(0, 0, 0, .25);
    
    color: #757575;
    font-size: 14px;
    font-weight: 500;
    font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen,Ubuntu,Cantarell,"Fira Sans","Droid Sans","Helvetica Neue",sans-serif;
    
    background-image: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTgiIGhlaWdodD0iMTgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGcgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj48cGF0aCBkPSJNMTcuNiA5LjJsLS4xLTEuOEg5djMuNGg0LjhDMTMuNiAxMiAxMyAxMyAxMiAxMy42djIuMmgzYTguOCA4LjggMCAwIDAgMi42LTYuNnoiIGZpbGw9IiM0Mjg1RjQiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxwYXRoIGQ9Ik05IDE4YzIuNCAwIDQuNS0uOCA2LTIuMmwtMy0yLjJhNS40IDUuNCAwIDAgMS04LTIuOUgxVjEzYTkgOSAwIDAgMCA4IDV6IiBmaWxsPSIjMzRBODUzIiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBkPSJNNCAxMC43YTUuNCA1LjQgMCAwIDEgMC0zLjRWNUgxYTkgOSAwIDAgMCAwIDhsMy0yLjN6IiBmaWxsPSIjRkJCQzA1IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBkPSJNOSAzLjZjMS4zIDAgMi41LjQgMy40IDEuM0wxNSAyLjNBOSA5IDAgMCAwIDEgNWwzIDIuNGE1LjQgNS40IDAgMCAxIDUtMy43eiIgZmlsbD0iI0VBNDMzNSIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZD0iTTAgMGgxOHYxOEgweiIvPjwvZz48L3N2Zz4=);
    background-color: white;
    background-repeat: no-repeat;
    background-position: 12px 11px;
}

.google:hover {
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 2px 4px rgba(0, 0, 0, .25);
}

.google:active {
    background-color: #eeeeee;
}

.google:active {
    outline: none;
        box-shadow: 
        0 -1px 0 rgba(0, 0, 0, .04),
        0 2px 4px rgba(0, 0, 0, .25),
        0 0 0 3px #c8dafc;
}

.google:disabled {
    filter: grayscale(100%);
    background-color: #ebebeb;
    box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 1px rgba(0, 0, 0, .25);
    cursor: not-allowed;
}
</style>