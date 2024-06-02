class ProductSale < ApplicationRecord
    belongs_to :sale
    has_many :products
end
