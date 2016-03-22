require 'test_helper'

class PerformanceFactorEntriesControllerTest < ActionController::TestCase
  setup do
    @performance_factor_entry = performance_factor_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performance_factor_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performance_factor_entry" do
    assert_difference('PerformanceFactorEntry.count') do
      post :create, performance_factor_entry: { comments: @performance_factor_entry.comments, data: @performance_factor_entry.data, measure_report_id: @performance_factor_entry.measure_report_id, performance_factor_id: @performance_factor_entry.performance_factor_id }
    end

    assert_redirected_to performance_factor_entry_path(assigns(:performance_factor_entry))
  end

  test "should show performance_factor_entry" do
    get :show, id: @performance_factor_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performance_factor_entry
    assert_response :success
  end

  test "should update performance_factor_entry" do
    patch :update, id: @performance_factor_entry, performance_factor_entry: { comments: @performance_factor_entry.comments, data: @performance_factor_entry.data, measure_report_id: @performance_factor_entry.measure_report_id, performance_factor_id: @performance_factor_entry.performance_factor_id }
    assert_redirected_to performance_factor_entry_path(assigns(:performance_factor_entry))
  end

  test "should destroy performance_factor_entry" do
    assert_difference('PerformanceFactorEntry.count', -1) do
      delete :destroy, id: @performance_factor_entry
    end

    assert_redirected_to performance_factor_entries_path
  end
end
