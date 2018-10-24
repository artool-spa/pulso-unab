require 'test_helper'

class FbPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fb_post = fb_posts(:one)
  end

  test "should get index" do
    get fb_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_fb_post_url
    assert_response :success
  end

  test "should create fb_post" do
    assert_difference('FbPost.count') do
      post fb_posts_url, params: { fb_post: {  } }
    end

    assert_redirected_to fb_post_url(FbPost.last)
  end

  test "should show fb_post" do
    get fb_post_url(@fb_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_fb_post_url(@fb_post)
    assert_response :success
  end

  test "should update fb_post" do
    patch fb_post_url(@fb_post), params: { fb_post: {  } }
    assert_redirected_to fb_post_url(@fb_post)
  end

  test "should destroy fb_post" do
    assert_difference('FbPost.count', -1) do
      delete fb_post_url(@fb_post)
    end

    assert_redirected_to fb_posts_url
  end
end
