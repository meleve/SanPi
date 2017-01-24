class PagosServiciosController < ApplicationController
  before_action :set_pagos_servicio, only: [:show, :edit, :update, :destroy]

  # GET /pagos_servicios
  # GET /pagos_servicios.json
  def index
    @pagos_servicios = PagosServicio.all
  end

  # GET /pagos_servicios/1
  # GET /pagos_servicios/1.json
  def show
  end

  # GET /pagos_servicios/new
  def new
    @pagos_servicio = PagosServicio.new
  end

  # GET /pagos_servicios/1/edit
  def edit
  end

  # POST /pagos_servicios
  # POST /pagos_servicios.json
  def create
    @pagos_servicio = PagosServicio.new(pagos_servicio_params)
    respond_to do |format|
      if @pagos_servicio.save
        @caja = Caja.where(estado: 0).last
        @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: @pagos_servicio.servicio, ingreso: 0, egreso: @pagos_servicio.monto, saldo: @caja.cierre.to_i - @pagos_servicio.monto.to_i)
        @caja.update(cierre: @caja.cierre.to_i - @pagos_servicio.monto.to_i, salida:  @caja.salida.to_i + @pagos_servicio.monto.to_i)
        format.html { redirect_to @pagos_servicio, notice: 'Pagos servicio was successfully created.' }
        format.json { render :show, status: :created, location: @pagos_servicio }
      else
        format.html { render :new }
        format.json { render json: @pagos_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagos_servicios/1
  # PATCH/PUT /pagos_servicios/1.json
  def update
    respond_to do |format|
      if @pagos_servicio.update(pagos_servicio_params)
        format.html { redirect_to @pagos_servicio, notice: 'Pagos servicio was successfully updated.' }
        format.json { render :show, status: :ok, location: @pagos_servicio }
      else
        format.html { render :edit }
        format.json { render json: @pagos_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagos_servicios/1
  # DELETE /pagos_servicios/1.json
  def destroy
    @pagos_servicio.destroy
    respond_to do |format|
      format.html { redirect_to pagos_servicios_url, notice: 'Pagos servicio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pagos_servicio
      @pagos_servicio = PagosServicio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pagos_servicio_params
      params.require(:pagos_servicio).permit(:servicio, :monto)
    end
end
