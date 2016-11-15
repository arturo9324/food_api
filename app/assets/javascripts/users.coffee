$(document).on 'click', 'input#company', (ev) ->
	$('#company_fields').removeClass('hidden') ? $('#company_fields').hasClass('hidden')
	$('#password_fields').addClass('hidden') ? not $('#password_fileds').hasClass('hidden')

$(document).on 'click', 'input#passwordField', (ev) ->
	$('#password_fields').removeClass('hidden') ? $('#password_fields').hasClass('hidden')
	$('#company_fields').addClass('hidden') ? not $('#company_fields').hasClass('hidden')
