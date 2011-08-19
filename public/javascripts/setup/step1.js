
  $(document).ready(function(){
    $('a.radiobutton').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();

      if (!$(this).closest('li').hasClass('selected')) {
        $(this).closest('ul').find('li').each(function(i,ele){
          $(ele).removeClass('selected');
        });

        $(this).closest('li').addClass('selected');
      }
    });

    $('form').submit(function(){
      $('.submit').append($('<div/>', {'id': 'spinner'}));
      $('#settings_submit').hide();

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
    });
  });