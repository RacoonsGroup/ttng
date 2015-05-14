'use strict'

angular.module('gs.taskFormController', []).controller 'RelatedTaskFormController',
  ['$scope', '$filter', 'RelatedTaskSearcher', 'RelatedTaskSaver', 'RemoteTaskSearcher', '$http'
    ($scope, $filter, RelatedTaskSearcher, RelatedTaskSaver, RemoteTaskSearcher, $http)->
      window.scope = $scope
      $scope.projects = gon.projects
      $scope.statuses = gon.statuses
      $scope.task_types = gon.task_types
      $scope.role = gon.role
      $scope.related_tasks = []
      $scope.compact_form = false
      $scope.edit = false

      if gon.related_task.id?
        console.log gon.related_task
        $scope.related_task = gon.related_task
        $scope.edit = true
      else
        $scope.related_task = {task_type: $scope.task_types[0], status: $scope.statuses[0], date: $filter('date')(new Date(), 'dd.MM.yyyy')}

      $scope.findTasks = (query)->
        $scope.related_tasks = []
        params = {
          name: query
        }
        params['project_id'] = $scope.related_task.project.id if $scope.related_task.project?
        RelatedTaskSearcher.search params, (data)->
          $scope.related_tasks = $scope.related_tasks.concat(data)

        if $scope.related_task.project?
          console.log 'looking for remote related_tasks'
          RemoteTaskSearcher.search $scope.related_task.project.id, query, (data)->
            $scope.related_tasks = $scope.related_tasks.concat(data)

      $scope.removeTimeEntity = (index)->
        $scope.related_task.time_entries.splice(index, 1)

      $scope.projectChanged = ->
        $scope.related_tasks = []
        $scope.compact_form = false
        $scope.related_tasks = _.filter $scope.related_tasks, (related_task)->
          related_task.project_id == $scope.related_task.project.id

      $scope.nameChanged = ->
        if $scope.related_task.name.project_id
          $scope.related_task.project = _.find $scope.projects, (p)->
            p.id == $scope.related_task.name.project_id
          $scope.compact_form = true
        else
          $scope.compact_form = false

        if $scope.related_task.name.remote
          $scope.related_task.url = $scope.related_task.name.url
          $scope.related_task.description = $scope.related_task.name.description

          $scope.related_task.task_type = _.find $scope.task_types, (t)->
            t.id == $scope.related_task.name.type

          $scope.related_task.status = _.find $scope.statuses, (t)->
            t.id == $scope.related_task.name.status

      $scope.saveRelatedTask = ->
        RelatedTaskSaver.save $scope.related_task, ->
          if $scope.role == 'chief'
            window.location.href='/admin/related_tasks'
          else
            window.location.href='/related_tasks'

      $scope.renderTask = (item, escape)->
        pivotalLogo = ->
          '<img src="/images/pivotal.png"/>'
        "<div class='related_task-row'>#{escape(item.name)}<span class='pull-right'>#{ if item.remote then pivotalLogo() else '' }</span></div>"


      $scope.urlChanged = ->
        if $scope.related_task.project?
          re = new RegExp('pivotaltracker.com/story/show/([0-9]+)')
          if re.test($scope.related_task.url)
            task_id = re.exec($scope.related_task.url)[1]
            $scope.loading_remote_task = true

            $http.get("/api/projects/#{$scope.related_task.project.id}/remote_tasks/#{task_id}").success (related_task)->
              $scope.related_tasks = [related_task]
              $scope.related_task.name = related_task
              $scope.nameChanged()
]