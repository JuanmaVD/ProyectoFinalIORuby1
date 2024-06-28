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

  #Metodo para calcular PM
  def calcular_demanda_promedio
    product = Product.find(params[:product_id])
    n = params[:n].to_i
  
    # Verificar que n sea un número positivo
    if n <= 0
      render json: { error: 'El parámetro n debe ser un número positivo' }, status: :unprocessable_entity
      return
    end
  
    last_n_demands = Demand.find_by_sql([
      "SELECT demandaReal FROM demands WHERE product_id = ? ORDER BY created_at DESC LIMIT ?", product, n
    ])
    
    # Asegurarse de que se encontraron demandas
    if last_n_demands.size < n
      render json: { error: 'No se encontraron suficientes demandas' }, status: :unprocessable_entity
      return
    end
    
    
    demandaProyectadaPM = last_n_demands.map(&:demandaReal).sum.to_f / n
  
    render json: { demandaProyectadaPM: demandaProyectadaPM }, status: :ok
  end
  

  #Metodo para calcular PMP
  def calcular_demanda_promedio_ponderada
    product = Product.find(params[:product_id])
    n = params[:n].to_i
    weights = params[:weights].map(&:to_i)

    if weights.size != n
      render json: { error: 'El número de pesos debe coincidir con el número de demandas' }, status: :unprocessable_entity
      return
    end

    last_n_demands = Demand.find_by_sql([
      "SELECT demandaReal FROM demands WHERE product_id = ? ORDER BY created_at DESC LIMIT ?", product, n
    ])
    
    weighted_sum = last_n_demands.each_with_index.reduce(0) do |sum, (demand, index)|
      sum + (demand.demandaReal * weights[index])
    end
    demandaProyectadaPMP = weighted_sum / n.to_i

    render json: { demandaProyectadaPMP: demandaProyectadaPMP }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demand
      @demand = Demand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def demand_params
      params.require(:demand).permit(:demandaReal, :demandaProyectada, :product_id, :n, :weights, :demandaProyectadaPM, :demandaProyectadaPMP)
    end
end
