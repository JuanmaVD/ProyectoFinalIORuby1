class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.float :totalCostoVenta
      t.references :client, null: true, foreign_key: true

      t.timestamps
    end
  end
end
