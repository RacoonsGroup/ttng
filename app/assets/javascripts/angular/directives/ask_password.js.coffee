'use strict'

angular.module('gs.askPassword', []).directive 'askPassword', [->
  link: (scope, elem, attrs, ngModel) ->    
    elem.on 'click', (e)->
      addParameterToURL = (url, param)->
        url + (if url.indexOf('?') > 0 then '&' else '?') + param;

      e.preventDefault()
      scope.password = ''
      scope.$apply()
      angular.element('#password_modal').modal()

      scope.$on 'password_entered', (e, password)->
        window.location.href = addParameterToURL(elem.attr('href'), "password=#{password}")
]