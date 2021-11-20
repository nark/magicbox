require 'test_helper'

class HarvestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @harvest = harvests(:one)
  end

  test "should get index" do
    get harvests_url
    assert_response :success
  end

  test "should get new" do
    get new_harvest_url
    assert_response :success
  end

  test "should create harvest" do
    assert_difference('Harvest.count') do
      post harvests_url, params: { harvest: { dry_bud_weight: @harvest.dry_bud_weight, dry_trim_weight: @harvest.dry_trim_weight, grow: @harvest.grow, havested_bud_weight: @harvest.havested_bud_weight, havested_trim_weight: @harvest.havested_trim_weight, havested_waste_weight: @harvest.havested_waste_weight } }
    end

    assert_redirected_to harvest_url(Harvest.last)
  end

  test "should show harvest" do
    get harvest_url(@harvest)
    assert_response :success
  end

  test "should get edit" do
    get edit_harvest_url(@harvest)
    assert_response :success
  end

  test "should update harvest" do
    patch harvest_url(@harvest), params: { harvest: { dry_bud_weight: @harvest.dry_bud_weight, dry_trim_weight: @harvest.dry_trim_weight, grow: @harvest.grow, havested_bud_weight: @harvest.havested_bud_weight, havested_trim_weight: @harvest.havested_trim_weight, havested_waste_weight: @harvest.havested_waste_weight } }
    assert_redirected_to harvest_url(@harvest)
  end

  test "should destroy harvest" do
    assert_difference('Harvest.count', -1) do
      delete harvest_url(@harvest)
    end

    assert_redirected_to harvests_url
  end
end
