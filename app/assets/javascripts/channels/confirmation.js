//Sobreescribe la función de comfirmación por defecto de rails
$.rails.allowAction = function(link){
	if (link.data("confirm") == undefined){
		return true;
	}
	$.rails.showConfirmationDialog(link);
	return false;
}

//Función de confirmación
$.rails.confirmed = function(link){
	link.data("confirm", null);
	link.trigger("click.rails");
}

//Despliega el mensaje
$.rails.showConfirmationDialog = function(link){
	var message = link.data("confirm");
	swal({
		title: "¿Estas seguro?",
		text: message,
		type: "warning",
		showCancelButton: true,
		confirmButtonColor: "#DD6B55",
		confirmButtonText: "Si",
		closeOnConfirm: true,
		closeOnCancel: false
	},
	function(isConfirm){
		if (isConfirm) {
			$.rails.confirmed(link);
		} else {
			swal('Cancelado','El registro no se ha eliminado', 'error');
		}
	}
	);
}
