class CreatePurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_orders do |t|
      t.float :totalCostoOrdenCompra
      t.integer :estadoOrdenCompra
      t.datetime :fechaEstimadaEntrega
      t.references :provider, null: true, foreign_key: true
      

      t.timestamps
    end
  end
end
