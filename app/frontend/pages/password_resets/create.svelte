<script context="module">
  import Onboarding from '$/layouts/onboarding.svelte'
  export const layout = [Onboarding]
</script>


<main class="container py-24 flex justify-center">
  <div class="well">
    <h2>Email sent</h2>
    <p>
      If your email address exists in our database, you will receive a password recovery link shortly.
    </p>

    <a href="/session/new">Back to log in</a>
  </div>
</main>