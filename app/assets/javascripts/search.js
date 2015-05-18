$(function() {
  $("#customers_search input").keyup(function() {
    $.get($("#customers_search").attr("action"), $("#customers_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#contacts_search input").keyup(function() {
    $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#projects_search input").keyup(function() {
    $.get($("#projects_search").attr("action"), $("#projects_search").serialize(), null, "script");
    return false;
  });
});
