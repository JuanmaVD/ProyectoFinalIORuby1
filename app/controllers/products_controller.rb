class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy calculate_eoq calculate_reorder_point calculate_safety_stock]

  # GET /products
  def index
    @products = Product.includes(:category).all
    render json: @products.to_json(include: :category)
  end

  # GET /products/1
  def show
    @product = Product.includes(:demands).find(params[:id])
    render json: @product.to_json(include: :demands)
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  def calculate_eoq
    Product.calculate_eoq_for_product(params[:id])
    render json: @product
  end

  def calculate_reorder_point
    Product.calculate_reorder_point_for_product(params[:id])
    render json: @product
  end

  def calculate_safety_stock
    Product.calculate_safety_stock_for_product(params[:id])
    render json: @product
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:nombreProducto, :descripcionProducto, :precioProveedorProducto, :precioVentaProducto, :category_id, :stock, :order_cost, :holding_cost, :annual_demand)
  end
end