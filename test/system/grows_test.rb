require "application_system_test_case"

class GrowsTest < ApplicationSystemTestCase
  setup do
    @grow = grows(:one)
  end

  test "visiting the index" do
    visit grows_url
    assert_selector "h1", text: "Grows"
  end

  test "creating a Grow" do
    visit grows_url
    click_on "New Grow"

    fill_in "Description", with: @grow.description
    fill_in "End date", with: @grow.end_date
    fill_in "Flowering", with: @grow.flowering
    fill_in "Start date", with: @grow.start_date
    fill_in "Substrate", with: @grow.substrate
    click_on "Create Grow"

    assert_text "Grow was successfully created"
    click_on "Back"
  end

  test "updating a Grow" do
    visit grows_url
    click_on "Edit", match: :first

    fill_in "Description", with: @grow.description
    fill_in "End date", with: @grow.end_date
    fill_in "Flowering", with: @grow.flowering
    fill_in "Start date", with: @grow.start_date
    fill_in "Substrate", with: @grow.substrate
    click_on "Update Grow"

    assert_text "Grow was successfully updated"
    click_on "Back"
  end

  test "destroying a Grow" do
    visit grows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Grow was successfully destroyed"
  end
end
