class ProductPurchaseOrder < ApplicationRecord
    belongs_to :purchase_order, optional:true
    belongs_to :product, optional:true
    after_create :update_product_stock

def update_product_stock
    product.update(stock: product.stock + self.cantOrdenCompraProducto)
end
end
