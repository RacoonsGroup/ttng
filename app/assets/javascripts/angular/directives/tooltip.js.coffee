'use strict'

angular.module('gs.tooltip', []).directive 'tooltip', [->
  restrict: 'A'

  link: (scope, elem, attrs, ngModel) ->
    elem.tooltip()
]