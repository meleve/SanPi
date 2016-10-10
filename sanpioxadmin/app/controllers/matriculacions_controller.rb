class MatriculacionsController < ApplicationController
  before_action :set_matriculacion, only: [:show, :edit, :update, :destroy]

  # GET /matriculacions
  # GET /matriculacions.json

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
  end
  
  def index
    @matriculacions = Matriculacion.all
  end

  # GET /matriculacions/1
  # GET /matriculacions/1.json
  def show
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
        format.html { redirect_to @matriculacion, notice: 'Matriculacion was successfully created.' }
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
end
