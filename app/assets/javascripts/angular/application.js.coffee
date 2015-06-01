'use strict'

app = angular.module('TTNG', [
  'ng-rails-csrf',
  'gs.selectize2',
  'gs.projectFormController',
  'gs.projectSaver',
  'gs.taskFormController',
  'gs.datepicker',
  'gs.taskSearcher',
  'gs.taskSaver',
  'gs.tooltip',
  'gs.ngInitial',
  'gs.askPassword',
  'gs.projectShowController',
  'gs.projectStatChart',
  'gs.iterationStatChart',
  'gs.exportController',
  'gs.dateRangeSelector',
  'gs.dateEqualizer',
  'gs.remoteTaskSearcher',
  'xeditable',
  'restangular'
])

app.run(editableOptions) ->
  editableOptions.theme = 'bs3'
  return