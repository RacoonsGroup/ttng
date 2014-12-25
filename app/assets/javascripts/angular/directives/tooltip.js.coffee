'use strict'

angular.module('gs.tooltip', []).directive 'tooltip', [->
  restrict: 'A'

  link: (scope, elem, attrs) ->
    elem.tooltip()
]