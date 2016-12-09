$(document).on "keydown","input.numero_decimal",(ev)-> 
   	if (ev.shiftKey == true)
    	ev.preventDefault()
    if ($(this).val().indexOf('.') != -1 && ev.keyCode == 190)
        ev.preventDefault()
    if ((ev.keyCode >= 48 && ev.keyCode <= 57) || (ev.keyCode >= 96 && ev.keyCode <= 105) || ev.keyCode == 8 || ev.keyCode == 9 || ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 46 || ev.keyCode == 190)
      	return true
    else 
        ev.preventDefault()
$(document).on "keydown","input.numero_entero",(ev)-> 
    if (ev.shiftKey == true)
      ev.preventDefault()
    if (ev.keyCode == 190)
        ev.preventDefault()
    if ((ev.keyCode >= 48 && ev.keyCode <= 57) || (ev.keyCode >= 96 && ev.keyCode <= 105) || ev.keyCode == 8 || ev.keyCode == 9 || ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 46 || ev.keyCode == 190)
        return true
    else 
        ev.preventDefault()

$(window).load ->
  $("#error_explanation").prepend("<i class='material-icons dp4'>report_problem</i>")

$(document).ready ->
  $('select').material_select()
  return

