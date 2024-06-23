class ProductProvidersController < ApplicationController
  before_action :set_product_provider, only: %i[ show update destroy ]

  # GET /product_providers
  def index
    @product_providers = ProductProvider.all

    render json: @product_providers
  end

  # GET /product_providers/1
  def show
    render json: @product_provider
  end

  # POST /product_providers
  def create
    @product_provider = ProductProvider.new(product_provider_params)

    if @product_provider.save
      render json: @product_provider, status: :created, location: @product_provider
    else
      render json: @product_provider.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_providers/1
  def update
    if @product_provider.update(product_provider_params)
      render json: @product_provider
    else
      render json: @product_provider.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_providers/1
  def destroy
    @product_provider.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_provider
      @product_provider = ProductProvider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_provider_params
      params.require(:product_provider).permit(:PrecioProveedorProducto, :TiempoEsperaProducto, :ZValue)
    end
end
