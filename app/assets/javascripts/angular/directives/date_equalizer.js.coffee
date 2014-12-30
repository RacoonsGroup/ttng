'use strict'

angular.module('gs.dateEqualizer', []).directive 'dateEqualizer', [->
  template: '<button class="btn btn-default btn-xs" type="button" ng-click="equalizeDates()">' +
    '<span class="glyphicon glyphicon-arrow-right"/>' +
    '</button>'

  replace: true

  controller: ($scope)->
    $scope.equalizeDates = ->
      $scope.to = $scope.from
]