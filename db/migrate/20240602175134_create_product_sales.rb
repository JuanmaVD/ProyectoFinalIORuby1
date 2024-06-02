class CreateProductSales < ActiveRecord::Migration[7.1]
  def change
    create_table :product_sales do |t|
      t.float :totalCostoVentaProducto
      t.integer :cantVentaProducto
      t.float :subTotalVentaProducto
      t.references :sale, null: true, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.timestamps
    end
  end
end
