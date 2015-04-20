moment.fn.startOfIteration = ->
  if @isFirstIteration()
    @startOf('month')
  else
    @date(16)

moment.fn.endOfIteration = ->
  if @isFirstIteration()
    @date(15)
  else
    @endOf('month')

moment.fn.isFirstIteration = ->
  @date() < 16

moment.fn.isSecondIteration = ->
  !@isFirstIteration()

moment.fn.startOfPreviousIteration = ->
  if @isFirstIteration()
    @startOf('month').subtract(1, 'day').startOfIteration()
  else
    @startOf('month').date(15).startOfIteration()

moment.fn.endOfPreviousIteration = ->
  if @isFirstIteration()
    @startOf('month').subtract(1, 'day').endOfIteration()
  else
    @startOfIteration().subtract(1, 'day')