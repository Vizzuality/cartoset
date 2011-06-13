$(document).ready(function() {
  $('div.date').removeClass('show');
  $('input.date').show().click(function(ev){
    ev.preventDefault();
    $(this).toggleClass('active');
    $(this).next().toggleClass('show active');
  });
});
