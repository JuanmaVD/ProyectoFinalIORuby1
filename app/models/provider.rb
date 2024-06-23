class Provider < ApplicationRecord
    has_many :purchase_orders
    has_many :product_providers
end
