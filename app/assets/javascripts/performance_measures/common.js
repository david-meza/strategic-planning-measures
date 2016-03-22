(function($) {

  $(document).on('page:change', function() {

    if ( $('.performance_measures.new, .performance_measures.create, .performance_measures.edit, .performance_measures.update').length === 0 ) { return; }

    // Remove a factor instantly instead of when submitting the form
    $('.remove-factor').on('click', removeFields);
    
    // Remove a factor instantly instead of when submitting the form
    $('.add-factor').on('click', addFields);

    function removeFields(evt) {
      evt.preventDefault();
      $(evt.target).prev('input[type="hidden"]').val('true');
      $(evt.target).closest('[data-factor-index]').slideUp();
    }

    function logError(response, status) {
      console.log(response,status);
    }

    function addFields(evt) {
      evt.preventDefault();
      $.ajax('/performance_measures/new', {
        dataType: 'script'
      }, logError, logError);
    }

  });


})(jQuery);