require 'test_helper'

class DetalleCursosControllerTest < ActionController::TestCase
  setup do
    @detalle_curso = detalle_cursos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:detalle_cursos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create detalle_curso" do
    assert_difference('DetalleCurso.count') do
      post :create, detalle_curso: { cantidad: @detalle_curso.cantidad, curso_id: @detalle_curso.curso_id, descripcion: @detalle_curso.descripcion, importe: @detalle_curso.importe, vencimiento: @detalle_curso.vencimiento }
    end

    assert_redirected_to detalle_curso_path(assigns(:detalle_curso))
  end

  test "should show detalle_curso" do
    get :show, id: @detalle_curso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @detalle_curso
    assert_response :success
  end

  test "should update detalle_curso" do
    patch :update, id: @detalle_curso, detalle_curso: { cantidad: @detalle_curso.cantidad, curso_id: @detalle_curso.curso_id, descripcion: @detalle_curso.descripcion, importe: @detalle_curso.importe, vencimiento: @detalle_curso.vencimiento }
    assert_redirected_to detalle_curso_path(assigns(:detalle_curso))
  end

  test "should destroy detalle_curso" do
    assert_difference('DetalleCurso.count', -1) do
      delete :destroy, id: @detalle_curso
    end

    assert_redirected_to detalle_cursos_path
  end
end
