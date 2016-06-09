(function($) {

  $(document).on('page:change', function() {

    if ( $('.initiative_planning_guides.new, .initiative_planning_guides.create, .initiative_planning_guides.edit, .initiative_planning_guides.update').length === 0 ) { return; }

    $('#initiative_planning_guide_linked_measure_ids').select2({
      theme: 'bootstrap'
    });

    $('a[href="https://froala.com/wysiwyg-editor"]').parent().remove();

    $('.update-year-link').on('click', removeOverlay);

    $('.remove-fields').on('click', removeFields);
    
    function removeFields(evt) {
      evt.preventDefault();
      var $fieldsMarkerForDeletion = $(evt.target).prev('input[type="hidden"]').val('true').detach();
      $(evt.target).closest('[data-fields-index]').slideUp();
      $('form').append($fieldsMarkerForDeletion);
    }
    
    function removeOverlay(evt) {
      evt.preventDefault();
      $(evt.target).closest('.editable-year').fadeOut('fast');
      $('#initiative_planning_guide_initiative_plan_years_attributes_0_year').focus();
    }

  });


})(jQuery);