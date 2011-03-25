$(document).ready(function() {

	$('.scroll_pane').jScrollPane();

	$("a.selector").click(function() {
		$("ul.selector_values").toggle();
		$("ul.selector_values").jScrollPane();		
		var backgroundPosition;
		if ($("ul.selector_values").is(":visible")) {
				backgroundPosition = "32px";
		} else {
				backgroundPosition = "0px";			
		}
		$("a.selector").css('background-position','0px '+backgroundPosition);
	});

	$("ul.selector_values li a").click(function(e){
		e.stopPropagation();
		e.preventDefault();
		$("ul.selector_values").toggle();		
		$("a.selector").css('background-position','0px 0px');		
		$("a.selector").html($(this).html());
		$("input#table").val($(this).attr("id"));		
		$("a.main_action").removeClass("disabled");
	});

});


