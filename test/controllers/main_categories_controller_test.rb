require 'test_helper'

class MainCategoriesControllerTest < ActionController::TestCase
  setup do
    @main_category = main_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:main_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create main_category" do
    assert_difference('MainCategory.count') do
      post :create, main_category: { description: @main_category.description, name: @main_category.name }
    end

    assert_redirected_to main_category_path(assigns(:main_category))
  end

  test "should show main_category" do
    get :show, id: @main_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @main_category
    assert_response :success
  end

  test "should update main_category" do
    patch :update, id: @main_category, main_category: { description: @main_category.description, name: @main_category.name }
    assert_redirected_to main_category_path(assigns(:main_category))
  end

  test "should destroy main_category" do
    assert_difference('MainCategory.count', -1) do
      delete :destroy, id: @main_category
    end

    assert_redirected_to main_categories_path
  end
end
