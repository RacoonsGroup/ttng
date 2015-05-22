'use strict'

angular.module('gs.taskSearcher', []).factory 'RelatedTaskSearcher', ['$http', ($http)->
  search = (params, callback)->
    $http(method: 'get', url: '/tasks/find', params: params).success (data)->
      callback(data)

  {
    search: search
  }
]