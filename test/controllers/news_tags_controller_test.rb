require 'test_helper'

class NewsTagsControllerTest < ActionController::TestCase
  setup do
    @news_tag = news_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:news_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create news_tag" do
    assert_difference('NewsTag.count') do
      post :create, news_tag: { link: @news_tag.link, title: @news_tag.title }
    end

    assert_redirected_to news_tag_path(assigns(:news_tag))
  end

  test "should show news_tag" do
    get :show, id: @news_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @news_tag
    assert_response :success
  end

  test "should update news_tag" do
    patch :update, id: @news_tag, news_tag: { link: @news_tag.link, title: @news_tag.title }
    assert_redirected_to news_tag_path(assigns(:news_tag))
  end

  test "should destroy news_tag" do
    assert_difference('NewsTag.count', -1) do
      delete :destroy, id: @news_tag
    end

    assert_redirected_to news_tags_path
  end
end
