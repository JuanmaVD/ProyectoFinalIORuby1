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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demand
      @demand = Demand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def demand_params
      params.require(:demand).permit(:demandaReal, :demandaProyectada, :product_id)
    end
end
