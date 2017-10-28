require 'test_helper'

class CierreCajasControllerTest < ActionController::TestCase
  setup do
    @cierre_caja = cierre_cajas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cierre_cajas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cierre_caja" do
    assert_difference('CierreCaja.count') do
      post :create, cierre_caja: { apertura: @cierre_caja.apertura, cierre: @cierre_caja.cierre, entrada: @cierre_caja.entrada, estado: @cierre_caja.estado, fApertura: @cierre_caja.fApertura, fCierre: @cierre_caja.fCierre, salida: @cierre_caja.salida, usuario_id: @cierre_caja.usuario_id }
    end

    assert_redirected_to cierre_caja_path(assigns(:cierre_caja))
  end

  test "should show cierre_caja" do
    get :show, id: @cierre_caja
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cierre_caja
    assert_response :success
  end

  test "should update cierre_caja" do
    patch :update, id: @cierre_caja, cierre_caja: { apertura: @cierre_caja.apertura, cierre: @cierre_caja.cierre, entrada: @cierre_caja.entrada, estado: @cierre_caja.estado, fApertura: @cierre_caja.fApertura, fCierre: @cierre_caja.fCierre, salida: @cierre_caja.salida, usuario_id: @cierre_caja.usuario_id }
    assert_redirected_to cierre_caja_path(assigns(:cierre_caja))
  end

  test "should destroy cierre_caja" do
    assert_difference('CierreCaja.count', -1) do
      delete :destroy, id: @cierre_caja
    end

    assert_redirected_to cierre_cajas_path
  end
end
