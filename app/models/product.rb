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
    after_update :recalculate_cantidad_ordenes_por_ano, if: :saved_change_to_cantidadOptimaPedido?
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
      def recalculate_cantidad_ordenes_por_ano
        # Obtener las demandas de este producto, excluyendo la más reciente
        demands_to_consider = demands.order(created_at: :desc).offset(1).limit(12)
    
        # Verificar que haya al menos 12 demandas para considerar
        if demands_to_consider.size < 12
          puts "No hay suficientes demandas para recalcular cantidadOrdenesPorAño. Se encontraron: #{demands_to_consider.size}"
          return
        end
    
        # Sumar las 12 demandas manualmente
        total_demand = 0
        demands_to_consider.each do |demand|
          total_demand += demand.demandaReal
        end
    
        # Verificar que cantidadOptimaPedido no sea cero
        if cantidadOptimaPedido == 0
          puts "Cantidad óptima de pedido es cero, no se puede calcular cantidadOrdenesPorAño"
          return
        end
    
        # Calcular cantidadOrdenesPorAño usando la fórmula cantidadOrdenesPorAño = total_demand / cantidadOptimaPedido
        cantidad_ordenes_por_ano = total_demand / cantidadOptimaPedido
    
        # Imprimir cantidadOrdenesPorAño para depuración
        puts "Cantidad de órdenes por año calculada: #{cantidad_ordenes_por_ano}"
    
        # Actualizar el campo cantidadOrdenesPorAño
        update_column(:cantidadOrdenesPorAño, cantidad_ordenes_por_ano)
      end
end
