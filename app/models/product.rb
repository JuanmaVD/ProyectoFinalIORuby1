class Product < ApplicationRecord
    has_many :demands
    belongs_to :category, optional: true
    has_many :product_sales
    has_many :product_purchase_orders
    has_many :purchase_orders, through: :product_purchase_orders
end
