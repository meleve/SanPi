class CursosController < ApplicationController
  before_action :set_curso, only: [:show, :edit, :update, :destroy]

  # GET /cursos
  # GET /cursos.json
  def index
    @cursos = Curso.all
  end

  # GET /cursos/1
  # GET /cursos/1.json
  def show
    @matriculacions = Matriculacion.where(curso_id: @curso.id)
  end

  # GET /cursos/new
  def new
    @curso = Curso.new
  end

  # GET /cursos/1/edit
  def edit
  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(curso_params)
    #@detalle_curso = DetalleCurso.new(detalle_curso_params)
    
#CREA LOS DETALLES DEL CURSO, LAS CANTIDAD DE CUOTAS
    respond_to do |format|
      if @curso.save
         @detalle_cursos = DetalleCurso.where(curso_id: @curso.id)
         @resultado=0
         @detalle_cursos.each do |detalle|
          @resultado = detalle.cantidad * detalle.importe
          if (@curso.montototal != nil)
           @curso.update(montototal: @resultado + @curso.montototal)
          else
           @curso.update(montototal: @resultado)
          end
        end
        format.html { redirect_to @curso, notice: 'El curso se creo correctamente' }
        format.json { render :show, status: :created, location: @curso }
      else
        format.html { render :new }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cursos/1
  # PATCH/PUT /cursos/1.json
  def update
    respond_to do |format|
      if @curso.update(curso_params)
        format.html { redirect_to @curso, notice: 'Se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @curso }
      else
        format.html { render :edit }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso.destroy
    respond_to do |format|
      format.html { redirect_to cursos_url, notice: 'Se elimino el curso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curso_params
      params.require(:curso).permit(:curso, :especialidad, :seccion, :year, :montototal, detalle_cursos_attributes: [ :curso_id, :cantidad, :descripcion, :vencimiento, :importe, :_destroy ])
    end
end
