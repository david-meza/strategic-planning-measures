require 'test_helper'

class PerformanceFactorsControllerTest < ActionController::TestCase
  setup do
    @performance_factor = performance_factors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performance_factors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performance_factor" do
    assert_difference('PerformanceFactor.count') do
      post :create, performance_factor: { field_type: @performance_factor.field_type, label_text: @performance_factor.label_text, performance_measure_id: @performance_factor.performance_measure_id }
    end

    assert_redirected_to performance_factor_path(assigns(:performance_factor))
  end

  test "should show performance_factor" do
    get :show, id: @performance_factor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performance_factor
    assert_response :success
  end

  test "should update performance_factor" do
    patch :update, id: @performance_factor, performance_factor: { field_type: @performance_factor.field_type, label_text: @performance_factor.label_text, performance_measure_id: @performance_factor.performance_measure_id }
    assert_redirected_to performance_factor_path(assigns(:performance_factor))
  end

  test "should destroy performance_factor" do
    assert_difference('PerformanceFactor.count', -1) do
      delete :destroy, id: @performance_factor
    end

    assert_redirected_to performance_factors_path
  end
end
