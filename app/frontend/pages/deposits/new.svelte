<script>
  import SEPA from './gateways/sepa.svelte'
  import PayPal from './gateways/paypal.svelte'

  export let current_user
  
  let chosenDepositMethod = ''

</script>

<div class="bg-white rounded-2 container">

  <div class="p-4 pattern flex">
    <h2>Deposit Funds</h2>
    <!-- <a href="/deposits/new" class="btn ml-auto">Deposit</a> -->
  </div>
  <div class="p-4">
    <p class="mb-8">
      Deposited funds will show up as "available cash" in your portfolio.

    </p>
    <SEPA user={current_user} />
  </div>
</div>


<style>
  .option {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin-bottom: 10px;
    cursor: pointer;
  }
  
  .option.selected {
    background-color: #b5d9ff;
  }
  
  </style>