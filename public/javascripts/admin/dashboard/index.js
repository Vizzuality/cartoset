$(document).ready(function() {
	$('a#features_menu_link').click(function(e) {
		e.stopPropagation();
		$.scrollTo($('div#main_content div#features_list').position().top-100, 1000, {queue:true});
	});
	$('a#pages_menu_link').click(function(e) {
		e.stopPropagation();
		$.scrollTo($('div#main_content div#pages_list').position().top-100, 1000, {queue:true});
	});
	$('a#settings_menu_link').click(function(e) {
		e.stopPropagation();		
		$.scrollTo($('div#main_content div#settings_list').position().top-100, 1000, {queue:true});
	});
	
	$('div.setting_value a').click(function(e) {
		e.preventDefault();
		e.stopPropagation();
		var clickedId = $(this).parent().parent().attr("id");
		$(this).parent().hide();
		$('div.settings_list_container ul li#'+clickedId+' div.edit_value').show();
		$('div.settings_list_container ul li#'+clickedId+' div.edit_value input[type="text"]').focus();
	});

	$('span.cancel_value a').click(function(e) {
		e.preventDefault();
		e.stopPropagation();
		var clickedId = $(this).parent().parent().parent().attr("id");
		$(this).parent().parent().hide();
		$('div.settings_list_container ul li#'+clickedId+' div.setting_value').show();
	});
	
 });
