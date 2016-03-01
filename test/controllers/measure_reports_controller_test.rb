require 'test_helper'

class MeasureReportsControllerTest < ActionController::TestCase
  setup do
    @measure_report = measure_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:measure_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create measure_report" do
    assert_difference('MeasureReport.count') do
      post :create, measure_report: {  }
    end

    assert_redirected_to measure_report_path(assigns(:measure_report))
  end

  test "should show measure_report" do
    get :show, id: @measure_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @measure_report
    assert_response :success
  end

  test "should update measure_report" do
    patch :update, id: @measure_report, measure_report: {  }
    assert_redirected_to measure_report_path(assigns(:measure_report))
  end

  test "should destroy measure_report" do
    assert_difference('MeasureReport.count', -1) do
      delete :destroy, id: @measure_report
    end

    assert_redirected_to measure_reports_path
  end
end
