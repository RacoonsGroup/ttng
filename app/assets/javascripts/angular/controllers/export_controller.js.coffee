'use strict'

angular.module('gs.exportController', []).controller 'ExportController',
  ['$scope', '$http'
    ($scope, $http)->

      $scope.exportToDrive = ->
        window.location = window.location+"/export?from=#{$scope.from}&to=#{$scope.to}"

      $scope.downloadXLS = ->
        window.location = window.location+".xlsx?from=#{$scope.from}&to=#{$scope.to}"
]