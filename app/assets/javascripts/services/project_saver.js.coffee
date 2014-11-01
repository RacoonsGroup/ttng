'use strict'

angular.module('gs.projectSaver', []).factory 'ProjectSaver', ['$http', ($http)->
  create = (project, callback)->
    $http.post('/admin/projects', project: project).success ->
      callback()

  update = (project, callback)->
    $http.put("/admin/projects/#{project.id}", project: project).success ->
      callback()

  save = (project, callback)->
    if project.id?
      update(project, callback)
    else
      create(project, callback)
  {
    save: save
  }
]