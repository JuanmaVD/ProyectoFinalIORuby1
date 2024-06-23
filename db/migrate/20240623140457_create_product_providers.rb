class CreateProductProviders < ActiveRecord::Migration[7.1]
  def change
    create_table :product_providers do |t|
      t.float :PrecioProveedorProducto
      t.integer :TiempoEsperaProducto
      t.float :ZValue
      t.float :costoPedido
      t.references :provider, null: true, foreign_key: true
      t.references :product, null: true, foreign_key: true

      t.timestamps
    end
  end
end
