'use strict'

angular.module('gs.dateRangeSelector', []).directive 'dateRangeSelector', [->
  template: '<div class="btn-toolbar">' +
    '<div class="btn-group">' +
    '<button class="btn btn-default btn-xs" ng-click="today()" type="button">Today</button>' +
    '<button class="btn btn-default btn-xs" ng-click="yesterday()" type="button">Yesterday</button></div>' +
    '<div class="btn-group"><button class="btn btn-default btn-xs" ng-click="thisIteration()" type="button">This iteration</button>' +
    '<button class="btn btn-default btn-xs" ng-click="previousIteration()" type="button">Previous iteration</button></div>' +
    '<div class="btn-group"><button class="btn btn-default btn-xs" ng-click="thisWeek()" type="button">This week</button>' +
    '<button class="btn btn-default btn-xs" ng-click="previousWeek()" type="button">Previous week</button></div>' +
    '<div class="btn-group"><button class="btn btn-default btn-xs" ng-click="thisMonth()" type="button">This month</button>' +
    '<button class="btn btn-default btn-xs" ng-click="previousMonth()" type="button">Previous month</button></div></div>'

  controller: ($scope)->
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
]