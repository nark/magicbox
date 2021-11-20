require 'test_helper'

class DataTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @data_type = data_types(:one)
  end

  test "should get index" do
    get data_types_url, as: :json
    assert_response :success
  end

  test "should create data_type" do
    assert_difference('DataType.count') do
      post data_types_url, params: { data_type: { name: @data_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show data_type" do
    get data_type_url(@data_type), as: :json
    assert_response :success
  end

  test "should update data_type" do
    patch data_type_url(@data_type), params: { data_type: { name: @data_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy data_type" do
    assert_difference('DataType.count', -1) do
      delete data_type_url(@data_type), as: :json
    end

    assert_response 204
  end
end
