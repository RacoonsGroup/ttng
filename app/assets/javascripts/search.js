$(function() {
  $("#customers td a, #customers .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#customers_search input").keyup(function() {
    $.get($("#customers_search").attr("action"), $("#customers_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#contacts td a, #contacts .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#contacts_search input").keyup(function() {
    $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#projects td a, #projects .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#projects_search input").keyup(function() {
    $.get($("#projects_search").attr("action"), $("#projects_search").serialize(), null, "script");
    return false;
  });
});
