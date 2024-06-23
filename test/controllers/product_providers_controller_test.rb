require "test_helper"

class ProductProvidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_provider = product_providers(:one)
  end

  test "should get index" do
    get product_providers_url, as: :json
    assert_response :success
  end

  test "should create product_provider" do
    assert_difference("ProductProvider.count") do
      post product_providers_url, params: { product_provider: { PrecioProveedorProducto: @product_provider.PrecioProveedorProducto, TiempoEsperaProducto: @product_provider.TiempoEsperaProducto, ZValue: @product_provider.ZValue } }, as: :json
    end

    assert_response :created
  end

  test "should show product_provider" do
    get product_provider_url(@product_provider), as: :json
    assert_response :success
  end

  test "should update product_provider" do
    patch product_provider_url(@product_provider), params: { product_provider: { PrecioProveedorProducto: @product_provider.PrecioProveedorProducto, TiempoEsperaProducto: @product_provider.TiempoEsperaProducto, ZValue: @product_provider.ZValue } }, as: :json
    assert_response :success
  end

  test "should destroy product_provider" do
    assert_difference("ProductProvider.count", -1) do
      delete product_provider_url(@product_provider), as: :json
    end

    assert_response :no_content
  end
end
