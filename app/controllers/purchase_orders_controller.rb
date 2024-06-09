class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[ show update destroy ]

  # GET /purchase_orders
  def index
    @purchase_orders = PurchaseOrder.includes(:provider, product_purchase_orders: :product).all
    render json: @purchase_orders.to_json(include: {provider: {},product_purchase_orders: {include: :product}
    })
  end

  # GET /purchase_orders/1
  def show
    @purchase_order = PurchaseOrder.includes(:provider, product_purchase_orders: :product).find(params[:id])
    render json: @purchase_order.to_json(include: {provider: {}, product_purchase_orders: {include: :product}
    })
  end

  # POST /purchase_orders
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)

    if @purchase_order.save
      render json: @purchase_order, status: :created, location: @purchase_order
    else
      render json: @purchase_order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchase_orders/1
  def update
    if @purchase_order.update(purchase_order_params)
      render json: @purchase_order
    else
      render json: @purchase_order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /purchase_orders/1
  def destroy
    @purchase_order.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_order_params
      params.require(:purchase_order).permit(:totalCostoOrdenCompra, :estadoOrdenCompra, :fechaEstimadaEntrega, :provider_id)
    end
end
