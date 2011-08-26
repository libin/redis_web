$ ->
  interval_id = null

  $('a.poll').live 'click', (e) ->
    e.preventDefault()
    if interval_id?
      $(this).text('live poll')
      clearInterval(interval_id)
      interval_id = null
      $('#spinner').spin('stop')
    else
      $(this).text('polling...')
      interval_id = setInterval(poll, 2000)
      $('#spinner').spin()

  poll = ->
    $.ajax
      url: window.location.hash
      type: 'get'
      dataType: 'json'
      success: (data) ->
        diff.update(data)
        renderer.render()
