#= require scrollPosition/ScrollPositionController

jQuery ->
  $(window).load ->
    app.ScrollPositionController.restoreScrollPosition() if app.ScrollPositionController?

  $(window).unload ->
    app.ScrollPositionController.saveScrollPosition() if app.ScrollPositionController?
