class Product < ApplicationRecord
    has_many :demands
    belongs_to :category, optional: true
    belongs_to :product_sale, optional: true
end
