#= require utils/HashHelper

#
# ScrollPositionController
#
class ScrollPositionController

  constructor: ->
    @hashHelper = new app.utils.HashHelper()

  # saveScrollPosition
  saveScrollPosition: (path = @.currentPath, scrollPosition = @.currentScrollPosition()) ->
    # in case the user provides a path, we override scrollPositions one
    scrollPosition.path = path if path is not @.currentPath
    
    scrollPositions = @.getScrollPositions()

    if (indexOfResult = @hashHelper.indexOfByKeyValue(scrollPositions, 'path', scrollPosition.path)) > -1
      scrollPositions[indexOfResult] = scrollPosition
    else
      scrollPositions.push(scrollPosition)

    @.setScrollPositions(scrollPositions)

  # restoreScrollPosition
  restoreScrollPosition: (path = @.currentPath()) ->
    scrollPositions = @.getScrollPositions()

    if (indexOfResult = @hashHelper.indexOfByKeyValue(scrollPositions, 'path', path)) > -1
      scrollPosition = scrollPositions[indexOfResult]
    else
      scrollPosition = @.defaultScrollPosition()

    # the dummy call of setTimeout is needed to gap some browser issues with the load event handler
    setTimeout(->
      window.scrollTo(scrollPosition.scrollX, scrollPosition.scrollY)
    , 1)

  #
  # private
  #

  scrollPositionStorageId: ->
    'scrollPositions'
  
  getScrollPositions: ->
    scrollPositions = JSON.parse(sessionStorage.getItem(@.scrollPositionStorageId())) if sessionStorage?
    scrollPositions = [] unless scrollPositions?
    return scrollPositions

  setScrollPositions: (scrollPositions) ->
    if sessionStorage?
      sessionStorage.setItem(@.scrollPositionStorageId(), JSON.stringify(scrollPositions))

  currentPath: ->
    window.location.pathname + window.location.search

  currentScrollPosition: ->
    {
      path: @.currentPath(),
      scrollX: window.scrollX,
      scrollY: window.scrollY
    }

  defaultScrollPosition: ->
    # default to 0, 1 to hide url bar on mobile devices
    {
      path: @.currentPath(),
      scrollX: 0,
      scrollY: 1
    }

#
# On DOM ready
#
jQuery ->
  root = global ? window
  root.app.ScrollPositionController = new ScrollPositionController() unless root.app.ScrollPositionController?
