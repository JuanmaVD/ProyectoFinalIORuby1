class PurchaseOrder < ApplicationRecord
    belongs_to :provider, optional:true
    has_many :product_purchase_orders
    has_many :products, through: :product_purchase_orders
end
