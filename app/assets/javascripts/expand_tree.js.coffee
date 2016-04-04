$(document).ready ->
  $('.expand').on 'click', ->
    $(this).parent().find('ol').toggle()
