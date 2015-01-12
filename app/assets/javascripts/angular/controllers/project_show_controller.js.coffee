'use strict'

angular.module('gs.projectShowController', []).controller 'ProjectShowController',
  ['$scope'
    ($scope)->
      $scope.password = ''

      $scope.passwordEntered = ->
        $scope.$emit('password_entered', $scope.password)

      $scope.pressed = (e)->
        if (e.which == 13)
          $scope.passwordEntered()
]