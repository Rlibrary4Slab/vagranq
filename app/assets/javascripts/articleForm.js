$(function(){
    
      $('#textInsert').click(function(){
          $('.form-modal').fadeIn();
      });
       $('#login-show').click(function() {
    $('#login-modal').fadeIn();
  });
    
    $('#cancel-btn').click(function(){
        $('.form-modal').fadeOut();
    });

  $('.signup-show').click(function() {
    $('#signup-modal').fadeIn();
  });

  $('.close-modal').click(function() {
    $('#login-modal').fadeOut();
    $('#signup-modal').fadeOut();
  });
  
});