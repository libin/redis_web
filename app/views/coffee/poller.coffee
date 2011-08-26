$ ->
  intervalId = null

  $('a.poll').live 'click', (e) ->
    e.preventDefault()
    if intervalId?
      $(this).text('live poll')
      clearInterval intervalId
      intervalId = null
    else
      $(this).text('polling...')
      intervalId = setInterval(poll, 2000)
      # spinner?

  poll = ->
    $.ajax
      url: window.location.hash
      type: 'get'
      dataType: 'json'
      success: (data) ->
        diff.update(data)
        renderer.render()
