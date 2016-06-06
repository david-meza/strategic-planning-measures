(function($) {

  $(document).on('page:change', function() {

    if ( $('.initiative_planning_guides.new, .initiative_planning_guides.create, .initiative_planning_guides.edit, .initiative_planning_guides.update').length === 0 ) { return; }

    $('#initiative_planning_guide_major_milestones').froalaEditor({
      toolbarInline: false,
      placeholderText: 'Timeline and expected deliverables'
    });

    $('#initiative_planning_guide_initiative_overview').froalaEditor({
      placeholderText: 'What problem is being solved? What are the current challenges or concerns? What is the current status of the initiative?'
    });


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