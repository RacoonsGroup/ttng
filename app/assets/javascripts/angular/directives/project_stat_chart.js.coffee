'use strict'

angular.module('gs.projectStatChart', []).directive 'projectStatChart', [->
  restrict: 'A',

  link: (scope, elem, attrs) ->
    data = [
      {
        value: parseInt(attrs.bugs),
        color: '#F7464A',
        highlight: '#FF5A5E',
        label: 'Bugs'
      },
      {
        value: parseInt(attrs.tasks),
        color: '#46BFBD',
        highlight: '#5AD3D1',
        label: 'Tasks'
      },
      {
        value: parseInt(attrs.chores),
        color: '#FDB45C',
        highlight: '#FFC870',
        label: 'Chores'
      }
    ]

    myNewChart = new Chart(elem.get(0).getContext('2d')).Pie(data);
]