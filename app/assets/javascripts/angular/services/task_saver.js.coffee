'use strict'

angular.module('gs.taskSaver', []).factory 'TaskSaver', ['$http', ($http)->
  prepare = (task)->
    if task.name.id == task.name.name && _.isString(task.name.id)
      task = {
        name: task.name.name
        project_id: task.project.id
        date: task.date
        duration: task.duration
        status: task.status.name
        task_type: task.task_type.name
        description: task.description
      }
    else
      task = {
        task_id: task.name.id
        description: task.description
        duration: task.duration
        date: task.date
        status: task.status.name
      }

    task

  create = (task, callback)->
    if task.task_id?
      $http.post("/tasks/#{task.task_id}/time_entries", time_entry: task).success ->
        callback()
    else
      $http.post('/tasks', task: task).success ->
        callback()

  update = (task, callback)->
    $http.put("/tasks/#{task.id}", task: task).success ->
      callback()

  save = (task, callback)->
    task = prepare(task)
    if task.id?
      update(task, callback)
    else
      create(task, callback)

  {
    save: save
  }
]