
  var texts = {
    title: "This value will be used as the title of the page, in the browser window.",
    body: "This is the main content of the page. You can use the visual editor or switch to the HTML editor.",
    permalink: "The permalink value will be used to construct the URL of the page."
  }


  $(document).ready(function(){

    $("#txtDefaultHtmlArea").htmlarea({
        toolbar: [
            ["bold", "italic", "underline", "|", "p","h1", "h2", "h3", "h4", "h5", "h6" ,"|", "orderedlist", "unorderedlist", "|", "link", "unlink", "|", "image"]
        ],
        css: "/stylesheets/admin/pages/htmlArea.css",
        loaded: function() {
          htmlArea = this;
          setTimeout(function(){
            $('label').each(function(i,ele){
              createBubble($(ele).position(),texts[$(ele).attr('for')]);
            });
          },500);
        }
    });

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