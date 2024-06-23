class Demand < ApplicationRecord
    belongs_to :product, optional: true
    after_create :calculate_eoq

  private

  def calculate_eoq
    product.calculate_eoq
  end
  
end
