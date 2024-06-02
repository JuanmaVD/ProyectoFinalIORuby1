require "test_helper"

class ProductPurchaseOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_purchase_order = product_purchase_orders(:one)
  end

  test "should get index" do
    get product_purchase_orders_url, as: :json
    assert_response :success
  end

  test "should create product_purchase_order" do
    assert_difference("ProductPurchaseOrder.count") do
      post product_purchase_orders_url, params: { product_purchase_order: { cantOrdenCompraProducto: @product_purchase_order.cantOrdenCompraProducto, subTotalCostoOrdenCompraProducto: @product_purchase_order.subTotalCostoOrdenCompraProducto, totalCostoOrdenCompraProducto: @product_purchase_order.totalCostoOrdenCompraProducto } }, as: :json
    end

    assert_response :created
  end

  test "should show product_purchase_order" do
    get product_purchase_order_url(@product_purchase_order), as: :json
    assert_response :success
  end

  test "should update product_purchase_order" do
    patch product_purchase_order_url(@product_purchase_order), params: { product_purchase_order: { cantOrdenCompraProducto: @product_purchase_order.cantOrdenCompraProducto, subTotalCostoOrdenCompraProducto: @product_purchase_order.subTotalCostoOrdenCompraProducto, totalCostoOrdenCompraProducto: @product_purchase_order.totalCostoOrdenCompraProducto } }, as: :json
    assert_response :success
  end

  test "should destroy product_purchase_order" do
    assert_difference("ProductPurchaseOrder.count", -1) do
      delete product_purchase_order_url(@product_purchase_order), as: :json
    end

    assert_response :no_content
  end
end
