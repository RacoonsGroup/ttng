'use strict'

angular.module('gs.datepicker', []).directive 'datepicker', [->
  restrict: 'A',
  require: '^?ngModel',

  link: (scope, elem, attrs, ngModel) ->
    elem.datepicker(
      autoclose: true
      language: 'ru'
      format: 'dd.mm.yyyy'
    )

    scope.$watch(attrs.ngModel, ->
      elem.datepicker('update', ngModel.$viewValue)
    )

    elem.datepicker().on 'changeDate', ->
      ngModel.$setViewValue(elem.val())

]