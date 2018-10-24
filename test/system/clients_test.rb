require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "creating a Client" do
    visit clients_url
    click_on "New Client"

    fill_in "Ad Account", with: @client.fb_ad_account_id
    fill_in "Is Enabled", with: @client.is_enabled
    fill_in "Main Color", with: @client.main_color
    fill_in "Name", with: @client.name
    fill_in "Page", with: @client.page_id
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "updating a Client" do
    visit clients_url
    click_on "Edit", match: :first

    fill_in "Ad Account", with: @client.fb_ad_account_id
    fill_in "Is Enabled", with: @client.is_enabled
    fill_in "Main Color", with: @client.main_color
    fill_in "Name", with: @client.name
    fill_in "Page", with: @client.page_id
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "destroying a Client" do
    visit clients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client was successfully destroyed"
  end
end
