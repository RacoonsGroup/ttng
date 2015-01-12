'use strict'

angular.module('gs.exportController', []).controller 'ExportController',
  ['$scope', '$http'
    ($scope, $http)->

      $scope.exportToDrive = ->
        console.log $scope
        #$http.get(window.location+'/export', from: $scope.from, to: $scope.to)

      $scope.downloadXLS = ->
        console.log $scope
]