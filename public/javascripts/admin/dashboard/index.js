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
	
	$('span.setting_value a').click(function() {
		// Hide the parent div
		
		// Show the corresponding editable element
		
	});
 });
