<script>
  import { getStore } from '~/lib/livestores'

  export let projects
  export let current_user

  function formatCurrency(value, currency) {
    value = value || 0
    return `${parseFloat(value).toFixed(2)} ${currency}`
  }

  const balances = getStore('balances')
</script>

{#if current_user}
<div class="container rounded-2 bg-white p-4 flex items-center mb-2">
  Thanks for signing up. We'll notify you when the first sale goes live.
</div>
<div class="container rounded-2 gap-2 bg-white p-4 flex flex-col md:flex-row md:items-center mb-2">
  <div class="flex-1">
    <h2>
      <!-- {console.log($balances)} -->
      {formatCurrency($balances?.eur, 'EUR')}
      <span class="gains text-green">
        <!-- <div class="i-ph:trend-up-bold w-1em h-1em"></div>
        0.0% -->
      </span>
    </h2>
    Available balance
  </div>
  <a href="/deposits/new" class="btn">Deposit Funds</a>
</div>
{/if}
<div class="flex flex-col justify-center container pattern bg-white">
  <div class="text-center mt-4 flex-1 p-4 px-8">
    <!-- <img src="~/assets/logo.png?h=64" alt="Logo" class="inline-block" /><br> -->
    <!-- <img src="~/assets/textmark.png?h=42" alt="Shitcoin Swap" class="inline-block" /><br> -->
    
    <h1 class="mt-4 text-1.7em md:text-2.5em text-balance">
      <span class="text-0.8em">Prepare for</span><br><span class="mark md:text-1.1em">World&nbsp;Domination</span>
      <!-- Nothing <span class="mark">ventured</span>&nbsp;&hyphen; nothing <span class="mark">gained</span>. -->
    </h1>
    <p class="mb-4 mt-8 text-balance">
      Join our community of <strong>world-class investors</strong>
      and discover new experimental crypto assets.
    </p>
    {#if !current_user}
    <p class="mb-14 mt-8">
     <a href="/users/new" class="btn !inline !px-12 !py-2">Join now</a>
    </p>
    {/if}
  </div>
  <img src="~/assets/onboarding/rave.webp" alt="" class="w-full rounded-2">
</div>

<style>

</style>
