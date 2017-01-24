class DetalleCursosController < ApplicationController
  before_action :set_detalle_curso, only: [:show, :edit, :update, :destroy]

  # GET /detalle_cursos
  # GET /detalle_cursos.json
  def index
    @detalle_cursos = DetalleCurso.all
  end

  # GET /detalle_cursos/1
  # GET /detalle_cursos/1.json
  def show
  end

  # GET /detalle_cursos/new
  def new
    @detalle_curso = DetalleCurso.new
  end

  # GET /detalle_cursos/1/edit
  def edit
  end

  # POST /detalle_cursos
  # POST /detalle_cursos.json
  def create
    @detalle_curso = DetalleCurso.new(detalle_curso_params)

    respond_to do |format|
      if @detalle_curso.save
        format.html { redirect_to @detalle_curso, notice: 'Detalle curso was successfully created.' }
        format.json { render :show, status: :created, location: @detalle_curso }
      else
        format.html { render :new }
        format.json { render json: @detalle_curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalle_cursos/1
  # PATCH/PUT /detalle_cursos/1.json
  def update
    respond_to do |format|
      if @detalle_curso.update(detalle_curso_params)
        format.html { redirect_to @detalle_curso, notice: 'Detalle curso was successfully updated.' }
        format.json { render :show, status: :ok, location: @detalle_curso }
      else
        format.html { render :edit }
        format.json { render json: @detalle_curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalle_cursos/1
  # DELETE /detalle_cursos/1.json
  def destroy
    @detalle_curso.destroy
    respond_to do |format|
      format.html { redirect_to detalle_cursos_url, notice: 'Detalle curso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalle_curso
      @detalle_curso = DetalleCurso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detalle_curso_params
      params.require(:detalle_curso).permit(:curso_id, :cantidad, :descripcion, :vencimiento, :importe, :totalimporte)
    end
end
