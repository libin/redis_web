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
      $.ajax
        url: "/redis/#{$row.data('key')}"
        type: 'get'
        dataType: 'json'
        success: render_value
    else
      $img.attr('src', '/images/collapsed.png')
      value = $row.find(".values .value:first").text()
      $row.find(".values").html(value)

  render_value= (data) ->
    $row = $(".row[data-key='#{data.key}']")
    $row.find('.values').html($("##{data.type}_template").tmpl(data))

  $('form a.clear').click (e) ->
    e.preventDefault()
    $input = $(this).closest('form').find('input:text')
    $input.val('')
    $(this).closest('form').submit()

  $('select.db').change (e) ->
    $(this).closest('form').submit()

  initial_render= (data) ->
    window.diff = new Diff(data)
    _.each data, (element) ->
      $('#row_template').tmpl(element).appendTo('#redis')

  $.ajax
    url: window.location.hash
    type: 'get'
    dataType: 'json'
    success: initial_render

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

  poller = ->
    $.ajax
      url: window.location.hash
      type: 'get'
      dataType: 'html'
      success: poll_success

  poll_success = (data) ->
    diff.update(data)
    # render_new(diff.added_items)
    # remove_deleted(diff.deleted_keys)
    # update_modified(diff.modified_items)

  render_new = (data) ->
    _.each data, (item) ->
      $('#row_template').tmpl(item).appendTo('#redis')

  remove_deleted = (data) ->
    _.each data, (key) ->
      $(".row[data-key='#{key}']").remove()

  update_modified = (data) ->
    _.each data, (item) ->
      $row = $(".row[data-key='#{item.key}']")
      $row.replace($('#row_template').tmpl(item).appendTo('#redis'))
