<script context="module">
  import Onboarding from '~/layouts/onboarding.svelte'
  export const layout = [Onboarding]
</script>


<script>
  import { useForm } from 'inertiax-svelte';
  let form = useForm('reset', {
    // initialize email with the value from the query string
    email: ''//new URLSearchParams(document.location.search).get('email') || '',
  })
</script>

<main class="flex justify-center">
  <form class="well" on:submit|preventDefault={() => $form.post(`/password_resets`)}>
    <h2>Reset your password</h2>
    <p class="mb-4">
      Enter your email address and we'll send you a link to reset your password.
     </p>

      <p>
        <input class="w-full mb-2" name="email" type="email" bind:value={$form.email} placeholder="Email address"/>
      </p>
      <p>
        <button  class="btn" name="submit">Send link</button>
      </p>
  </form>
</main>