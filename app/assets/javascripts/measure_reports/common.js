(function($) {

  $(document).on('page:change', function() {

    if ( $('.measure_reports.new, .measure_reports.create, .measure_reports.edit, .measure_reports.update').length === 0 ) { return; }

    // Runs on page load when the field is initially hidden (only on new)
    document.getElementById('measure_report_status').addEventListener('change', requireComment);
    
    function requireComment(evt) {
      var text = evt.srcElement.value;
      var commentsField = document.getElementById('measure_report_comments');
      if (text === 'All is well with performance. Target will be or is met.' || text === '') {
        commentsField.required = false;
        $('#comment-hint').remove();
      } else {
        commentsField.required = true;
        if ($('#comment-hint').length === 0) {
          $(evt.srcElement).after('<p id="comment-hint"><em>Please provide context regarding the performance of this measure in the comments below.</em></p>');
        }
      }
    }

  });


})(jQuery);