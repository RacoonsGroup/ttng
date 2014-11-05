'use strict'

angular.module('gs.taskFormController', []).controller 'TaskFormController',
  ['$scope', '$filter', 'TaskSearcher', 'TaskSaver'
    ($scope, $filter, TaskSearcher, TaskSaver)->
      window.scope = $scope
      $scope.projects = gon.projects
      $scope.statuses = gon.statuses
      $scope.task_types = gon.task_types
      $scope.tasks = []
      $scope.compact_form = false
      $scope.edit = false

      if gon.task.id?
        $scope.task = gon.task
        $scope.edit = true
      else
        $scope.task = {task_type: $scope.task_types[0], status: $scope.statuses[0], date: $filter('date')(new Date(), 'dd.MM.yyyy')}

      $scope.findTask = (query)->
        $scope.tasks = []
        params = {
          name: query
        }
        params['project_id'] = $scope.task.project.id if $scope.task.project?
        TaskSearcher.search params, (data)->
          $scope.tasks = data

      $scope.removeTimeEntity = (index)->
        $scope.task.time_entries.splice(index, 1)

      $scope.projectChanged = ->
        $scope.tasks = []
        $scope.compact_form = false
        $scope.tasks = _.filter $scope.tasks, (task)->
          task.project_id == $scope.task.project.id

      $scope.nameChanged = ->
        if $scope.task.name.project_id
          $scope.task.project = _.find $scope.projects, (p)->
            p.id == $scope.task.name.project_id
          $scope.compact_form = true
        else
          $scope.compact_form = false

      $scope.saveTask = ->
        TaskSaver.save $scope.task, ->
          window.location.href='/tasks'
]