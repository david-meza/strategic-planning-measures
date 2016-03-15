(function($) {

  $(document).on('page:change', function() {

    if ( $('.measure_reports.new').length === 0 ) { return; }

    var focusAreaId;
    var objectiveRadio;
    var measuresDropdown;
    var measuresResponse;
    
    document.getElementById('objective_key_focus_area_id').addEventListener('change', showObjectives);

    function showObjectives(evt) {
      if (this.value === '') { return; }
      focusAreaId = this.value;
      $('#objective-selection').remove();
      objectiveRadio = $('<div class="form-group" id="objective-selection"><label class="col-md-3 control-label limit-text">Objective</label><div class="col-md-9" id="objectives-wrapper"><p>Is there an objective for this measure?</p><div class="radio"><label><input type="radio" name="optionsRadios" value="yes">Yes</label></div><div class="radio"><label><input type="radio" name="optionsRadios" value="no">No</label></div></div></div>').insertAfter('#key-focus-area-selection');
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
        getPerformanceMeasures('no objective');
      } else {
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
      var objectiveSelect = $('<select class="form-control" name="performance_measure[objective_id]" id="performance_measure_object_id"></select>').appendTo(wrapper);
      var options = '<option value="">Please Select the Key Focus Area Objective</option>';
      response.forEach(function(objective) {
        options += ('<option value="' + objective.id + '">' + objective.name + '</option>');
      })
      objectiveSelect.append(options);
      objectiveSelect.on('change', getPerformanceMeasures);
    }

    function getPerformanceMeasures(evt) {
      $('#measure-selection').remove();
      measuresDropdown = $('<div class="form-group" id="measure-selection"><label class="col-md-3 control-label limit-text">Measure</label><div class="col-md-9" id="measures-wrapper"></div></div>').insertAfter(objectiveRadio);

      if (evt === 'no objective') {
        $.ajax('/performance_measures.json', {
          data: { measurable_id: focusAreaId, measurable_type: 'KeyFocusArea' }
        }).then( generateMeasuresDropdown, logError);
      } else {
        if (this.value === '') { return; }
        $.ajax('/performance_measures.json', {
          data: { measurable_id: this.value, measurable_type: 'Objective' }
        }).then( generateMeasuresDropdown, logError);
      }
    }

    function generateAllMeasureFields(measure) {
      var attributes =  '<div class="form-group" id="measure-attributes">' +
                          '<label class="col-md-3 control-label limit-text">Target</label>' +
                          '<div class="col-md-3">' +
                            '<p>' + (measure.target || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Unit of Measure</label>' +
                          '<div class="col-md-3">' +
                            '<p>' + (measure.unit_of_measure || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Measurement Formula</label>' +
                          '<div class="col-md-9">' +
                            '<p>' + (measure.measurement_formula || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Data Source</label>' +
                          '<div class="col-md-9">' +
                            '<p>' + (measure.data_source || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Rationale for Target</label>' +
                          '<div class="col-md-9">' +
                            '<p>' + (measure.rationale_for_target || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Data Contact Person</label>' +
                          '<div class="col-md-3">' +
                            '<p>' + (measure.data_contact_person || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Person Reporting Data to BMS</label>' +
                          '<div class="col-md-3">' +
                            '<p>' + (measure.person_reporting_data_to_bms || 'N/A') + '</p>' +
                          '</div>' +
                          '<label class="col-md-3 control-label limit-text">Notes/Comments</label>' +
                          '<div class="col-md-9">' +
                            '<p>' + (measure.notes || '') + '</p>' +
                          '</div>' +
                        '</div>';
      $('#measure-attributes').remove();
      $(attributes).insertAfter(measuresDropdown);
      $('#report-data-panel').removeClass('hide');
      document.getElementById('measure_report_status').addEventListener('change', requireComment);
    }

    function requireComment(evt) {
      var text = evt.srcElement.value;
      var commentsField = document.getElementById('measure_report_comments');
      if (text === 'All is well with performance. Target will be or is met.') {
        commentsField.required = false;
        $('#comment-hint').remove();
      } else {
        commentsField.required = true;
        if ($('#comment-hint').length === 0) {
          $(evt.srcElement).after('<p id="comment-hint">Please provide context regarding the performance of this measure in the comments below.</p>')
        }
      }
    }

    function generateMeasuresDropdown(response) {
      var wrapper = measuresDropdown.find('#measures-wrapper');
      if (response.length === 0) {
        wrapper[0].innerHTML = '<p>No measures found. <a href="/performance_measures/new" class="btn btn-primary btn-xs">Create one?</a></p>';
        return;
      }
      measuresResponse = response;
      var measureSelect = $('<select class="form-control" name="measure_report[performance_measure_id]" id="measure_report_performance_measure_id"></select>').appendTo(wrapper);
      var options = '<option value="">Please Select the Performance Measure</option>';
      response.forEach(function(measure) {
        options += ('<option value="' + measure.id + '">' + measure.description + '</option>');
      })
      measureSelect.append(options);
      measureSelect[0].addEventListener('change', updateMeasureFields);
    }

    function updateMeasureFields(evt) {
      var measureId = Number(evt.srcElement.value);
      if (measureId === 0) { return; }
      for (var i = 0; i < measuresResponse.length; i++) {
        if (measuresResponse[i].id === measureId) {
          return generateAllMeasureFields(measuresResponse[i]);
        }
      }
    }

  });


})(jQuery);