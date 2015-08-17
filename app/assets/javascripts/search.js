$(document).ready(function(){
  $("#customers_search input").keyup(function() {
    $.get($("#customers_search").attr("action"), $("#customers_search").serialize(), null, "script");
    return false;
  });

  $("#contacts_search input").keyup(function() {
    $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");
    return false;
  });

  $("#projects_search input").keyup(function() {
    $.get($("#projects_search").attr("action"), $("#projects_search").serialize(), null, "script");
    return false;
  });

  $('#clear_form').on('click', function () {
    $('#search_projects')[0].selectize.clear();
    if ($('#search_developers')[0]) {
      $('#search_developers')[0].selectize.clear();
    }
    $('#search_payable')[0].selectize.clear();
    $('#search_from')[0].value = '';
    $('#search_to')[0].value = '';
  });
});
