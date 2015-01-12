'use strict'

angular.module('gs.remoteTaskSearcher', []).factory 'RemoteTaskSearcher', ['$http', ($http)->
  search = (project_id, query, callback)->
    $http(method: 'get', url: "/api/projects/#{project_id}/remote_tasks", params: { query: query }).success (data)->
      callback(data)

  {
  search: search
  }
]