// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function($) {

  $(document).on('page:change', function() {

    if ( $('.initiative_planning_guides.new, .initiative_planning_guides.create, .initiative_planning_guides.edit, .initiative_planning_guides.update').length === 0 ) { return; }

    $('.update-year-link').on('click', removeOverlay);
    
    function removeOverlay(evt) {
      evt.preventDefault();
      $(evt.target).closest('.editable-year').fadeOut('fast');
      $('#initiative_planning_guide_initiative_plan_years_attributes_0_year').focus();
    }

  });


})(jQuery);