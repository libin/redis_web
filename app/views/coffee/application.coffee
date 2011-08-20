$ ->
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

  $('a.toggle_expand').live 'click', (e) ->
    e.preventDefault()
    $img = $(this).find('img')
    $row = $(this).closest('.row')
    $row.toggleClass('expanded')
    if $row.hasClass('expanded')
      $img.attr('src', '/images/expanded.png')
    else
      $img.attr('src', '/images/collapsed.png')

  $('form a.clear').click (e) ->
    e.preventDefault()
    $input = $(this).closest('form').find('input:text')
    $input.val('')
    $(this).closest('form').submit()

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
