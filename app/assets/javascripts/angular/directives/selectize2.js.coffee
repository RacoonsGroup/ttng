'use strict'

angular.module('gs.selectize2', []).directive 'selectize2', [->
  {
  restrict: 'A',
  require: '^?ngModel',
  link: (scope, elem, attrs, ngModel) ->
    refreshItems = ->
      s.clear()

      if attrs.multiple
        for item in (s.new_items || [])
          if attrs.onlyIdInModel?
            s.addItem(item, true)
          else
            s.addItem(item[valueField], true)
      else
        if s.new_items?
          items = _.flatten([s.new_items])
          if attrs.onlyIdInModel?
            s.addItem(String(items[0]), true)
          else
            s.addItem(String(items[0][valueField]), true)


    refreshOptions = ->
      s.clearOptions()
      options = scope.$eval(attrs.selectizeOptions) || []

      for option in options
        if typeof option == 'object'
          s.addOption(option)
        else
          hash = {}
          hash[valueField] = option
          hash[labelField] = option
          s.addOption(hash)

      if attrs.includeModel?
        if attrs.multiple
          for item in ngModel.$viewValue
            s.addOption(item)
        else
          s.addOption(ngModel.$viewValue) if ngModel.$viewValue?
      s.refreshOptions(false)
    updateModel = ->
      items = s.items
      if !attrs.onlyIdInModel?
        items = Object.keys(s.options).filter((option_id)->
          _.contains(s.items, String(option_id))
        ).map (item_id)->
          s.options[item_id]

      if attrs.multiple
        ngModel.$setViewValue(items)
      else
        ngModel.$setViewValue(items[0])
      s.new_items = items
      ngModel.$setValidity('selectize2', true);
      ngModel.$render()
      scope.$apply()

    valueField = (attrs.valueField || 'id')
    labelField = (attrs.labelField || 'name')
    create = (attrs.create || false)

    if attrs.onload?
      load = (query)->
        scope.$eval(attrs.onload, query: query)
    else
      load = null

    config = {
      plugins: ['remove_button']
      persist: true
      valueField: valueField
      labelField: labelField
      searchField: labelField
      create: create
      load: load
    }

    if !attrs.multiple
      config.maxItems = 1

    s = $(elem).selectize(config)[0].selectize

    if attrs.selectizeOptions?
      scope.$watch(attrs.selectizeOptions, ->
        refreshOptions()
        refreshItems()
      , true)

    if ngModel?
      scope.$watch(attrs.ngModel, ->
        s.new_items = angular.copy(ngModel.$viewValue)
        refreshItems()
      )

      s.on 'item_add', ->
        updateModel()

      s.on 'item_remove', ->
        updateModel()
  }
]