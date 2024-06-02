class Sale < ApplicationRecord
    belongs_to :client, optional: true
    has_many :product_sales
    has_many :products, through: :product_sales
end
