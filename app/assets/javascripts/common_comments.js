$(document).ready(function(){
  $('#common_comment_link').on('click', function(e){
    e.preventDefault();

    $('#common_coment_form').toggle();
  });
});
