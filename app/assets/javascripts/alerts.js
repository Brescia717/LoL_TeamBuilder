$(document).ready(function() {
  alertBox = $('.alert-box');
  setTimeout(function(){
    alertBox.fadeOut(200, function() {
      // Animation complete
    });
  }, 3000);
});
