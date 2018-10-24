require "application_system_test_case"

class FbPostsTest < ApplicationSystemTestCase
  setup do
    @fb_post = fb_posts(:one)
  end

  test "visiting the index" do
    visit fb_posts_url
    assert_selector "h1", text: "Fb Posts"
  end

  test "creating a Fb post" do
    visit fb_posts_url
    click_on "New Fb Post"

    click_on "Create Fb post"

    assert_text "Fb post was successfully created"
    click_on "Back"
  end

  test "updating a Fb post" do
    visit fb_posts_url
    click_on "Edit", match: :first

    click_on "Update Fb post"

    assert_text "Fb post was successfully updated"
    click_on "Back"
  end

  test "destroying a Fb post" do
    visit fb_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fb post was successfully destroyed"
  end
end
