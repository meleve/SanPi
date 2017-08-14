class AlumnosController < ApplicationController
  before_action :set_alumno, only: [:show, :edit, :update, :destroy]
  autocomplete :alumno, :ci, :full => true

  # GET /alumnos
  # GET /alumnos.json

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
  end
  
  autocomplete :alumno, :ci, :display_value => :ci, :extra_data => [:nombre, :apellido,:fechanac, :lugarnac, :domicilio, :nombrema, :profesionma, :cel, :nombrepa, :porfesionpa, :celpa] do |items|
    respond_to do |format|
     format.json { render :json => @items }
    end
  end

  def index
    #if params[:term]
      #@alumnos = Alumno.where("ci LIKE '%"+params[:term]+"%'")
    #else
       @alumnos = Alumno.all
        #respond_to do |format|
        #format.html
        #format.json { render :json => @alumnos }
      #end
    #end
  end


  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
  end

  def detallespago
  end
  # GET /alumnos/new
  def buscar
    @alumno = Alumno.new
  end
  def busqueda
    @alumno = Alumno.new
    @alumnos = Alumno.where(nombrema: params[:alumno][:nombrema])
  end

  def new
    if params[:term]
      @alumnos = Alumno.where("ci LIKE '%"+params[:term]+"%'")
    else
        @alumnos = Alumno.all
        @alumno = Alumno.new
    end
  end

  # GET /alumnos/1/edit
  def edit
  end


  # POST /alumnos
  # POST /alumnos.json
#AL INSCRIBIRSE LE ALUMNO YA SE GENERA LA CUENTA CORRIENTE CORRESPONDIENTE
  def create
    @alumno = Alumno.new(alumno_params)

    respond_to do |format|
      if @alumno.save
        @matriculacion = Matriculacion.create(alumno_id: @alumno.id, curso_id: params[:curso][:curso_id])
        if @matriculacion
           @cta_cte = CtaCte.new
            @cta_cte.matriculacion_id = @matriculacion.id
            @cta_cte.nro_cta_cte = @matriculacion.id
            @cta_cte.save

            @detalle_cursos = DetalleCurso.where(curso_id: @matriculacion.curso_id)

            @movimiento = Movimiento.new

            @detalle_cursos.each do |detalle|
              (1..detalle.cantidad).each do |i|
                @movimiento = Movimiento.create(cta_cte_id: @cta_cte.id, nro_mov:  i, descripcion: detalle.descripcion , importe: detalle.importe , estado: false)
                sumaimporte = @cta_cte.montoimporte.to_i + detalle.importe.to_i
                @cta_cte.update(montoimporte: sumaimporte)
              end
            end
        format.html { redirect_to @matriculacion, notice: 'Se ha m registrado correctamente.' }
        format.json { render :show, status: :created, location: @matriculacion }
        end
        format.html { redirect_to @matriculacion, notice: 'Se ha registrado correctamente.' }
        format.json { render :show, status: :created, location: @matriculacion }
      else
        format.html { render :new }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnos/1
  # PATCH/PUT /alumnos/1.json
  def update
    respond_to do |format|
      if @alumno.update(alumno_params)
        format.html { redirect_to @alumno, notice: 'Se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @alumno }
      else
        format.html { render :edit }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno.destroy
    respond_to do |format|
      format.html { redirect_to alumnos_url, notice: 'Ha eliminado correctamente al alumno.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno
      @alumno = Alumno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alumno_params
      params.require(:alumno).permit(:nombre, :apellido, :ci, :fechanac, :lugarnac, :domicilio, :nombrema, :profesionma, :cel, :nombrepa, :porfesionpa, :celpa, curso_attributes:[:curso, :especialidad, :seccion, :year, :_destroy])
    end
end
