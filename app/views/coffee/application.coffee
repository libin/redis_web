$ ->
  $('#redis .row').live 'click', (e) ->
    $row = $(this)
    height = 18
    $row.toggleClass('expanded')

  $('a.delete').live 'click', (e) ->
    e.preventDefault()
    url = $(this).attr('href')
    $row = $(this).closest('.row')
    $row.hide('blind').remove()
    $.ajax
      url:      url
      type:     'post'
      dataType: 'json'
      data:
        '_method': 'delete'

  intervalId = null
  $('a.poll').live 'click', (e) ->
    e.preventDefault()
    if intervalId?
      $(this).text('live poll')
      clearInterval intervalId
      intervalId = null
    else
      $(this).text('polling...')
      intervalId = setInterval(poller, 2000)

  poller= ->
    url = window.location.href
    $.ajax
      url: url
      type: 'get'
      dataType: 'html'
      success: poll_success

  poll_success= (data) ->
    $('#redis').html(data)
