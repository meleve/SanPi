class MatriculacionsController < ApplicationController
  before_action :set_matriculacion, only: [:show, :edit, :update, :destroy]

  # GET /matriculacions
  # GET /matriculacions.json

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
  end
  
  def index
    @matriculacions = Matriculacion.where("curso_id LIKE ? ","%1%")
  end
  def index2
    @matriculacions = Matriculacion.where("curso_id LIKE ? ","%2%")
  end
  def index3
    @matriculacions = Matriculacion.where("curso_id LIKE ? ","%3%")
  end


  # GET /matriculacions/1
  # GET /matriculacions/1.json
  def show
    @cta_cte = CtaCte.find(@matriculacion.id) 
    @movimientos = Movimiento.where(cta_cte_id: @cta_cte.id)
  end

  # GET /matriculacions/new
  def new
    @matriculacion = Matriculacion.new
    @alumno = Alumno.new
  end

  # GET /matriculacions/1/edit
  def edit
  end

  # POST /matriculacions
  # POST /matriculacions.json
  def create
    @matriculacion = Matriculacion.new(matriculacion_params)

    respond_to do |format|
      if @matriculacion.save
      @cta_cte = CtaCte.new
      @cta_cte.matriculacion_id = @matriculacion.id
      @cta_cte.nro_cta_cte = @matriculacion.id
      @cta_cte.save
      #@curso = Curso.find(@matriculacion.curso_id)
      #@detalle_cursos = DetalleCurso.all
      @detalle_cursos = DetalleCurso.where(curso_id: @matriculacion.curso_id)
      @suma = 0
      @movimiento = Movimiento.new
      @detalle_cursos.each do |detalle|
        (1..detalle.cantidad).each do |i|
          @movimiento = Movimiento.create(cta_cte_id: @cta_cte.id, nro_mov:  i, descripcion: detalle.descripcion , importe: detalle.importe , estado: false)
          @cta_ct = CtaCte.find(@cta_cte.id)
          @suma += detalle.importe
          @cta_ct.update(montoimporte: @suma)
        end
      end
        

        format.html { redirect_to @matriculacion, notice: 'Se creo correctamente' }
        format.json { render :show, status: :created, location: @matriculacion }
      else
        format.html { render :new }
        format.json { render json: @matriculacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matriculacions/1
  # PATCH/PUT /matriculacions/1.json
  def update
    respond_to do |format|
      if @matriculacion.update(matriculacion_params)
        format.html { redirect_to @matriculacion, notice: 'Matriculacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @matriculacion }
      else
        format.html { render :edit }
        format.json { render json: @matriculacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matriculacions/1
  # DELETE /matriculacions/1.json
  def destroy
    @matriculacion.destroy
    respond_to do |format|
      format.html { redirect_to matriculacions_url, notice: 'Matriculacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_multiple
    @matriculacions = Matriculacion.find(params[:matriculacions_id])
  end

  def update_multiple
    params[:matriculacions].keys.each do |matriculacion|
      @matriculacion = Matriculacion.create(params[:matriculacions].values)
     
    @matriculacion = Matriculacion.find(matriculacion.to_i)
      @cta_cte = CtaCte.new
      @cta_cte.matriculacion_id = @matriculacion.id
      @cta_cte.nro_cta_cte = @matriculacion.id
      @cta_cte.save
      #@curso = Curso.find(@matriculacion.curso_id)
      #@detalle_cursos = DetalleCurso.all
      @detalle_cursos = DetalleCurso.where(curso_id: @matriculacion.curso_id)

      @movimiento = Movimiento.new

      @detalle_cursos.each do |detalle|
        (1..detalle.cantidad).each do |i|
          @movimiento = Movimiento.create(cta_cte_id: @cta_cte.id, nro_mov:  i, descripcion: detalle.descripcion , importe: detalle.importe , estado: false)
          
        end
      end
    end
    #Matriculacion.update(params[:matriculacions].keys, params[:matriculacions].values)
    redirect_to matriculacions_url
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matriculacion
      @matriculacion = Matriculacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matriculacion_params
      params.require(:matriculacion).permit(:alumno_id, :curso_id)
    end

    def alumno_params
      params.require(:alumno).permit(:nombre, :apellido, :ci, :fechanac, :lugarnac, :domicilio, :nombrema, :profesionma, :cel, :nombrepa, :porfesionpa, :celpa)
    end

    def curso_params
      params.require(:curso).permit(:curso, :especialidad, :seccion, :year, detalle_curso_attributes: [ :curso_id, :cantidad, :descripcion, :vencimiento, :importe, :totalimporte, :_destroy ])
    end

    
end
