class ProductPurchaseOrdersController < ApplicationController
  before_action :set_product_purchase_order, only: %i[ show update destroy ]

  # GET /product_purchase_orders
  def index
    @product_purchase_orders = ProductPurchaseOrder.all

    render json: @product_purchase_orders
  end

  # GET /product_purchase_orders/1
  def show
    render json: @product_purchase_order
  end

  # POST /product_purchase_orders
  def create
    @product_purchase_order = ProductPurchaseOrder.new(product_purchase_order_params)

    if @product_purchase_order.save
      render json: @product_purchase_order, status: :created, location: @product_purchase_order
    else
      render json: @product_purchase_order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_purchase_orders/1
  def update
    if @product_purchase_order.update(product_purchase_order_params)
      render json: @product_purchase_order
    else
      render json: @product_purchase_order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_purchase_orders/1
  def destroy
    @product_purchase_order.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_purchase_order
      @product_purchase_order = ProductPurchaseOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_purchase_order_params
      params.require(:product_purchase_order).permit(:totalCostoOrdenCompraProducto, :cantOrdenCompraProducto, :subTotalCostoOrdenCompraProducto)
    end
end
