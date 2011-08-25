class Diff
  constructor: (@cur) ->

  update: (latest) ->
    console.log latest
    @old = @cur
    @cur = latest
    console.log 'swapped'
    @old_keys = _.map @old, (item) -> item.key
    console.log 'mapped'
    @cur_keys = _.map @cur, (item) -> item.key

  added_items: ->
    new_keys = _.difference @cur_keys, @old_keys
    _.select @cur, (item) ->
      _.include(new_keys, item.key)

  modified_items: ->
    keys = _.intersection @old_keys, @cur_keys
    reduction = (coll, key) ->
      old_object = _.detect @old, (item) -> item.key == key
      cur_object = _.detect @cur, (item) -> item.key == key
      coll.push(cur_object) unless _.isEqual(old_object, cur_object)
    _.reduce keys, reduction, []

  deleted_keys: ->
    _.difference @old_keys, @cur_keys

window.Diff = Diff
