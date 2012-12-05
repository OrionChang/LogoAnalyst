require 'test_helper'

class GlobalCompaniesControllerTest < ActionController::TestCase
  setup do
    @global_company = global_companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:global_companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create global_company" do
    assert_difference('GlobalCompany.count') do
      post :create, global_company: {}
    end

    assert_redirected_to global_company_path(assigns(:global_company))
  end

  test "should show global_company" do
    get :show, id: @global_company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @global_company
    assert_response :success
  end

  test "should update global_company" do
    put :update, id: @global_company, global_company: {}
    assert_redirected_to global_company_path(assigns(:global_company))
  end

  test "should destroy global_company" do
    assert_difference('GlobalCompany.count', -1) do
      delete :destroy, id: @global_company
    end

    assert_redirected_to global_companies_path
  end
end
