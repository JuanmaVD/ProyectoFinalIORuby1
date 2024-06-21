class Provider < ApplicationRecord
    has_many :purchase_orders
    has_many :products
end
