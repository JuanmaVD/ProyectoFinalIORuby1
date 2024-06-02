class Sale < ApplicationRecord
    belongs_to :client, optional: true
    has_many :product_sales
end
