require 'test_helper'

class PerformanceMeasuresControllerTest < ActionController::TestCase
  setup do
    @performance_measure = performance_measures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performance_measures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performance_measure" do
    assert_difference('PerformanceMeasure.count') do
      post :create, performance_measure: { created_by_user_id: @performance_measure.created_by_user_id, data_contact_person: @performance_measure.data_contact_person, data_source: @performance_measure.data_source, description: @performance_measure.description, measurable_id: @performance_measure.measurable_id, measurable_type: @performance_measure.measurable_type, measurement_formula: @performance_measure.measurement_formula, notes: @performance_measure.notes, person_reporting_data_to_bms: @performance_measure.person_reporting_data_to_bms, rationale_for_target: @performance_measure.rationale_for_target, target: @performance_measure.target, unit_of_measure: @performance_measure.unit_of_measure }
    end

    assert_redirected_to performance_measure_path(assigns(:performance_measure))
  end

  test "should show performance_measure" do
    get :show, id: @performance_measure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performance_measure
    assert_response :success
  end

  test "should update performance_measure" do
    patch :update, id: @performance_measure, performance_measure: { created_by_user_id: @performance_measure.created_by_user_id, data_contact_person: @performance_measure.data_contact_person, data_source: @performance_measure.data_source, description: @performance_measure.description, measurable_id: @performance_measure.measurable_id, measurable_type: @performance_measure.measurable_type, measurement_formula: @performance_measure.measurement_formula, notes: @performance_measure.notes, person_reporting_data_to_bms: @performance_measure.person_reporting_data_to_bms, rationale_for_target: @performance_measure.rationale_for_target, target: @performance_measure.target, unit_of_measure: @performance_measure.unit_of_measure }
    assert_redirected_to performance_measure_path(assigns(:performance_measure))
  end

  test "should destroy performance_measure" do
    assert_difference('PerformanceMeasure.count', -1) do
      delete :destroy, id: @performance_measure
    end

    assert_redirected_to performance_measures_path
  end
end
