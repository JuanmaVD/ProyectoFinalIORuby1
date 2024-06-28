class Demand < ApplicationRecord
    belongs_to :product, optional: true
    after_create :calculate_eoq
    after_create :calculate_product_standard_deviation
    after_create :calculate_product_reorder_point
    after_create :calculate_product_inventory_management_cost

  private

  def calculate_eoq
    product.calculate_eoq
    product.calculate_tiempo_entre_ordenes
  end
  
  def calculate_product_standard_deviation
    product.calculate_standard_deviation
    product.calculate_stock_security
  end

  def calculate_product_reorder_point
    product.calculate_reorder_point
  end

  def calculate_product_inventory_management_cost
    product.calculate_inventory_management_cost
  end

end
