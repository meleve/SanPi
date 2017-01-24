class CierreCajasController < ApplicationController
  before_action :set_cierre_caja, only: [:show, :edit, :update, :destroy]

  # GET /cierre_cajas
  # GET /cierre_cajas.json
  def index
    @cierre_cajas = CierreCaja.all
  end

  # GET /cierre_cajas/1
  # GET /cierre_cajas/1.json
  def show
  end

  # GET /cierre_cajas/new
  def new
    @cierre_caja = CierreCaja.new
    @cierre_caja.usuario_id = current_usuario.id
  end

  # GET /cierre_cajas/1/edit
  def edit
  end

  # POST /cierre_cajas
  # POST /cierre_cajas.json
  def create
    @cierre_caja = CierreCaja.new(cierre_caja_params)
    @cierre_caja.fApertura = @caja.fechaApertura
    @cierre_caja.cierre = @caja.apertura

    respond_to do |format|
      if @cierre_caja.save
        format.html { redirect_to @cierre_caja, notice: 'Cierre caja was successfully created.' }
        format.json { render :show, status: :created, location: @cierre_caja }
      else
        format.html { render :new }
        format.json { render json: @cierre_caja.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cierre_cajas/1
  # PATCH/PUT /cierre_cajas/1.json
  def update
    respond_to do |format|
      if @cierre_caja.update(cierre_caja_params)
        format.html { redirect_to @cierre_caja, notice: 'Cierre caja was successfully updated.' }
        format.json { render :show, status: :ok, location: @cierre_caja }
      else
        format.html { render :edit }
        format.json { render json: @cierre_caja.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cierre_cajas/1
  # DELETE /cierre_cajas/1.json
  def destroy
    @cierre_caja.destroy
    respond_to do |format|
      format.html { redirect_to cierre_cajas_url, notice: 'Cierre caja was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cierre_caja
      @cierre_caja = CierreCaja.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cierre_caja_params
      params.require(:cierre_caja).permit(:usuario_id, :fApertura, :fCierre, :apertura, :cierre, :entrada, :salida, :estado)
    end
end
