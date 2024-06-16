class DemandsController < ApplicationController
  before_action :set_demand, only: %i[ show update destroy ]

  # GET /demands
  def index
    @demands = Demand.all

    render json: @demands
  end

  # GET /demands/1
  def show
    render json: @demand
  end

  # POST /demands
  def create
    @demand = Demand.new(demand_params)

    if @demand.save
      render json: @demand, status: :created, location: @demand
    else
      render json: @demand.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /demands/1
  def update
    if @demand.update(demand_params)
      render json: @demand
    else
      render json: @demand.errors, status: :unprocessable_entity
    end
  end

  # DELETE /demands/1
  def destroy
    @demand.destroy!
  end

  #Metodo para calcular Demanda PPM y PPMP
  # app/controllers/demands_controller.rb
  def calculate_and_create
    product = Product.find(params[:product_id])
    n = params[:n].to_i

    # Obtener las últimas N demandas para el producto
    last_n_demands = product.demands.order(created_at: :desc).limit(n)

    # Calcular demandaPPM (promedio de las demandas)
    demandaProyectadaPM = last_n_demands.average(:demandaReal)

    # Calcular demandaPPMP (promedio ponderado)
    total_weight = (1..n).sum
    weighted_sum = last_n_demands.each_with_index.reduce(0) do |sum, (demand, index)|
      sum + (demand.demandaReal * (n - index))
    end
    demandaProyectadaPMP = weighted_sum / total_weight.to_f

    # Crear una nueva instancia de Demand con los valores calculados
    new_demand = product.demands.build(demandaProyectadaPM: demandaProyectadaPM, demandaProyectadaPMP: demandaProyectadaPMP)

    if new_demand.save
      render json: new_demand, status: :created
    else
      render json: new_demand.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demand
      @demand = Demand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def demand_params
      params.require(:demand).permit(:demandaReal, :demandaProyectada, :product_id, :n)
    end
end
