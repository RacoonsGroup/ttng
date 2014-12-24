'use strict'

angular.module('gs.iterationStatChart', []).directive 'iterationStatChart', [->
  restrict: 'A',

  link: (scope, elem, attrs) ->
    total = parseInt(attrs.hours)
    finished = parseFloat(attrs.finished)

    overtime = if finished > total then finished - total else 0

    if overtime != 0
      data = [
        {
          value: overtime,
          color: '#F7464A',
          highlight: '#FF5A5E',
          label: 'Overtime'
        },
        {
          value: finished
          color: '#46BFBD',
          highlight: '#5AD3D1',
          label: 'Finished'
        }
      ]
    else
      data = [
        {
          value: total-finished,
          color: '#F7464A',
          highlight: '#FF5A5E',
          label: 'Left'
        },
        {
          value: finished
          color: '#46BFBD',
          highlight: '#5AD3D1',
          label: 'Finished'
        }
      ]

    myNewChart = new Chart(elem.get(0).getContext('2d')).Pie(data, animation: false);
]