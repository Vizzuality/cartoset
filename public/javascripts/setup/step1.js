
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
  });