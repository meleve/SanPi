class CajasController < ApplicationController
  before_action :set_caja, only: [:show, :edit, :update, :destroy]

  # GET /cajas
  # GET /cajas.json
  def index
    @cajas = Caja.all
  end

  def cajaabierto
    @cajaabierto = Caja.where(estado: 0).last
   end

  # GET /cajas/1
  # GET /cajas/1.json
  def show
    @mov_caja = MovCaja.where(caja_id: @caja.id)
  end

  # GET /cajas/new
  def new
    @caja = Caja.new
    @caja.usuario_id = current_usuario.id
  end

  # GET /cajas/1/edit
  def edit
    @caja.estado = 1
    @caja.fechaCierre = Time.now
  end

  # POST /cajas
  # POST /cajas.json
#SE CREA LA CAJA INGRESANDO EL MONTO DE APERTURA
  def create
    @caja = Caja.new(caja_params)
    @caja.fechaCierre = nil
    @caja.entrada = @caja.apertura
    @caja.cierre = @caja.apertura
    respond_to do |format|
      if @caja.save
         @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: 'Apertura de caja', ingreso: @caja.apertura, egreso: 0, saldo: @caja.apertura)
        format.html { redirect_to @caja, notice: 'Se creo correctamente la caja.' }
        format.json { render :show, status: :created, location: @caja }
      else
        format.html { render :new }
        format.json { render json: @caja.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cajas/1
  # PATCH/PUT /cajas/1.json
  def update
    respond_to do |format|
      if @caja.update(caja_params)
        format.html { redirect_to @caja, notice: 'Se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @caja }
      else
        format.html { render :edit }
        format.json { render json: @caja.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cajas/1
  # DELETE /cajas/1.json
  def destroy
    @caja.destroy
    respond_to do |format|
      format.html { redirect_to cajas_url, notice: 'Caja was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caja
      @caja = Caja.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caja_params
      params.require(:caja).permit(:usuario_id, :fechaApertura, :fechaCierre, :apertura, :cierre, :entrada, :salida, :estado)
    end
end
