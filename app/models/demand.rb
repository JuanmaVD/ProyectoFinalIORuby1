class Demand < ApplicationRecord
    belongs_to :product, optional: true
end
