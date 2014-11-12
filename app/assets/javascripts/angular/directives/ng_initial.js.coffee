'use strict'

angular.module('gs.ngInitial', []).directive('ngInitial', ->
  restrict: 'A'
  controller: [
    '$scope', '$element', '$attrs', '$parse', ($scope, $element, $attrs, $parse)->
      model = $parse($attrs.ngModel)
      model.assign($scope, $attrs.value)
    ]
)