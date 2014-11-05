'use strict'

angular.module('gs.tooltip', []).directive 'tooltip', [->
  restrict: 'A',
  require: '^?ngModel',

  link: (scope, elem, attrs, ngModel) ->
    elem.tooltip()
]