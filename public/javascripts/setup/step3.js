$(document).ready(function() {
  $('#features_table').hide();
  $('#tables_combo li a').click(function(evt){
    evt.preventDefault();
    var table_name = $(this).text();
    $.get('/setup/features_table_data', {'table_name': table_name}, function(html){
      $('#table_data').html(html);
      $('#features_table').val(table_name);
      $('#use_this_table').attr('disabled', 'disabled');
      if (table_name && table_name != '') {
        $('#use_this_table').removeAttr('disabled');
      };
    });
  });

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
