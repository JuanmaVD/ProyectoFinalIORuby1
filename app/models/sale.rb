class Sale < ApplicationRecord
    belongs_to :client, optional: true
end
