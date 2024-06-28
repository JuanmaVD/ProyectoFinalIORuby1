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
    after_update :check_and_create_purchase_order, if: :stock_less_than_or_equal_to_punto_pedido?
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
      def calculate_standard_deviation
        # Obtener las demandas excluyendo la más reciente
        demands_to_consider = demands.order(created_at: :desc).offset(1)
        total_demand_count = demands_to_consider.size
    
        # Verificar que haya al menos 2 demandas para considerar
        return if total_demand_count < 2
    
        # Convertir las demandas a un array de valores de demandaReal
        demand_values = demands_to_consider.map(&:demandaReal)

        # Calcular el promedio de las demandas
        total_demand_sum = demand_values.sum
        average_demand = total_demand_sum.to_f / total_demand_count
    
        # Calcular la sumatoria de (demanda - promedio)^2
        sum_of_squares = demands_to_consider.reduce(0) do |sum, demand|
          sum + (demand.demandaReal - average_demand) ** 2
        end
    
        # Calcular la desviación estándar
        standard_deviation = Math.sqrt(sum_of_squares / (total_demand_count - 1))

        #Imprimir resultados por pantalla
        puts "Demands to consider: #{demands_to_consider.map(&:demandaReal)}"
        puts "Total demand count: #{total_demand_count}"
        puts "sumaDemanda: #{total_demand_sum}"
        puts "Average demand: #{average_demand}"
        puts "Sum of squares: #{sum_of_squares}"
    
        # Actualizar el campo desviacionEstandar
        update(desviacionEstandar: standard_deviation)
      end
      def calculate_stock_security
        product_provider = product_providers.first
        return unless product_provider

        z_value = product_provider.ZValue
        tiempo_espera_producto = product_provider.TiempoEsperaProducto
        desviacion_estandar = self.desviacionEstandar.nil? ? 0 : self.desviacionEstandar
        puts "Zvalue: #{z_value}"
        puts "tiempo_espera: #{tiempo_espera_producto}"
        puts "deviacion_estandar: #{desviacion_estandar}"
    
        stock_seguridad = z_value * desviacion_estandar * tiempo_espera_producto
    
        update(stockSeguridad: stock_seguridad)
      end
      def calculate_reorder_point
        product_provider = product_providers.first
        return unless product_provider
    
        tiempo_espera_producto = product_provider.TiempoEsperaProducto
    
        last_demand = demands.order(created_at: :desc).first
        demanda_proyectada_ultimo_mes = last_demand.demandaProyectadaPM || last_demand.demandaProyectadaPMP || 0
    
        stock_seguridad = self.stockSeguridad || 0

        puts "TiempoEspera: #{tiempo_espera_producto}"
        puts "UltimaDemanda: #{demanda_proyectada_ultimo_mes}"
        puts "stockSeguridad: #{stock_seguridad}"
    
        reorder_point = demanda_proyectada_ultimo_mes + tiempo_espera_producto + stock_seguridad
    
        update(puntoPedido: reorder_point)
      end
      def calculate_inventory_management_cost
        product_provider = product_providers.first
        return unless product_provider
    
        precio_proveedor_producto = product_provider.PrecioProveedorProducto
        costo_pedido = product_provider.costoPedido
    
        # Obtener las últimas 12 demandas excluyendo la más reciente
        demands_to_consider = demands.order(created_at: :desc).offset(1).limit(12)
        demanda_anual_producto = demands_to_consider.sum(:demandaReal)

        # Si la suma da 0, intenta calcularla de otra forma
        if demanda_anual_producto.zero?
          demanda_anual_producto = demands_to_consider.inject(0) { |sum, demand| sum + demand.demandaReal.to_i }
        end
    
        costo_compra = precio_proveedor_producto * demanda_anual_producto
        costo_almacenamiento = self.costoAlmacenamiento * self.stock
        costo_pedido_total = costo_pedido * (demanda_anual_producto.to_f / self.stock)
    
        costo_gestion_inventario = costo_compra + costo_almacenamiento + costo_pedido_total

        puts "Precio Proveedor Producto: #{precio_proveedor_producto}"
        puts "Costo Pedido: #{costo_pedido}"
        puts "Demands to Consider: #{demands_to_consider.map(&:demandaReal)}"
        puts "Demanda Anual Producto: #{demanda_anual_producto}"
        puts "Costo Compra: #{costo_compra}"
        puts "Costo Almacenamiento: #{costo_almacenamiento}"
        puts "Costo Pedido Total: #{costo_pedido_total}"
        puts "stock: #{self.stock}"
    
        update(costoGestionInventario: costo_gestion_inventario)
      end
      def calculate_tiempo_entre_ordenes
        # Obtener las últimas 12 demandas excluyendo la más reciente
        demands_to_consider = demands.order(created_at: :desc).offset(1).limit(12)
        demanda_anual_producto = demands_to_consider.sum(:demandaReal)

        # Si la suma da 0, intenta calcularla de otra forma
        if demanda_anual_producto.zero?
          demanda_anual_producto = demands_to_consider.inject(0) { |sum, demand| sum + demand.demandaReal.to_i }
        end
    
        # Verificar que cantidadOptimaPedido no sea cero para evitar división por cero
        if cantidadOptimaPedido.to_i != 0
          tiempo_entre_ordenes = demanda_anual_producto / self.cantidadOptimaPedido
        else
          tiempo_entre_ordenes = 0
        end

        puts "Demanda anual del producto: #{demanda_anual_producto}"
        puts "Cantidad óptima de pedido: #{self.cantidadOptimaPedido}"
    
        # Actualizar el campo tiempoEntreOrdenes en el producto
        update(tiempoEntreOrdenes: tiempo_entre_ordenes)
      end
      private

  def stock_less_than_or_equal_to_punto_pedido?
    stock <= puntoPedido
  end

  def check_and_create_purchase_order
    # Obtener el último proveedor creado
    provider = Provider.last

    # Crear la orden de compra en estado 'en preparación'
    purchase_order = PurchaseOrder.create!(
      totalCostoOrdenCompra: cantidadOptimaPedido * costoGestionInventario,
      estadoOrdenCompra: :preparando,
      provider: provider
    )

    # Crear la relación entre el producto y la orden de compra
    product_purchase_orders.create!(
      totalCostoOrdenCompraProducto: costoGestionInventario,
      cantOrdenCompraProducto: cantidadOptimaPedido,
      subTotalCostoOrdenCompraProducto: cantidadOptimaPedido * costoGestionInventario,
      purchase_order: purchase_order
    )
  end
end
