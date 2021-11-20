require 'test_helper'

class ScenariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scenario = scenarios(:one)
  end

  test "should get index" do
    get scenarios_url
    assert_response :success
  end

  test "should get new" do
    get new_scenario_url
    assert_response :success
  end

  test "should create scenario" do
    assert_difference('Scenario.count') do
      post scenarios_url, params: { scenario: { description: @scenario.description, name: @scenario.name, subject_id: @scenario.subject_id } }
    end

    assert_redirected_to scenario_url(Scenario.last)
  end

  test "should show scenario" do
    get scenario_url(@scenario)
    assert_response :success
  end

  test "should get edit" do
    get edit_scenario_url(@scenario)
    assert_response :success
  end

  test "should update scenario" do
    patch scenario_url(@scenario), params: { scenario: { description: @scenario.description, name: @scenario.name, subject_id: @scenario.subject_id } }
    assert_redirected_to scenario_url(@scenario)
  end

  test "should destroy scenario" do
    assert_difference('Scenario.count', -1) do
      delete scenario_url(@scenario)
    end

    assert_redirected_to scenarios_url
  end
end
