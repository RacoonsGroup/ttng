'use strict'

angular.module('gs.taskSaver', []).factory 'RelatedTaskSaver', ['$http', ($http)->
  prepare_for_create = (related_task)->
    if related_task.name.remote
      related_task.name.id = related_task.name.name

    if related_task.name.id == related_task.name.name && _.isString(related_task.name.id)
      related_task = {
        name: related_task.name.name
        project_id: related_task.project.id
        date: related_task.date
        duration: related_task.duration
        url: related_task.url
        status: related_task.status.name
        task_type: related_task.task_type.name
        description: related_task.description
      }
    else
      related_task = {
        related_task_id: related_task.name.id
        description: related_task.description
        duration: related_task.duration
        date: related_task.date
        status: related_task.status.name
      }

    related_task

  prepare_for_update = (related_task)->
    {
      id: related_task.id
      name: related_task.name.name
      project_id: related_task.project.id
      date: related_task.date
      url: related_task.url
      status: related_task.status.name
      task_type: related_task.task_type.name
      description: related_task.description
      time_entries: related_task.time_entries
    }

  create = (related_task, callback)->
    if related_task.related_task_id?
      $http.post("/related_tasks/#{related_task.related_task_id}/time_entries", time_entry: related_task).success ->
        callback()
    else
      $http.post('/related_tasks', related_task: related_task).success ->
        callback()

  update = (related_task, callback)->
    $http.put("/related_tasks/#{related_task.id}", related_task: related_task).success ->
      callback()

  save = (related_task, callback)->
    if related_task.id?
      update(prepare_for_update(related_task), callback)
    else
      create(prepare_for_create(related_task), callback)

  {
    save: save
  }
]