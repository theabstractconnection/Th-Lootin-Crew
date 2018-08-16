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
      // i_o = document.createElement("input")
      // i_o.name = `booking[selected_options_attributes][${i}][option_id]`
      // i_o.style = "display:none"
      // form.appendChild(i_o)

      // i_q = document.createElement("input")
      // i_q.name = `booking[selected_options_attributes][${i}][quantity]`
      // i_q.style = "display:none"
      // form.appendChild(i_q)
    }
    else {
      opt.parentNode.parentNode.classList.remove("selected")
      const selectors = [`input[name='booking[selected_options_attributes][${i}][option_id]']`, `input[name='booking[selected_options_attributes][${i}][quantity]']`]
      qty.style = "display:none"
      selectors.forEach((v) => {
        el = document.querySelector(v)
        el.parentNode.removeChild(el)
      })
      // i_o = document.querySelector(`input[name='booking[selected_options_attributes][${i}][option_id]']`)
      // i_q = document.querySelector(`input[name='booking[selected_options_attributes][${i}][quantity]']`)
      // i_o.parentNode.removeChild(i_o)
      // i_q.parentNode.removeChild(i_q)
    }
  })
})


// `<input data-index="${i}" type="number" name="booking[selected_options_attributes][${i}][option_id]">`
// `<input data-index="${i}" type="number" name="booking[selected_options_attributes][${i}][quantity]">`



qtys.forEach((qty) => {
  qty.addEventListener("change", (e)=>{
    // console.log(e.target.name.split("_")[0])
    // console.log(e.target.dataset.index)
    // console.log(e.target.value)

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

const start1 = document.querySelector('select#booking_start_date_1i')
const end1 = document.querySelector('select#booking_end_date_1i')
const start2 = document.querySelector('select#booking_start_date_2i')
const end2 = document.querySelector('select#booking_end_date_2i')
const start3 = document.querySelector('select#booking_start_date_3i')
const end3 = document.querySelector('select#booking_end_date_3i')

// todo update price should make api call to upddate price helper
function updateprice() {
  let e = new Date(end1.value ,end2.value ,end3.value);
  let s =  new Date(start1.value ,start2.value ,start3.value);

  let timeDiff = Math.abs(e.getTime() - s.getTime());
  let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

  let opts_price = Array.from(qtys).map((qty) => {
    return qty.dataset.price * qty.value
  })
  opts_price =  opts_price.reduce((a, v) => a + v, 0)
  console.log(opts_price)
  total_price = (diffDays * vessel_price.innerHTML) + opts_price;
  price.innerHTML =  `${total_price}`
}

// todo make script tag conditional depending on user.vessel = vessel
[start1,start2,start3,end1,end2,end3].forEach((el) => {
    el.addEventListener('change', (e) => {
      updateprice()
    })
})
