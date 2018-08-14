const form = document.querySelector(".simple_form.new_booking");

const opts = document.querySelectorAll(".opt")
const qtys = document.querySelectorAll(".qty")

opts.forEach((opt) => {
  opt.addEventListener("click", (e)=>{
    // console.log(e.target.name)
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
  qty.addEventListener("blur", (e)=>{
    // console.log(e.target.name.split("_")[0])
    // console.log(e.target.dataset.index)
    // console.log(e.target.value)

    const i = e.target.dataset.index

    i_o = document.querySelector(`input[name='booking[selected_options_attributes][${i}][option_id]']`)
    i_q = document.querySelector(`input[name='booking[selected_options_attributes][${i}][quantity]']`)

    i_o.value = e.target.name.split("_")[0]
    i_q.value = e.target.value
  })
})


