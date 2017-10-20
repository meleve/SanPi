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
  #actualiza el estado de la cuenta corriente 
  def update
    respond_to do |format|
      @monto = 0
      timporte = 0
      impo = 0
      cMonto = 0
      mTotal = 0
      resultado = 0
      @total = 0
      id = 0
      @cta_c = CtaCte.find(@movimiento.cta_cte_id)
      @m = Matriculacion.find(@cta_c.matriculacion_id)
      #el monto impo = es el total del importe adeudado
      #el mTotal = a la entrega parcial o total que realiza 
      #se resta el importe parcial o total con el importe real
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
            #cMonto = es el importe total adeudado
            #el mTotal = a la entrega parcial o total que realiza
            @cta_ct = CtaCte.find(@movimiento.cta_cte_id)
            cMonto = @cta_ct.montoimporte
            monto = cMonto.to_i - mTotal.to_i
            @cta_ct.update(montoimporte: monto)
            @matriculacion = Matriculacion.find(@cta_ct.matriculacion_id)
            #crea movimiento de pago parcial
            @caja = Caja.where(estado: 0).last
            @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: @movimiento.descripcion, ingreso: @movimiento.totalimporte.to_i, egreso: 0, saldo: @caja.cierre.to_i + @movimiento.totalimporte.to_i)
             resultado = impo.to_i - mTotal.to_i
            @caja.update(cierre: @caja.cierre.to_i + @movimiento.totalimporte.to_i, entrada:  @caja.entrada.to_i + @movimiento.totalimporte.to_i)
            @movimiento.update(importe: resultado, estado: @movimiento.estado)

            format.html { redirect_to @matriculacion, notice: 'Se registro el pago correctamente' }
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

        #crea la factura
        factura = Factura.create!(usuario_id: current_usuario.id, alumno_id: @matriculacion.alumno_id, total: @total)
        factura.update(nro_fac: factura.id)
        respond_to do |format|
          params[:movimientos_id].each do |id|
            movimiento = Movimiento.find(id)
            cta_cte = CtaCte.find(movimiento.cta_cte_id)
            matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
            detallefactura = DetalleFactura.create!(factura_id: factura.id, matriculacion_id: matriculacion.id, nro_mov: movimiento.nro_mov, descripcion: movimiento.descripcion, importe: movimiento.totalimporte)
            
            movimiento.update(importe: 0, estado: true)
            format.html { redirect_to factura, notice: 'Factura creada' }
            format.json { render :show, status: :ok, location: factura }
          end
        end
  end

  # DELETE /movimientos/1
  # DELETE /movimientos/1.json
  def destroy
    @movimiento.destroy
    respond_to do |format|
      format.html { redirect_to movimientos_url }
      format.json { head :no_content }
    end
  end
  #usa en show de matriculacion 
  def pago_conjunto
    cta = CtaCte.new
    id = 0
    @total = 0
    @matriculacion = nil

    params[:movimientos_id].each do |id|
      movimiento = Movimiento.find(id)
      cta_cte = CtaCte.find(movimiento.cta_cte_id)
      id = cta_cte.id
      #montoimporte = es el importe total adeudado
      #importe = al pago total de la deuda LA ENTREGA
      saldo = cta_cte.montoimporte.to_i - movimiento.importe.to_i
      cta_cte.update(montoimporte: saldo.to_i)
      #crear movimiento 
      @caja = Caja.where(estado: 0).last
      @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: movimiento.descripcion, ingreso: movimiento.importe.to_i, egreso: 0, saldo: @caja.cierre.to_i + movimiento.importe.to_i)
      @total = @total.to_i + movimiento.importe.to_i
      @caja.update(cierre: @caja.cierre.to_i + movimiento.importe.to_i, entrada:  @caja.entrada.to_i + movimiento.importe.to_i)
      movimiento.update(importe: 0, estado: true)

      @matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
    end
    matriculacion = nil
    factura = nil
    #CREA FACTURA
    factura = Factura.create!(usuario_id: current_usuario.id, alumno_id: @matriculacion.alumno_id, total: @total)
    factura.update(nro_fac: factura.id)
    respond_to do |format|
      params[:movimientos_id].each do |id|
        movimiento = Movimiento.find(id)
        cta_cte = CtaCte.find(movimiento.cta_cte_id)
        matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
        detallefactura = DetalleFactura.create!(factura_id: factura.id, matriculacion_id: matriculacion.id, nro_mov: movimiento.nro_mov, descripcion: movimiento.descripcion, importe: movimiento.importe)
        
        movimiento.update(importe: movimiento.totalimporte.to_i + detallefactura.importe.to_i, estado: true)
        format.html { redirect_to factura, notice: 'Movimiento was successfully destroyed.' }
        format.json { render :show, status: :ok, location: factura }
      end
    end

    #seleccion de producto
    if params[:productos_id] != nil
      params[:productos_id].each do |pid|
         producto = Producto.find(pid)
         cant = params[pid]
         resultado = producto.cantidad.to_i - cant.to_i
         producto.update(cantidad: resultado)

         @caja = Caja.where(estado: 0).last
         @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: "Venta de "+producto.nombreproduct, ingreso: cant.to_i * producto.precio.to_i, egreso: 0, saldo: @caja.cierre.to_i + (cant.to_i * producto.precio.to_i))
         @caja.update(cierre: @caja.cierre.to_i + (cant.to_i * producto.precio.to_i), entrada:  @caja.entrada.to_i + (cant.to_i * producto.precio.to_i))
         detallefactura = DetalleFactura.create!(factura_id: factura.id, matriculacion_id: matriculacion.id, nro_mov: nil, descripcion: "Pago de: "+producto.nombreproduct, importe: producto.precio.to_i*cant.to_i)
        
      end
    end
  end 

  #pago_masivo se usa para el buscador que esta en alumnos imprime la factura
  def pago_masivo
    cta = CtaCte.new
    id = 0
    @total = 0
    @matriculacion = nil
    params[:movimientos_id].each do |id|
      movimiento = Movimiento.find(id)
      cta_cte = CtaCte.find(movimiento.cta_cte_id)
      id = cta_cte.id
      saldo = cta_cte.montoimporte.to_i - movimiento.importe.to_i
      cta_cte.update(montoimporte: saldo.to_i)

      @caja = Caja.where(estado: 0).last
      @mov_caja = MovCaja.create!(caja_id: @caja.id, concepto: movimiento.descripcion, ingreso: movimiento.importe.to_i, egreso: 0, saldo: @caja.cierre.to_i + movimiento.importe.to_i)
      @total = @total.to_i + movimiento.importe.to_i
      @caja.update(cierre: @caja.cierre.to_i + movimiento.importe.to_i, entrada:  @caja.entrada.to_i + movimiento.importe.to_i)
      
      @matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
    end
    #crea la factura
    factura = Factura.create!(usuario_id: current_usuario.id, alumno_id: @matriculacion.alumno_id, total: @total)
    factura.update(nro_fac: factura.id)
    respond_to do |format|
      params[:movimientos_id].each do |id|
        movimiento = Movimiento.find(id)
        cta_cte = CtaCte.find(movimiento.cta_cte_id)
        matriculacion = Matriculacion.find(cta_cte.matriculacion_id)
        detallefactura = DetalleFactura.create!(factura_id: factura.id, matriculacion_id: matriculacion.id, nro_mov: movimiento.nro_mov, descripcion: movimiento.descripcion, importe: movimiento.importe)
        
        movimiento.update(importe: 0, estado: true)
        format.html { redirect_to factura, notice: 'Movimiento was successfully destroyed.' }
        format.json { render :show, status: :ok, location: factura }
      end
    end
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nro_fac
      @ultimofactura = Factura.select(:id).last
      if @ultimofactura = nil
       return 1
      else
        @ultimofactura = @ultimofactura.to_i + 1
        return @ultimofactura
      end
    end

    def set_movimiento
      @movimiento = Movimiento.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def movimiento_params
      params.require(:movimiento).permit(:cta_cte_id, :nro_mov, :descripcion, :importe, :estado, :totalimporte)
    end
end
