$ ->
  renderer=
    render: (@skip_animation) ->
      @render_new(diff.added_items())
      @remove_deleted(diff.deleted_keys())
      @update_modified(diff.modified_items())

    render_value: (data) ->
      $row = $(".row[data-key='#{data.key}']")
      $row.find('.values').html($("##{data.type}_template").tmpl(data))

    render_new: (data) ->
      _.each data, (item) =>
        $elem = $('#row_template').tmpl(item)
        $elem.appendTo('#redis')
        $elem.effect('highlight', {}, 4000) unless @skip_animation

    remove_deleted: (data) ->
      _.each data, (key) =>
        $(".row[data-key='#{key}']").hide('blind').remove()

    update_modified: (data) ->
      _.each data, (item) =>
        $row = $(".row[data-key='#{item.key}']")
        $elem = $('#row_template').tmpl(item)
        $row.replaceWith($elem)
        $elem.effect('highlight', {}, 4000)

  window.renderer = renderer
