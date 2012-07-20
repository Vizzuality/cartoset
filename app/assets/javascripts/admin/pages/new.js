
  $(document).ready(function(){

    $("#page_body").htmlarea({
        toolbar: [
            ["bold", "italic", "underline", "|", "p","h1", "h2", "h3", "h4", "h5", "h6" ,"|", "orderedlist", "unorderedlist", "|", "link", "unlink", "|", "image"]
        ],
        css: "/stylesheets/admin/pages/htmlArea.css",
        loaded: function() {
          htmlArea = this;
          setTimeout(function(){
            $('label:not(.visible)').each(function(i,ele){
              console.debug($(ele).attr('for'))
              createBubble($(ele).position(),texts[$(ele).attr('for')]);
            });
          },500);
        }
    });

    $('a.checkbox').click(function(ev){
      ev.stopPropagation();
      ev.preventDefault();
      if ($(this).hasClass('checked')) {
        $(this).removeClass('checked')
      } else {
        $(this).addClass('checked')
      }
    });

    //Html Area
    $('.Toolbar').append('<a class="html_editor" href="#HTML">Show HTML</a>');
    $('.Toolbar').removeAttr('style');
    $('iframe').removeAttr('style');
    $('iframe').css('width',"548px");
    $('iframe').css('height',"440px");
    $('iframe').css('padding',"5px 8px");
    $('iframe').css('background',"url('/images/sprites/htmlArea.png') no-repeat 0 -50px");
    $('iframe').css('border',"none");
  });


  function createBubble(position,text) {
    $('div.side_bar').append('<div class="bubble" style="position:absolute; top:'+position.top+'px"><div class="bottom"><p>'+text+'</p><span class="arrow"></span></div></div>');
  }
