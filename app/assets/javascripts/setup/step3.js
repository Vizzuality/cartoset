$(document).ready(function() {
  $('#features_table').hide();
  $('#tables_combo li a').click(function(e){
    e.preventDefault();
    var table_name = $(this).text();
    load_table_data(table_name);
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
    $("a.selector").html($(this).html().length > 19 ? $(this).html().substring(0, 19) + '...' : $(this).html());
    $("input#table").val($(this).attr("id"));
    $("a.main_action").removeClass("disabled");
  });

  $('#new_table').click(function(e){
    e.preventDefault();
    $('#select_table').fadeOut('fast', function(){
      $('#create_table').fadeIn(function(){

        $('#use_this_table').attr('disabled', 'disabled');
        $('#file-uploader, #create_table .select_file').fadeIn();
        $('#create_table .processing').fadeOut();

        var uploader = new qq.FileUploader({
          element: $('#file-uploader')[0],
          action: '/setup/create_features_table',
          allowedExtensions: ['csv', 'xls', 'zip'],
          // sizeLimit: 0, // max size
          // minSizeLimit: 0, // min size
          onSubmit: function(id, fileName){
            $('#file-uploader,#create_table .select_file').fadeOut(function(){
              $(this).next('.processing').fadeIn();
            });
          },
          onProgress: function(id, fileName, loaded, total){

          },
          onComplete: function(id, fileName, responseJSON){
            var table = responseJSON,
                table_name = table['name'];
            if ($('#tables_combo li a:contains("'+ table[name] +'")').length <= 0) {
              $('#tables_combo').append($('<li><a href="#">' + table_name + '</a>'));
              $('#features_table').append($('<option value="'+ table_name +'">'+ table_name +'</option>'));
              $('.scroll_pane').jScrollPane();
            };

            $('#create_table').fadeOut('fast', function(){
              $('#select_table').fadeIn(function(){
                $('a.selector').text(table_name);
                load_table_data(table_name);
              });
            });
          },
          onCancel: function(id, fileName){

          }
        });

      });
    });
  });
});

function load_table_data(table_name){

  var opts = {
    lines: 12, // The number of lines to draw
    length: 7, // The length of each line
    width: 4, // The line thickness
    radius: 10, // The radius of the inner circle
    color: '#8ebf37', // #rbg or #rrggbb
    speed: 0.5, // Rounds per second
    trail: 40, // Afterglow percentage
    shadow: true // Whether to render a shadow
  };

  var spinner = new Spinner(opts).spin(document.getElementById('spinner'));

  $.get('/setup/features_table_data', {'table_name': table_name}, function(html){
    $('#table_data').html(html);
    spinner.stop();
    $('#features_table').val(table_name);
    $('#use_this_table').attr('disabled', 'disabled');
    if (table_name && table_name != '') {
      $('#use_this_table').removeAttr('disabled');
    };
  });
};