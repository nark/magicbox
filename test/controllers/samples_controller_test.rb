require 'test_helper'

class SamplesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get samples_index_url
    assert_response :success
  end

  test "should get show" do
    get samples_show_url
    assert_response :success
  end

end
