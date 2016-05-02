(function($) {

  $(document).on('page:change', function() {

    if ( $('.performance_measures.new, .performance_measures.create').length === 0 ) { return; }

    var focusAreaId;
    var objectiveRadio;
    
    // Trigger all the other functions when we change the dropdown value
    document.getElementById('objective_key_focus_area_id').addEventListener('change', showObjectives);
    
    function showObjectives(evt) {
      if (this.value === '') { return; }
      focusAreaId = this.value;
      $('#objective-selection').remove();
      objectiveRadio = $('<div class="form-group" id="objective-selection"><label class="col-md-3 control-label limit-text">Objective</label><div class="col-md-9" id="objectives-wrapper"><p>Is there an objective for this measure?</p><div class="radio"><label><input type="radio" name="optionsRadios" value="yes">Yes</label></div><div class="radio"><label><input type="radio" name="optionsRadios" value="no">No</label></div></div></div>').insertAfter('#key-focus-area-selection').hide().fadeIn('slow');
      objectiveRadio[0].addEventListener('change', changeObjectiveGroup);
    }

    function logError(response, status) {
      console.log(response,status);
    }

    function changeObjectiveGroup(evt) {
      var radioInput = evt.srcElement.value;
      var wrapper = this.querySelector('#objectives-wrapper');
      if (radioInput === 'no') {
        wrapper.innerHTML = '<p>N/A</p>';
        // Set the measurable as key focus area
        $('#performance_measure_measurable_type').val('KeyFocusArea');
        $('#objective_key_focus_area_id').attr('name', 'performance_measure[measurable_id]');
        getPerformanceMeasures('no objective');
      } else {
        // Set the measurable as objective
        $('#performance_measure_measurable_type').val('Objective');
        $.ajax('/objectives.json', {
          data: {key_focus_area_id: focusAreaId}
        }).then( generateObjectivesDropdown, logError);
      }
      objectiveRadio[0].removeEventListener('change', changeObjectiveGroup);
    }

    function generateObjectivesDropdown(response) {
      var wrapper = $('#objectives-wrapper');
      if (response.length === 0) {
        wrapper[0].innerHTML = '<p>There are no objectives for this key focus area. <a href="/objectives/new" class="btn btn-primary btn-xs">Create one?</a></p>';
        return;
      }
      wrapper[0].innerHTML = '';
      var objectiveSelect = $('<select class="form-control" name="performance_measure[measurable_id]" id="performance_measure_measurable_id"></select>').appendTo(wrapper).hide().fadeIn('slow');
      var options = '<option value="">Please Select the Key Focus Area Objective</option>';
      response.forEach(function(objective) {
        options += ('<option value="' + objective.id + '">' + objective.name + '</option>');
      })
      objectiveSelect.append(options);
      objectiveSelect.on('change', getPerformanceMeasures);
    }

    function getPerformanceMeasures(evt) {
      $('#new-measure-fields').removeClass('hide').hide().fadeIn('slow');
    }

  });


})(jQuery);