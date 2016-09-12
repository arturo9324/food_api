$(document).ready(function(){
	$('.button-collapse').off("click").sideNav({
    	menuWidth: 300, // Default is 240
      	closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
    }
  );
  $('.collapsible').collapsible();
  $(".dropdown-button").dropdown();
});