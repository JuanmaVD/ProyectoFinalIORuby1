class Product < ApplicationRecord
    has_many :demands
    belongs_to :category, optional: true
    has_many :product_sales
end
