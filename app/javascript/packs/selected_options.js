const form = document.querySelector(".simple_form.new_booking");
const opts = document.querySelectorAll(".opt")
const qtys = document.querySelectorAll(".qty")

opts.forEach((opt) => {
  opt.addEventListener("click", (e)=>{
    opt.parentNode.parentNode.classList.add("selected")
    const qty = document.querySelector(`input[name='${e.target.name}_quantity']`)
    const i = e.target.dataset.index

    if (e.target.checked){
      const selectors = [`booking[selected_options_attributes][${i}][option_id]`,`booking[selected_options_attributes][${i}][quantity]`]

      qty.style = "display:block"
      selectors.forEach((v) => {
        let el = document.createElement("input");
        el.name = v
        el.style = "display:none"
        form.appendChild(el)
      })
    }
    else {
      opt.parentNode.parentNode.classList.remove("selected")
      const selectors = [`input[name='booking[selected_options_attributes][${i}][option_id]']`, `input[name='booking[selected_options_attributes][${i}][quantity]']`]
      qty.style = "display:none"
      selectors.forEach((v) => {
        el = document.querySelector(v)
        el.parentNode.removeChild(el)
      })
    }
  })
})

// `<input data-index="${i}" type="number" name="booking[selected_options_attributes][${i}][option_id]">`
// `<input data-index="${i}" type="number" name="booking[selected_options_attributes][${i}][quantity]">`

qtys.forEach((qty) => {
  qty.addEventListener("change", (e)=>{
    const i = e.target.dataset.index

    i_o = document.querySelector(`input[name='booking[selected_options_attributes][${i}][option_id]']`)
    i_q = document.querySelector(`input[name='booking[selected_options_attributes][${i}][quantity]']`)
    i_o.value = e.target.name.split("_")[0]
    i_q.value = e.target.value
    updateprice()
  })
})

const price = document.querySelector('#price')
const vessel_price = document.querySelector('#vessel_price')
const start = document.getElementById("booking_start_date")
const end = document.getElementById("booking_end_date")

// todo update price should make api call to upddate price helper
function updateprice() {
  let e = new Date(end.value);
  let s =  new Date(start.value);
  let timeDiff = Math.abs(e.getTime() - s.getTime());
  let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
  let opts_price = Array.from(qtys).map((qty) => {
    return qty.dataset.price * qty.value
  })

  opts_price =  opts_price.reduce((a, v) => a + v, 0)
  total_price = (diffDays * vessel_price.innerHTML) + opts_price;
  if (!isNaN(total_price)) {price.innerHTML =  `${total_price}`}
}

// todo make script tag conditional depending on user.vessel = vessel
if (start && end) {
  [start, end].forEach((el) => {
    el.addEventListener('blur', (e) => {
      updateprice()
    })
  })
}
