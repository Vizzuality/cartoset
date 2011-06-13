  $(document).ready(function() {
    //Radiobutton
    $('a.radiobutton').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      
      if (!$(this).hasClass('selected')) {
        $(this).closest('ul').find('a.radiobutton').each(function(i,ele){
          $(ele).removeClass('selected');
        });
        
        $(this).closest('ul').find('input[type="radio"]').each(function(i,ele){
          $(ele).removeAttr('checked');
        });
        
        $(this).addClass('selected');
        var new_value = $(this).text().toLowerCase();
        $(this).closest('ul').find('input[value="'+new_value+'"]').attr('checked','checked');
      }
    });
    
    
    // Create date list
    // TODO
    
    
    // Style file input
    $('input#file_input').prettyfile({ html: "<strong><span>Choose File</span></strong><span class=\"pf_ph\">Select a image file (JPG, PNG, GIF) from your computer</span>" });
    
    
    $('div.date').removeClass('show');
    $('input.date').show().click(function(ev){
      ev.preventDefault();
      ev.stopPropagation();
      var me = this;
      $(this).toggleClass('active');
      $(this).next().toggleClass('show active');
      
      $('body').click(function(event){
        if (!$(event.target).closest('div.date').length) {
          $(me).toggleClass('active');
          $(me).next().toggleClass('show active');
          $('body').unbind('click');
        };
      });
    });
  });
