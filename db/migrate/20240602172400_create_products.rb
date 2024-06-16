class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :nombreProducto
      t.string :descripcionProducto
      t.float :precioProveedorProducto
      t.float :precioVentaProducto
      t.integer :stock
      t.integer :stockEmergencia
      t.integer :puntoPedido
      t.integer :demandaPM
      t.integer :demandaPMP
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
