class Demand < ApplicationRecord
    belongs_to :product, optional: true
    after_create :calculate_eoq
    after_create :calculate_product_standard_deviation

  private

  def calculate_eoq
    product.calculate_eoq
  end
  
  def calculate_product_standard_deviation
    product.calculate_standard_deviation
  end

end
