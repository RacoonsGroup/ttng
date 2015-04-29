'use strict'

angular.module('gs.taskFormController', []).controller 'TaskFormController',
  ['$scope', '$filter', 'RelatedTaskSearcher', 'TaskSaver', 'RemoteTaskSearcher', '$http'
    ($scope, $filter, RelatedTaskSearcher, TaskSaver, RemoteTaskSearcher, $http)->
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

      $scope.findTasks = (query)->
        $scope.tasks = []
        params = {
          name: query
        }
        params['project_id'] = $scope.task.project.id if $scope.task.project?
        RelatedTaskSearcher.search params, (data)->
          $scope.tasks = $scope.tasks.concat(data)

        if $scope.task.project?
          console.log 'looking for remote tasks'
          RemoteTaskSearcher.search $scope.task.project.id, query, (data)->
            $scope.tasks = $scope.tasks.concat(data)

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

        if $scope.task.name.remote
          $scope.task.url = $scope.task.name.url
          $scope.task.description = $scope.task.name.description

          $scope.task.task_type = _.find $scope.task_types, (t)->
            t.id == $scope.task.name.type

          $scope.task.status = _.find $scope.statuses, (t)->
            t.id == $scope.task.name.status

      $scope.saveTask = ->
        TaskSaver.save $scope.task, ->
          window.location.href='/tasks'

      $scope.renderTask = (item, escape)->
        pivotalLogo = ->
          '<img src="/images/pivotal.png"/>'
        "<div class='task-row'>#{escape(item.name)}<span class='pull-right'>#{ if item.remote then pivotalLogo() else '' }</span></div>"


      $scope.urlChanged = ->
        if $scope.task.project?
          re = new RegExp('pivotaltracker.com/story/show/([0-9]+)')
          if re.test($scope.task.url)
            task_id = re.exec($scope.task.url)[1]
            $scope.loading_remote_task = true

            $http.get("/api/projects/#{$scope.task.project.id}/remote_tasks/#{task_id}").success (task)->
              $scope.tasks = [task]
              $scope.task.name = task
              $scope.nameChanged()
]