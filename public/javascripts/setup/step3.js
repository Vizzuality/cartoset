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
});
