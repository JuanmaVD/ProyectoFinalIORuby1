class PurchaseOrder < ApplicationRecord
    belongs_to :provider, optional:true
    has_many :product_purchase_orders
    has_many :products, through: :product_purchase_orders
    enum estadoOrdenCompra: {pedido: 0, preparando: 1, en_camino: 2, entregado: 3}
    after_update :update_product_stock, if: :saved_change_to_estadoOrdenCompra? 

  

  def update_product_stock
    if entregado?
      product_purchase_orders.each do |product_purchase_order|
        product = product_purchase_order.product
        product.increment!(:stock, product_purchase_order.cantOrdenCompraProducto)
      end
    end
  end

  def update_total_costo_orden_compra
    total_costo = product_purchase_orders.sum(:totalCostoOrdenCompraProducto)
    update(totalCostoOrdenCompra: total_costo)
  end

end
