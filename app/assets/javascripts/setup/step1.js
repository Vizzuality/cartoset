
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
      $(this).find('.main_action').hide();

      var opts = {
        lines: 12, // The number of lines to draw
        length: 7, // The length of each line
        width: 5, // The line thickness
        radius: 10, // The radius of the inner circle
        rotate: 0, // The rotation offset
        color: '#8ebf37', // #rgb or #rrggbb
        speed: 0.5, // Rounds per second
        trail: 60, // Afterglow percentage
        shadow: false, // Whether to render a shadow
        hwaccel: true, // Whether to use hardware acceleration
        className: 'spinner', // The CSS class to assign to the spinner
        top: 'auto', // Top position relative to parent in px
        left: 'auto' // Left position relative to parent in px
      };
      var spinner = new Spinner(opts).spin(document.getElementById('spinner'));
    });
  });
