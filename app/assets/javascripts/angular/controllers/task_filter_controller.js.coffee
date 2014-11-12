'use strict'

angular.module('gs.taskFilterController', []).controller 'TaskFilterController',
  ['$scope',
    ($scope)->
      $scope.today = ->
        $scope.from = moment().format('l')
        $scope.to = moment().format('l')

      $scope.yesterday = ->
        $scope.from = moment().subtract(1, 'day').format('l')
        $scope.to = moment().subtract(1, 'day').format('l')

      $scope.thisIteration = ->
        $scope.from = moment().startOfIteration().format('l')
        $scope.to = moment().endOfIteration().format('l')

      $scope.previousIteration = ->
        $scope.from = moment().startOfPreviousIteration().format('l')
        $scope.to = moment().endOfPreviousIteration().format('l')

      $scope.thisWeek = ->
        $scope.from = moment().startOf('week').format('l')
        $scope.to = moment().endOf('week').format('l')

      $scope.previousWeek = ->
        $scope.from = moment().subtract(1, 'week').startOf('week').format('l')
        $scope.to = moment().subtract(1, 'week').endOf('week').format('l')

      $scope.thisMonth = ->
        $scope.from = moment().startOf('month').format('l')
        $scope.to = moment().endOf('month').format('l')

      $scope.previousMonth = ->
        $scope.from = moment().subtract(1, 'month').startOf('month').format('l')
        $scope.to = moment().subtract(1, 'month').endOf('month').format('l')

      $scope.equalizeDates = ->
        $scope.to = $scope.from
  ]