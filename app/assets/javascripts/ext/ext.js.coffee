_.smartInclude = (array, element)->
  for e in array
    return true if _.isEqual(e, element)
  return false

_.smartDifference = (first, second)->
  _.reject first, (e)->
    _.smartInclude(second, e)