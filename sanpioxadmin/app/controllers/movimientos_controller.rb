class MovimientosController < ApplicationController
  before_action :set_movimiento, only: [:show, :edit, :update, :destroy]

  # GET /movimientos
  # GET /movimientos.json
  def index
    @movimientos = Movimiento.all
  end

  # GET /movimientos/1
  # GET /movimientos/1.json
  def show
  end

  # GET /movimientos/new
  def new
    @movimiento = Movimiento.new
  end

  # GET /movimientos/1/edit
  def edit
  end

  # POST /movimientos
  # POST /movimientos.json
  def create
    @movimiento = Movimiento.new(movimiento_params)

    respond_to do |format|
      if @movimiento.save
        format.html { redirect_to @movimiento, notice: 'Se ha registrado correctamente.' }
        format.json { render :show, status: :created, location: @movimiento }
      else
        format.html { render :new }
        format.json { render json: @movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movimientos/1
  # PATCH/PUT /movimientos/1.json
  def update
    respond_to do |format|
      @monto = 0
      timporte = 0
      impo = 0
      cMonto = 0
      mTotal = 0
      resultado = 0
      @cta_c = CtaCte.find(@movimiento.cta_cte_id)
      @m = Matriculacion.find(@cta_c.matriculacion_id)

      if @movimiento.estado == false
          if @movimiento.update(movimiento_params)
              impo = @movimiento.importe
              mTotal = @movimiento.totalimporte
              resultado = impo.to_i - mTotal.to_i
              if @movimiento.update(importe: resultado)
                if @movimiento.importe == 0
                  @movimiento.estado = 1
                  @movimiento.update(estado: @movimiento.estado)
                end
              end
            #
            @cta_ct = CtaCte.find(@movimiento.cta_cte_id)
            cMonto = @cta_ct.montoimporte
            monto = cMonto.to_i - mTotal.to_i
            @cta_ct.update(montoimporte: monto)
            @matriculacion = Matriculacion.find(@cta_ct.matriculacion_id)
            format.html { redirect_to @matriculacion, notice: 'Se ha actualizado correctamente' }
            format.json { render :show, status: :ok, location: @matriculacion }
          else
            format.html { render :edit }
            format.json { render json: @movimiento.errors, status: :unprocessable_entity }
          end
      else
        format.html { redirect_to @matriculacion, notice: 'Ya no se puede pagar.' }
        format.json { render :show, status: :ok, location: @matriculacion }
      end
    end
  end

  # DELETE /movimientos/1
  # DELETE /movimientos/1.json
  def destroy
    @movimiento.destroy
    respond_to do |format|
      format.html { redirect_to movimientos_url, notice: 'Movimiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pago_conjunto
    cta = CtaCte.new
    id = 0
    params[:movimientos_id].each do |id|
      movimiento = Movimiento.find(id)
      cta_cte = CtaCte.find(movimiento.cta_cte_id)
      id = cta_cte.id
      saldo = cta_cte.montoimporte.to_i - movimiento.importe.to_i
      cta_cte.update(montoimporte: saldo.to_i)

      @caja = Caja.where(estado: 0).last
      @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: movimiento.descripcion, ingreso: movimiento.importe.to_i, egreso: 0, saldo: @caja.cierre.to_i + movimiento.importe.to_i)
      @caja.update(cierre: @caja.cierre.to_i + movimiento.importe.to_i, entrada:  @caja.entrada.to_i + movimiento.importe.to_i)
      movimiento.update(importe: 0, estado: true)
    end
    if params[:productos_id] != nil
      params[:productos_id].each do |pid|
         producto = Producto.find(pid)
         cant = params[pid]
         resultado = producto.cantidad.to_i - cant.to_i
         producto.update(cantidad: resultado)

         @caja = Caja.where(estado: 0).last
         @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: "Venta de "+producto.nombreproduct, ingreso: cant.to_i * producto.precio.to_i, egreso: 0, saldo: @caja.cierre.to_i + (cant.to_i * producto.precio.to_i))
         @caja.update(cierre: @caja.cierre.to_i + (cant.to_i * producto.precio.to_i), entrada:  @caja.entrada.to_i + (cant.to_i * producto.precio.to_i))
      end
    end
    respond_to do |format|
      params[:movimientos_id].each do |id|
        movimiento = Movimiento.find(id)
        cta_cte = CtaCte.find(movimiento.cta_cte_id)
        matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
        format.html { redirect_to matriculacion, notice: 'Movimiento was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end 

  def pago_masivo
    cta = CtaCte.new
    id = 0
    params[:movimientos_id].each do |id|
      movimiento = Movimiento.find(id)
      cta_cte = CtaCte.find(movimiento.cta_cte_id)
      id = cta_cte.id
      saldo = cta_cte.montoimporte.to_i - movimiento.importe.to_i
      cta_cte.update(montoimporte: saldo.to_i)

      @caja = Caja.where(estado: 0).last
      @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: movimiento.descripcion, ingreso: movimiento.importe.to_i, egreso: 0, saldo: @caja.cierre.to_i + movimiento.importe.to_i)
      @caja.update(cierre: @caja.cierre.to_i + movimiento.importe.to_i, entrada:  @caja.entrada.to_i + movimiento.importe.to_i)
      movimiento.update(importe: 0, estado: true)
    end
    respond_to do |format|
      params[:movimientos_id].each do |id|
        movimiento = Movimiento.find(id)
        cta_cte = CtaCte.find(movimiento.cta_cte_id)
        matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
        format.html { redirect_to matriculacion, notice: 'Movimiento was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movimiento
      @movimiento = Movimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movimiento_params
      params.require(:movimiento).permit(:cta_cte_id, :nro_mov, :descripcion, :importe, :estado, :totalimporte)
    end
end
