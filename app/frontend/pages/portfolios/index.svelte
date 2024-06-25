<script>
  import { getStore } from '~/lib/livestores'
  
  let {current_user} = $props()

  const balances = getStore('balances')

  function formatCurrency(amount) {
    amount = parseFloat(amount) || 0
    return amount.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')
  }
console.log($balances)
  let totalValue = 0

</script>

<div class="bg-white rounded-2 container">

  <div class="p-4 pattern md:flex items-center">
    <div class="div">
      <h2>
        EUR {formatCurrency(totalValue)}
        <span class="gains text-green">
          <div class="i-ph:trend-up-bold w-1em h-1em"></div>
          0.0%
        </span>
      </h2>
      <p>Total Portfolio Value</p>
    </div>
    <a href="/deposits/new" class="btn ml-auto">Deposit Funds</a>
  </div>

<div class="value text-0.9em md:text-1em">
  <div class="box">
    <h3>EUR {formatCurrency($balances.eur)}</h3>
    <p>Available</p>
  </div>
  <div class="box">
    <div class="line">
      <div class="icon">
        <div class="i-material-symbols:add "></div>
      </div>
    </div>
    <h3>EUR {formatCurrency(current_user.funds_in_orders.eur)}</h3>
    <p>Open Orders</p>
  </div>
  <div class="box">
    <div class="line">
      <div class="icon">
        <div class="i-material-symbols:add "></div>
      </div>
    </div>
    <h3>EUR 0.00</h3>
    <p>Investments</p>
  </div>

</div>

<div class="p-4 border-t">
  <h2>Your portfolio is empty</h2>
</div>

</div>
<style>
  .value {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    place-items: center;
    background: rgba(255,255,255,0.5);
  }

  .box {
    position: relative;
    width: 100%;
    padding-block: 1rem;
    text-align: center;
  }
  .line {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    width: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-left: 1px solid #ccc;
  }
  .icon {
    position: absolute;
    height: 1.5rem;
    width: 1.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    background: white;
    color: #777;
    border-radius: 100px;
    border: 1px solid #ccc;
   
  }
  h3 {
    font-weight: bold;
    /* font-size: 1.3rem; */
  }
</style>