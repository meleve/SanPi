require 'test_helper'

class MatriculacionsControllerTest < ActionController::TestCase
  setup do
    @matriculacion = matriculacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matriculacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matriculacion" do
    assert_difference('Matriculacion.count') do
      post :create, matriculacion: { alumno_id: @matriculacion.alumno_id, curso_id: @matriculacion.curso_id }
    end

    assert_redirected_to matriculacion_path(assigns(:matriculacion))
  end

  test "should show matriculacion" do
    get :show, id: @matriculacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matriculacion
    assert_response :success
  end

  test "should update matriculacion" do
    patch :update, id: @matriculacion, matriculacion: { alumno_id: @matriculacion.alumno_id, curso_id: @matriculacion.curso_id }
    assert_redirected_to matriculacion_path(assigns(:matriculacion))
  end

  test "should destroy matriculacion" do
    assert_difference('Matriculacion.count', -1) do
      delete :destroy, id: @matriculacion
    end

    assert_redirected_to matriculacions_path
  end
end
