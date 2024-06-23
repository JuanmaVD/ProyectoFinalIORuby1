class Product < ApplicationRecord
    has_many :demands
    belongs_to :category, optional: true
    has_many :product_sales
    has_many :product_purchase_orders
    has_many :purchase_orders, through: :product_purchase_orders
    has_many :product_sales
    has_many :sales, through: :product_sales
    has_many :product_providers
    has_many :providers, through: :product_providers
    def calculate_eoq
        # Obtener las demandas excluyendo la más reciente
        demands_to_consider = demands.order(created_at: :desc).offset(1).limit(12)
        puts "Demandas consideradas: #{demands_to_consider.map(&:demandaReal)}"
        # Verificar que haya al menos 12 demandas para considerar
        return if demands_to_consider.size < 12
    
        # Sumar las 12 demandas
        total_demand = 0
        demands_to_consider.each do |demand|
            total_demand += demand.demandaReal
        end
        puts "Total de la demanda sumada: #{total_demand}"
        # Obtener el costo de pedido y costo de almacenamiento
        product_provider = product_providers.first
        costo_pedido = product_provider.costoPedido || 0
        costo_almacenamiento = self.costoAlmacenamiento || 1 # Evitar división por cero
    
        # Calcular EOQ usando la fórmula 
        eoq = Math.sqrt((2 * total_demand * costo_pedido) / costo_almacenamiento)
    
        # Actualizar el campo cantidadOptimaPedido
        update(cantidadOptimaPedido: eoq)
      end
end
