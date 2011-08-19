$ ->
  $('#redis .row .values').click (e) ->
    row = $(this).closest('.row')
    if row.data('expanded')
      row.removeData('expanded')
      $(this).children('.value').css('display', 'inline-block')
      row.css('height', '18px')
    else
      row.data('expanded')
      console.log row.data('expanded', true)
      $(this).children('.value').css('display', 'block')
      row.css('height', 'auto')

  $('a.delete').click (e) ->
    e.preventDefault()
    url = $(this).attr('href')
    $row = $(this).closest('.row')
    $row.hide('blinds')
    $row.remove()
    $.ajax
      url: url
      type: 'post'
      dataType: 'json'
      data:
        '_method': 'delete'
