require 'test_helper'

class CtaCtesControllerTest < ActionController::TestCase
  setup do
    @cta_cte = cta_ctes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cta_ctes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cta_cte" do
    assert_difference('CtaCte.count') do
      post :create, cta_cte: { matriculacion_id: @cta_cte.matriculacion_id, nro_cta_cte: @cta_cte.nro_cta_cte }
    end

    assert_redirected_to cta_cte_path(assigns(:cta_cte))
  end

  test "should show cta_cte" do
    get :show, id: @cta_cte
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cta_cte
    assert_response :success
  end

  test "should update cta_cte" do
    patch :update, id: @cta_cte, cta_cte: { matriculacion_id: @cta_cte.matriculacion_id, nro_cta_cte: @cta_cte.nro_cta_cte }
    assert_redirected_to cta_cte_path(assigns(:cta_cte))
  end

  test "should destroy cta_cte" do
    assert_difference('CtaCte.count', -1) do
      delete :destroy, id: @cta_cte
    end

    assert_redirected_to cta_ctes_path
  end
end
