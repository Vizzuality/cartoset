$(document).ready(function() {
  if (window.location.hash) {
    anchor = window.location.hash.substr(1);
    $.scrollTo($('div#main_content div#' + anchor + '_list').position().top-100, 1000, {queue:true});
  };

  // $('#header_content a').click(function(evt){
  //   evt.preventDefault();
  // });

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

    var clickedId = $(this).parent().parent().parent().attr("id");
    $(this).parent().parent().hide();
    $('div.settings_list_container ul li#'+clickedId+' div.setting_value').show();
    var previousVal = $('div.settings_list_container ul li#'+clickedId+' div.edit_value input[type="hidden"]').val();
    $('div.settings_list_container ul li#'+clickedId+' div.edit_value input[type="text"]').val(previousVal);
  });

  var column_width = null,
      first_column_position = 1,
      table_container_width = parseInt($('#features_table').outerWidth()),
      columns_widths = $('div#features_table table tr.header th').map(function(){
        return parseInt($(this).outerWidth());
      }),
      visible_columns_width = 0,
      current_pos = -1,
      moves = $.map(columns_widths, function(val, i){
        visible_columns_width += val;
        value = -(visible_columns_width - table_container_width);
        if (value < 0) {
          return value;
        };
      });

  $('#scroll_left').click(function(evt){
    evt.preventDefault();

    if (current_pos < 0) {
      return;
    }else if(current_pos >= 0){
      current_pos -= 1;
    };

    $('#features_table table').animate({'left': (moves[current_pos] || 0) + 'px'}, 'fast');
  })

  $('#scroll_right').click(function(evt){
    evt.preventDefault();

    if (current_pos < 0) {
      current_pos = 0;
    }else if (current_pos >= 0 && current_pos < moves.length - 1) {
      current_pos += 1;
    };

    $('#features_table table').animate({'left': moves[current_pos] + 'px'}, 'fast');
  })

 });
