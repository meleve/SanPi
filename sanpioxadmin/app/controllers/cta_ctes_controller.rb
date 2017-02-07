class CtaCtesController < ApplicationController
  before_action :set_cta_cte, only: [:show, :edit, :update, :destroy]

  # GET /cta_ctes
  # GET /cta_ctes.json
  def index
    @cta_ctes = CtaCte.all
  end

  # GET /cta_ctes/1
  # GET /cta_ctes/1.json
  def show
  end

  # GET /cta_ctes/new
  def new
    @cta_cte = CtaCte.new
  end

  # GET /cta_ctes/1/edit
  def edit
  end

  # POST /cta_ctes
  # POST /cta_ctes.json
  def create
    @cta_cte = CtaCte.new(cta_cte_params)

    respond_to do |format|
      if @cta_cte.save
        format.html { redirect_to @cta_cte, notice: 'Se creo correctamente.' }
        format.json { render :show, status: :created, location: @cta_cte }
      else
        format.html { render :new }
        format.json { render json: @cta_cte.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cta_ctes/1
  # PATCH/PUT /cta_ctes/1.json
  def update
    respond_to do |format|
      if @cta_cte.update(cta_cte_params)
        format.html { redirect_to @cta_cte, notice: 'Cta cte was successfully updated.' }
        format.json { render :show, status: :ok, location: @cta_cte }
      else
        format.html { render :edit }
        format.json { render json: @cta_cte.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cta_ctes/1
  # DELETE /cta_ctes/1.json
  def destroy
    @cta_cte.destroy
    respond_to do |format|
      format.html { redirect_to cta_ctes_url, notice: 'Cta cte was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cta_cte
      @cta_cte = CtaCte.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cta_cte_params
      params.require(:cta_cte).permit(:matriculacion_id, :nro_cta_cte)
    end
end
