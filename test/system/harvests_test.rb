require "application_system_test_case"

class HarvestsTest < ApplicationSystemTestCase
  setup do
    @harvest = harvests(:one)
  end

  test "visiting the index" do
    visit harvests_url
    assert_selector "h1", text: "Harvests"
  end

  test "creating a Harvest" do
    visit harvests_url
    click_on "New Harvest"

    fill_in "Dry bud weight", with: @harvest.dry_bud_weight
    fill_in "Dry trim weight", with: @harvest.dry_trim_weight
    fill_in "Grow", with: @harvest.grow
    fill_in "Havested bud weight", with: @harvest.havested_bud_weight
    fill_in "Havested trim weight", with: @harvest.havested_trim_weight
    fill_in "Havested waste weight", with: @harvest.havested_waste_weight
    click_on "Create Harvest"

    assert_text "Harvest was successfully created"
    click_on "Back"
  end

  test "updating a Harvest" do
    visit harvests_url
    click_on "Edit", match: :first

    fill_in "Dry bud weight", with: @harvest.dry_bud_weight
    fill_in "Dry trim weight", with: @harvest.dry_trim_weight
    fill_in "Grow", with: @harvest.grow
    fill_in "Havested bud weight", with: @harvest.havested_bud_weight
    fill_in "Havested trim weight", with: @harvest.havested_trim_weight
    fill_in "Havested waste weight", with: @harvest.havested_waste_weight
    click_on "Update Harvest"

    assert_text "Harvest was successfully updated"
    click_on "Back"
  end

  test "destroying a Harvest" do
    visit harvests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Harvest was successfully destroyed"
  end
end
