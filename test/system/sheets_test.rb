require "application_system_test_case"

class SheetsTest < ApplicationSystemTestCase
  setup do
    @sheet = sheets(:one)
  end

  test "visiting the index" do
    visit sheets_url
    assert_selector "h1", text: "Sheets"
  end

  test "creating a Sheet" do
    visit sheets_url
    click_on "New Sheet"

    fill_in "Client", with: @sheet.client_id
    fill_in "Gss", with: @sheet.gss_id
    fill_in "Gss Permalink", with: @sheet.gss_permalink
    fill_in "Is Enabled", with: @sheet.is_enabled
    fill_in "Last Update", with: @sheet.last_update
    fill_in "Name", with: @sheet.name
    click_on "Create Sheet"

    assert_text "Sheet was successfully created"
    click_on "Back"
  end

  test "updating a Sheet" do
    visit sheets_url
    click_on "Edit", match: :first

    fill_in "Client", with: @sheet.client_id
    fill_in "Gss", with: @sheet.gss_id
    fill_in "Gss Permalink", with: @sheet.gss_permalink
    fill_in "Is Enabled", with: @sheet.is_enabled
    fill_in "Last Update", with: @sheet.last_update
    fill_in "Name", with: @sheet.name
    click_on "Update Sheet"

    assert_text "Sheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Sheet" do
    visit sheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sheet was successfully destroyed"
  end
end
