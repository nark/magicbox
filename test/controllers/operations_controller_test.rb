require 'test_helper'

class OperationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation = operations(:one)
  end

  test "should get index" do
    get operations_url
    assert_response :success
  end

  test "should get new" do
    get new_operation_url
    assert_response :success
  end

  test "should create operation" do
    assert_difference('Operation.count') do
      post operations_url, params: { operation: { command: @operation.command, condition_id: @operation.condition_id, delay: @operation.delay, description: @operation.description, device_id: @operation.device_id, retries: @operation.retries } }
    end

    assert_redirected_to operation_url(Operation.last)
  end

  test "should show operation" do
    get operation_url(@operation)
    assert_response :success
  end

  test "should get edit" do
    get edit_operation_url(@operation)
    assert_response :success
  end

  test "should update operation" do
    patch operation_url(@operation), params: { operation: { command: @operation.command, condition_id: @operation.condition_id, delay: @operation.delay, description: @operation.description, device_id: @operation.device_id, retries: @operation.retries } }
    assert_redirected_to operation_url(@operation)
  end

  test "should destroy operation" do
    assert_difference('Operation.count', -1) do
      delete operation_url(@operation)
    end

    assert_redirected_to operations_url
  end
end
