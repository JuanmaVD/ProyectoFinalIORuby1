require "test_helper"

class ProductSalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_sale = product_sales(:one)
  end

  test "should get index" do
    get product_sales_url, as: :json
    assert_response :success
  end

  test "should create product_sale" do
    assert_difference("ProductSale.count") do
      post product_sales_url, params: { product_sale: { cantVentaProducto: @product_sale.cantVentaProducto, subTotalVentaProducto: @product_sale.subTotalVentaProducto, totalCostoVentaProducto: @product_sale.totalCostoVentaProducto } }, as: :json
    end

    assert_response :created
  end

  test "should show product_sale" do
    get product_sale_url(@product_sale), as: :json
    assert_response :success
  end

  test "should update product_sale" do
    patch product_sale_url(@product_sale), params: { product_sale: { cantVentaProducto: @product_sale.cantVentaProducto, subTotalVentaProducto: @product_sale.subTotalVentaProducto, totalCostoVentaProducto: @product_sale.totalCostoVentaProducto } }, as: :json
    assert_response :success
  end

  test "should destroy product_sale" do
    assert_difference("ProductSale.count", -1) do
      delete product_sale_url(@product_sale), as: :json
    end

    assert_response :no_content
  end
end
