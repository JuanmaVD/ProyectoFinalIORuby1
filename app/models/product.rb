class Product < ApplicationRecord
  has_many :demands
  belongs_to :category, optional: true
  has_many :product_sales
  has_many :product_purchase_orders
  has_many :purchase_orders, through: :product_purchase_orders
  has_many :sales, through: :product_sales
  belongs_to  :provider, optional: true

  def calculate_eoq
    self.annual_demand ||= demands.last.demandaProyectadaPM if demands.any?
    if annual_demand && order_cost && holding_cost
      self.eoq = Math.sqrt((2 * annual_demand * order_cost) / holding_cost)
      save
      return eoq
    else
      return "No se puede calcular EOQ"
    end
  end
  
  def calculate_reorder_point
    if demands.any? && provider&.lead_time
      daily_demand = demands.average(:demandaReal).to_f
      self.reorder_point = daily_demand * provider.lead_time
      save
      return reorder_point
    else
      return "No se puede calcular Reorder Point"
    end
  end
  
  def calculate_safety_stock
    if demands.any? && provider&.lead_time && provider&.z_value
      demand_std_dev = demands.pluck(:demandaReal).standard_deviation
      self.safety_stock = provider.z_value * demand_std_dev * Math.sqrt(provider.lead_time)
      save
      return safety_stock
    else
      return "No se puede calcular Safety Stock"
    end
  end
  

  def self.calculate_eoq_for_product(product_id)
    product = Product.find(product_id)
    product.calculate_eoq
  end

  def self.calculate_reorder_point_for_product(product_id)
    product = Product.find(product_id)
    product.calculate_reorder_point
  end

  def self.calculate_safety_stock_for_product(product_id)
    product = Product.find(product_id)
    product.calculate_safety_stock
  end
end