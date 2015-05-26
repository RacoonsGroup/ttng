$ ->
  CKEDITOR.config.language = "ru"
  CKEDITOR.config.autoParagraph = false
  CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR
  CKEDITOR.config.shiftEnterMode = CKEDITOR.ENTER_BR

  $('[contenteditable=true][object=false]').on 'blur', (e) ->
    $input = $(e.target)
    key = $input.attr('data-pk')
    url = $input.attr('data-url')

    $.ajax
      method: 'POST'
      url: url
      data:
        pk: key
        value: $input.html()
        text_only: $input.attr('data-text-only')

  $('[contenteditable=true][object=true]').on 'blur', (e) ->
    $input     = $(e.target)
    id         = $input.attr('data-id')
    class_name      = $input.attr('data-class')
    attribute  = $input.attr('data-attribute')
    url        = $input.attr('data-url')

    $.ajax
      method: 'POST'
      url: url
      data:
        id: id
        class_name: class_name
        attribute: attribute
        value: $input.html()