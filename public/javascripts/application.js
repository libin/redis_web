$(document).ready(function(){

  prettyPrint();

  $('.delete_record').live('click', function(ev){
    var row = $(this).closest('tr');

    $.ajax({
      url        : '/redis/' + $(this).data('key'),
      type       : 'delete',
      beforeSend : function(){ row.addClass('disabled') },
      success    : row.fadeOut('fast')
    });
  });


  $('#delete_all').live('click', function(ev) {
    $.ajax({
      url        : '/redis/',
      type       : 'delete',
      success    : location.reload()
    });
  });

  $('#db_selector').live('change', function(ev) {
    $.ajax({
      url        : '/redis/' + $(this).val(),
      type       : 'put',
      success    : location.reload()
    });
  });
});
