$(document).ready(function() {

  $("#app_name").focus(function(){
    if (!$(this).val() || $(this).val() == '') {
      $(this).prev().fadeOut('fast');
    }
  });

  $("#app_name").blur(function(){
    if (!$(this).val() || $(this).val() == '') {
      $(this).prev().fadeIn('fast');
    }
  });

});