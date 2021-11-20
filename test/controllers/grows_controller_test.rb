require 'test_helper'

class GrowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grow = grows(:one)
  end

  test "should get index" do
    get grows_url
    assert_response :success
  end

  test "should get new" do
    get new_grow_url
    assert_response :success
  end

  test "should create grow" do
    assert_difference('Grow.count') do
      post grows_url, params: { grow: { description: @grow.description, end_date: @grow.end_date, flowering: @grow.flowering, start_date: @grow.start_date, substrate: @grow.substrate } }
    end

    assert_redirected_to grow_url(Grow.last)
  end

  test "should show grow" do
    get grow_url(@grow)
    assert_response :success
  end

  test "should get edit" do
    get edit_grow_url(@grow)
    assert_response :success
  end

  test "should update grow" do
    patch grow_url(@grow), params: { grow: { description: @grow.description, end_date: @grow.end_date, flowering: @grow.flowering, start_date: @grow.start_date, substrate: @grow.substrate } }
    assert_redirected_to grow_url(@grow)
  end

  test "should destroy grow" do
    assert_difference('Grow.count', -1) do
      delete grow_url(@grow)
    end

    assert_redirected_to grows_url
  end
end
