class CreateProductPurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :product_purchase_orders do |t|
      t.float :totalCostoOrdenCompraProducto
      t.integer :cantOrdenCompraProducto
      t.float :subTotalCostoOrdenCompraProducto
      t.references :product, null: true, foreign_key: true
      t.references :purchase_order, null: true, foreign_key: true

      t.timestamps
    end
  end
end
