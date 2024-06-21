<script>
  export let user

  function encode(accountnumber) {
    return base32encode(reverse(zeropad(accountnumber, 8)))
  }

  function decode(str) {
    return reverse(String(base32decode(str)))
  }


  function base32encode(num) {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  let result = '';

  while (num > 0) {
    result += alphabet[num % alphabet.length];
    num = Math.floor(num / alphabet.length);
  }

  return result;
}

function base32decode(str) {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  let result = 0;

  for (let i = 0; i < str.length; i++) {
    result += alphabet.indexOf(str[i]) * Math.pow(alphabet.length, i);
  }

  return result;
}

  function zeropad(num, size = 8) {
    var s = num + "";
    while (s.length < size) s = "0" + s;
    return s;
  }


  function reverse(str) {
    return str.split('').reverse().join('')
  }

  function epcQRContent() {
    return `BCD
001
1
SCT
SOBKDEBBXXX
Shitcoin Swap
DE65 1101 0100 2586 5556 85
EUR0

${encode(user.id)}


`
  }

  function epcQRCode() {
    return `https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${encodeURIComponent(epcQRContent())}`
  }

  function copyToClipboard() {
    const el = document.createElement('textarea');
    el.value = epcQRContent();
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
  }
</script>

<img src="~/assets/sepa.png" alt="SEPA" class="w-20">
  
<div class="mt-4">
  <div class="important mb-4">
    Please make sure to include the below reference code, otherwise your deposit cannot be assigned to your account and will be returned to you.
  </div>
  <div class="md:flex ">
    <table class="flex-1">
      <tbody>
      <tr>
        <th>Receiver</th>
        <td>Shitcoin Swap</td>
      </tr>
      <tr>
        <th>Bank Name</th>
        <td>Solaris SE </td>
      </tr>
      <tr>
        <th>IBAN</th>
        <td>DE65 1101 0100 2586 5556 85</td>
      </tr>
      <tr>
        <th>BIC/SWIFT</th>
        <td>SOBKDEBBXXX</td>
      </tr>
      <tr>
        <th>Reference</th>
        <td>
          {encode(user.id)}
        </td>
      </tr>
    </tbody>
  </table>
  <div class="flex justify-around">
    <div class="qr sm:text-center inline-block">
      <img src={epcQRCode()} alt="QR Code" class="inline-block w-40">
      <div class="verticaltext">
        Pay with Code
      </div>
      
    </div>
  </div>
</div>
<div class="notice mt-4">
  <p>
    <strong>Expected arrival:</strong> 2-3 business days
  </p>
  <p>
    <strong>Fees:</strong> We don't charge fees for deposits via SEPA transactions. However, your bank might charge you fees for the transaction.
  </p>
</div>
</div>

<style>


.important {
    background-color: #ffeb99;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin-top: 10px;
  
  }
  
  .qr {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    border: 3px solid #333;
    border-radius: 5px;
    padding: 15px;
    position: relative;
  }
  
  .verticaltext {
    background: white;
    transform: translateY(-50%) rotate(-90deg);
    position: absolute;
    top: 50%;
    right: -3.5em;
    padding: 7px;
    line-height: 0.5em;
  
  }
  
  .notice {
    background-color: #f5f5f5;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin-top: 10px;
  }
</style>