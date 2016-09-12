$(document).on "keydown","input#product_cantidad",(ev)-> 
   	if (ev.shiftKey == true)
    	ev.preventDefault()
    if ($(this).val().indexOf('.') != -1 && ev.keyCode == 190)
        ev.preventDefault()
    if ((ev.keyCode >= 48 && ev.keyCode <= 57) || (ev.keyCode >= 96 && ev.keyCode <= 105) || ev.keyCode == 8 || ev.keyCode == 9 || ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 46 || ev.keyCode == 190)
      	return true
    else 
        ev.preventDefault()
$(document).on "keydown","input#product_calorias",(ev)-> 
   	if (ev.shiftKey == true)
    	ev.preventDefault()
    if ($(this).val().indexOf('.') != -1 && ev.keyCode == 190)
        ev.preventDefault()
    if ((ev.keyCode >= 48 && ev.keyCode <= 57) || (ev.keyCode >= 96 && ev.keyCode <= 105) || ev.keyCode == 8 || ev.keyCode == 9 || ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 46 || ev.keyCode == 190)
      	return true
    else 
        ev.preventDefault()
$(document).on "keydown","input#product_codigo",(ev)-> 
    if (ev.shiftKey == true)
      ev.preventDefault()
    if (ev.keyCode == 190)
        ev.preventDefault()
    if ((ev.keyCode >= 48 && ev.keyCode <= 57) || (ev.keyCode >= 96 && ev.keyCode <= 105) || ev.keyCode == 8 || ev.keyCode == 9 || ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 46 || ev.keyCode == 190)
        return true
    else 
        ev.preventDefault()
$(document).on "click", "input#product_porciones_1",(ev)->
  $("#porciones_num").removeClass("hide")
  $("#product_porciones_num").prop('required', true)
  return true

$(document).on "click", "input#product_porciones_0",(ev)->
  $("#porciones_num").addClass("hide")
  $("#product_porciones_num").prop('required', false)
  return true