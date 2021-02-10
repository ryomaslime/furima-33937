window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   const addTaxDom = document.getElementById("add-tax-price")
   const profit = document.getElementById("profit")
   addTaxDom.innerHTML = Math.floor(inputValue / 10)
   profit.innerHTML = inputValue - addTaxDom.innerHTML 
})
})