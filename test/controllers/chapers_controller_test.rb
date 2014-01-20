require 'test_helper'

class ChapersControllerTest < ActionController::TestCase
  setup do
    @chaper = chapers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chapers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chaper" do
    assert_difference('Chaper.count') do
      post :create, chaper: { description: @chaper.description, title: @chaper.title }
    end

    assert_redirected_to chaper_path(assigns(:chaper))
  end

  test "should show chaper" do
    get :show, id: @chaper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chaper
    assert_response :success
  end

  test "should update chaper" do
    patch :update, id: @chaper, chaper: { description: @chaper.description, title: @chaper.title }
    assert_redirected_to chaper_path(assigns(:chaper))
  end

  test "should destroy chaper" do
    assert_difference('Chaper.count', -1) do
      delete :destroy, id: @chaper
    end

    assert_redirected_to chapers_path
  end
end
