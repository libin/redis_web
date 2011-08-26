$ ->
  $.ajax
    url: window.location.hash
    type: 'get'
    dataType: 'json'
    success: (data) ->
      window.diff = new Diff({})
      diff.update(data)
      renderer.render(true)


# spin.js plugin
$.fn.spin = (opts) ->
  opts ||=
    length: 3
    width: 3
    radius: 6
  this.each ->
    $this = $(this)
    spinner = $this.data('spinner')

    if (spinner)
      spinner.stop()
      return this if opts == 'stop'

    if (opts != false)
      opts = $.extend({color: $this.css('color')}, opts)
      spinner = new Spinner(opts).spin(this)
      $this.data('spinner', spinner)
  return this
