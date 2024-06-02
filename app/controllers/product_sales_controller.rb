class ProductSalesController < ApplicationController
  before_action :set_product_sale, only: %i[ show update destroy ]

  # GET /product_sales
  def index
    @product_sales = ProductSale.all

    render json: @product_sales
  end

  # GET /product_sales/1
  def show
    render json: @product_sale
  end

  # POST /product_sales
  def create
    @product_sale = ProductSale.new(product_sale_params)

    if @product_sale.save
      render json: @product_sale, status: :created, location: @product_sale
    else
      render json: @product_sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_sales/1
  def update
    if @product_sale.update(product_sale_params)
      render json: @product_sale
    else
      render json: @product_sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_sales/1
  def destroy
    @product_sale.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_sale
      @product_sale = ProductSale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_sale_params
      params.require(:product_sale).permit(:totalCostoVentaProducto, :cantVentaProducto, :subTotalVentaProducto)
    end
end
