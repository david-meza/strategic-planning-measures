(function($) {

  $(document).on('page:change', function() {

    if ( $('.measure_reports.edit, .measure_reports.update').length === 0 ) { return; }

    document.getElementById('measure_report_status').addEventListener('change', requireComment);
    
    function requireComment(evt) {
      console.log('here');
      var text = evt.srcElement.value;
      var commentsField = document.getElementById('measure_report_comments');
      if (text === 'All is well with performance. Target will be or is met.') {
        commentsField.required = false;
        $('#comment-hint').remove();
      } else {
        commentsField.required = true;
        if ($('#comment-hint').length === 0) {
          $(evt.srcElement).after('<p id="comment-hint"><em>Please provide context regarding the performance of this measure in the comments below.</em></p>')
        }
      }
    }

  });


})(jQuery);