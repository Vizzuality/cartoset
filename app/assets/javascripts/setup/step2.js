$(document).ready(function() {
  var app_name_input = $("#settings_app_name");
  if (!app_name_input.val() || app_name_input.val() == '') {
    app_name_input.prev().fadeIn('fast');
  };

  app_name_input.focus(function(){
    if (!$(this).val() || $(this).val() == '') {
      $(this).prev().fadeOut('fast');
    }
  });

  app_name_input.blur(function(){
    if (!$(this).val() || $(this).val() == '') {
      $(this).prev().fadeIn('fast');
    }
  });

});