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
    $('div.edit_value').hide();
    $('div.setting_value').show();
    var clickedId = $(this).parent().parent().attr("id");
    $(this).parent().hide();
    $('div.settings_list_container ul li#'+clickedId+' div.edit_value').show();
    $('div.settings_list_container ul li#'+clickedId+' div.edit_value input[type="text"]').focus();
  });

  $('span.cancel_value a').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    console.log("cancelando");
    var clickedId = $(this).parent().parent().parent().attr("id");
    $(this).parent().parent().hide();
    $('div.settings_list_container ul li#'+clickedId+' div.setting_value').show();
    var previousVal = $('div.settings_list_container ul li#'+clickedId+' div.edit_value input[type="hidden"]').val();
    $('div.settings_list_container ul li#'+clickedId+' div.edit_value input[type="text"]').val(previousVal);
  });

  var column_width = null,
      first_column_position = 1;

  $('#scroll_left').click(function(evt){
    evt.preventDefault();
    if (parseInt($('#features_table table').css('left')) == 0) {return;};
    first_column_position--;
    column_width = $('div#features_table table tr.header th:nth-child(' + first_column_position + ')').outerWidth();
    $('#features_table table').animate({'left': '+='+column_width}, 'fast');
  })
  $('#scroll_right').click(function(evt){
    evt.preventDefault();
    column_width = $('div#features_table table tr.header th:nth-child(' + first_column_position + ')').outerWidth();
    $('#features_table table').animate({'left': '-='+column_width}, 'fast');
    first_column_position++;
  })

 });
