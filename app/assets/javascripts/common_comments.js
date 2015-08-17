$(document).ready(function(){
  $('#common_comment_link').on('click', function(e){
    e.preventDefault();

    $('#common_coment_form').toggle();
  });

  $('#toggle_project_comments').on('click', function(e){
    e.preventDefault();

    $('#project_comments').toggle();
  });

  $('#toggle_contact_comments').on('click', function(e){
    e.preventDefault();

    $('#contact_comments').toggle();
  });

  $('#toggle_customer_comments').on('click', function(e){
    e.preventDefault();

    $('#customer_comments').toggle();
  });
});
