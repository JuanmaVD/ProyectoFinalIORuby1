class ProductProvider < ApplicationRecord
    belongs_to :provider, optional:true
    belongs_to :product, optional:true
end
