class ProductSale < ApplicationRecord
    belongs_to :sale
    belongs_to :product
    after_create :update_product_stock

def update_product_stock
    product.update(stock: product.stock - self.cantVentaProducto)
end

end
