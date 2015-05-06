'use strict'

angular.module('gs.projectFormController', []).controller 'ProjectFormController',
  ['$scope', 'ProjectSaver'
    ($scope, ProjectSaver)->
      if gon.project?
        $scope.project = gon.project
      else
        $scope.project = {users: []}

      $scope.customers = gon.customers
      $scope.users = gon.users

      $scope.updateAvailableUsers = ->
        $scope.available_users = _.smartDifference($scope.users, _.map($scope.project.users, (u)-> u.user))

      $scope.updateAvailableUsers()


      $scope.addUser = ->
        $scope.updateAvailableUsers()
        $scope.project.users.push {user: $scope.available_users[0]}

      $scope.removeUser = (index)->
        $scope.project.users.splice(index, 1)
        $scope.updateAvailableUsers()

      $scope.saveProject = ->
        ProjectSaver.save $scope.project, ->
          if gon.role == 'chief'
            window.location.href='/admin/projects'
          else
            window.location.href='/projects'
  ]