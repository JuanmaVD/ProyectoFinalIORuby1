class CreateSells < ActiveRecord::Migration[7.1]
  def change
    create_table :sells do |t|
      t.string :estadoVenta
      t.float :totalCostoVenta
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
