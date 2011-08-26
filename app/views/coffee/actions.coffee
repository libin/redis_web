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
    $row = $(this).closest('.row')
    $row.toggleClass('expanded')
    if $row.hasClass('expanded')
      expand_row()
    else
      collapse_row()

  $('form a.clear').click (e) ->
    e.preventDefault()
    window.location.replace("/")

  $('select.db').change (e) ->
    $(this).closest('form').submit()

  collapse_row= ($row) ->
    $img = $(this).find('img')
    $img.attr('src', '/images/collapsed.png')
    value = $row.find(".values .value:first").text()
    $row.find(".values").html(value)

  expand_row= ($row) ->
    $img = $(this).find('img')
    $img.attr('src', '/images/expanded.png')
    $.ajax
      url: "/redis/#{$row.data('key')}"
      type: 'get'
      dataType: 'json'
      success: renderer.render_value

