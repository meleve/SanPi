require 'test_helper'

class PagosServiciosControllerTest < ActionController::TestCase
  setup do
    @pagos_servicio = pagos_servicios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagos_servicios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagos_servicio" do
    assert_difference('PagosServicio.count') do
      post :create, pagos_servicio: { monto: @pagos_servicio.monto, servicio: @pagos_servicio.servicio }
    end

    assert_redirected_to pagos_servicio_path(assigns(:pagos_servicio))
  end

  test "should show pagos_servicio" do
    get :show, id: @pagos_servicio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pagos_servicio
    assert_response :success
  end

  test "should update pagos_servicio" do
    patch :update, id: @pagos_servicio, pagos_servicio: { monto: @pagos_servicio.monto, servicio: @pagos_servicio.servicio }
    assert_redirected_to pagos_servicio_path(assigns(:pagos_servicio))
  end

  test "should destroy pagos_servicio" do
    assert_difference('PagosServicio.count', -1) do
      delete :destroy, id: @pagos_servicio
    end

    assert_redirected_to pagos_servicios_path
  end
end
