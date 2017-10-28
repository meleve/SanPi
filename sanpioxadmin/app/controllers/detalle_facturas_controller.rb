class DetalleFacturasController < ApplicationController
  before_action :set_detalle_factura, only: [:show, :edit, :update, :destroy]

  # GET /detalle_facturas
  # GET /detalle_facturas.json
  def index
    @detalle_facturas = DetalleFactura.all
  end

  # GET /detalle_facturas/1
  # GET /detalle_facturas/1.json
  def show
  end

  # GET /detalle_facturas/new
  def new
    @detalle_factura = DetalleFactura.new
  end

  # GET /detalle_facturas/1/edit
  def edit
  end

  # POST /detalle_facturas
  # POST /detalle_facturas.json
  def create
    @detalle_factura = DetalleFactura.new(detalle_factura_params)

    respond_to do |format|
      if @detalle_factura.save
        format.html { redirect_to @detalle_factura, notice: 'Detalle factura was successfully created.' }
        format.json { render :show, status: :created, location: @detalle_factura }
      else
        format.html { render :new }
        format.json { render json: @detalle_factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalle_facturas/1
  # PATCH/PUT /detalle_facturas/1.json
  def update
    respond_to do |format|
      if @detalle_factura.update(detalle_factura_params)
        format.html { redirect_to @detalle_factura, notice: 'Detalle factura was successfully updated.' }
        format.json { render :show, status: :ok, location: @detalle_factura }
      else
        format.html { render :edit }
        format.json { render json: @detalle_factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalle_facturas/1
  # DELETE /detalle_facturas/1.json
  def destroy
    @detalle_factura.destroy
    respond_to do |format|
      format.html { redirect_to detalle_facturas_url, notice: 'Detalle factura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalle_factura
      @detalle_factura = DetalleFactura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detalle_factura_params
      params.require(:detalle_factura).permit(:factura_id, :matriculacion_id, :nro_mov, :descripcion, :importe)
    end
end
