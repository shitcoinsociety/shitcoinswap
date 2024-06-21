<script>
  export let current_user

  function formatCurrency(amount) {
    return (amount || 0).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')
  }

  $: totalValue = 
    current_user.available_balances.eur
    + current_user.funds_in_orders.eur || 0
</script>

<div class="bg-white rounded-2 container">

  <div class="p-4 pattern flex items-center">
    <h2>My Portfolio</h2>
    <a href="/deposits/new" class="btn ml-auto">Deposit</a>
  </div>

<div class="value">
  <div class="box">
    <h3>EUR {formatCurrency(current_user.available_balances.eur)}</h3>
    <p>Available</p>
  </div>
  <div class="box">
    <h3>EUR {formatCurrency(current_user.funds_in_orders.eur)}</h3>
    <p>Open Orders</p>
  </div>
  <div class="box">
    <h3>EUR 0.00</h3>
    <p>Investments</p>
  </div>
  <div class="box">
    <h3>EUR {formatCurrency(totalValue)}</h3>
    <p>Total Value</p>
  </div>
</div>

<div class="p-4 border-t">
  <h2>Your portfolio is empty</h2>
</div>

</div>
<style>
  .value {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    place-items: center;
    background: rgba(255,255,255,0.5);
  }
  .box {
    padding: 1rem;
    text-align: center;
  }
  h3 {
    font-weight: bold;
    /* font-size: 1.3rem; */
  }
</style>