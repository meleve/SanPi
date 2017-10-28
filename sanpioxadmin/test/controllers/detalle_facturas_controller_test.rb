require 'test_helper'

class DetalleFacturasControllerTest < ActionController::TestCase
  setup do
    @detalle_factura = detalle_facturas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:detalle_facturas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create detalle_factura" do
    assert_difference('DetalleFactura.count') do
      post :create, detalle_factura: { descripcion: @detalle_factura.descripcion, factura_id: @detalle_factura.factura_id, importe: @detalle_factura.importe, matriculacion_id: @detalle_factura.matriculacion_id, nro_mov: @detalle_factura.nro_mov }
    end

    assert_redirected_to detalle_factura_path(assigns(:detalle_factura))
  end

  test "should show detalle_factura" do
    get :show, id: @detalle_factura
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @detalle_factura
    assert_response :success
  end

  test "should update detalle_factura" do
    patch :update, id: @detalle_factura, detalle_factura: { descripcion: @detalle_factura.descripcion, factura_id: @detalle_factura.factura_id, importe: @detalle_factura.importe, matriculacion_id: @detalle_factura.matriculacion_id, nro_mov: @detalle_factura.nro_mov }
    assert_redirected_to detalle_factura_path(assigns(:detalle_factura))
  end

  test "should destroy detalle_factura" do
    assert_difference('DetalleFactura.count', -1) do
      delete :destroy, id: @detalle_factura
    end

    assert_redirected_to detalle_facturas_path
  end
end
