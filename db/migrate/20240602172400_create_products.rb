class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :nombreProducto
      t.string :descripcionProducto
      t.float :precioVentaProducto
      t.integer :stock
      t.integer :stockSeguridad
      t.integer :puntoPedido
      t.integer :cantidadOptimaPedido
      t.integer :cantidadOrdenesPorAño
      t.float :costoGestionInventario
      t.integer :tiempoEntreOrdenes
      t.float :costoAlmacenamiento
      t.float :desviacionEstandar
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
