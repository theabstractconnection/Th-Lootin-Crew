require "application_system_test_case"

class VesselsTest < ApplicationSystemTestCase
  setup do
    @vessel = vessels(:one)
  end

  test "visiting the index" do
    visit vessels_url
    assert_selector "h1", text: "Vessels"
  end

  test "creating a Vessel" do
    visit vessels_url
    click_on "New Vessel"

    click_on "Create Vessel"

    assert_text "Vessel was successfully created"
    click_on "Back"
  end

  test "updating a Vessel" do
    visit vessels_url
    click_on "Edit", match: :first

    click_on "Update Vessel"

    assert_text "Vessel was successfully updated"
    click_on "Back"
  end

  test "destroying a Vessel" do
    visit vessels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vessel was successfully destroyed"
  end
end
