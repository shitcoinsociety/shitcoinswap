<h1>My Portfolio</h1>

<div class="value">
  <div class="box">
    <h3>EUR 0.00</h3>
    <p>Available</p>
  </div>
  <div class="box">
    <h3>EUR 0.00</h3>
    <p>Invested</p>
  </div>
  <div class="box">
    <h3>EUR 0.00</h3>
    <p>Profit/Loss</p>
  </div>
  <div class="box">
    <h3>EUR 0.00</h3>
    <p>Portfolio Value</p>
  </div>
</div>

<h2>Your portfolio is empty</h2>


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
    font-size: 1.3rem;
  }
</style>