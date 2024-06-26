class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show update destroy]

  # GET /products
  def index
    @sales = Sale.includes(:client, product_sales: :product).all
    render json: @sales.to_json(include: { client: {}, product_sales: { include: :product } })
  end

  # GET /sales/1
  def show
    @sale = Sale.includes(:client, product_sales: :product).find(params[:id])
    render json: @sale.to_json(include: { client: {}, product_sales: { include: :product } })
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:totalCostoVenta, :estadoVenta, :client_id)
    end
end
