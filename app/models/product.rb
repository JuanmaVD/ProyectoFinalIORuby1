class Product < ApplicationRecord
    has_many :demands
    belongs_to :category, optional: true
end
