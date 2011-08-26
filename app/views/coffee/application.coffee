$ ->
  $.ajax
    url: window.location.hash
    type: 'get'
    dataType: 'json'
    success: (data) ->
      window.diff = new Diff({})
      diff.update(data)
      renderer.render(true)
