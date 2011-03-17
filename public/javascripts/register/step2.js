$(document).ready(function() {

	var defaultvalue = "'Pandas in the world', 'Elvis sightings'...";
	$("#appname").val(defaultvalue);
	
	$("#appname").focus(function(){
		if ($(this).val() == defaultvalue) {
			$(this).val('');
		}
	});

	$("#appname").blur(function(){
		if (!$(this).val()) {
			$(this).val(defaultvalue);
		}
	});

});