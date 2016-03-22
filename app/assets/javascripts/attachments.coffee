ready = ->
  $("[data-toggle='popover']").popover()
$(document).ready ready
$(document).on 'page:load', ready
