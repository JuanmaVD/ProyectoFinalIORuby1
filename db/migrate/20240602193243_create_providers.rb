class CreateProviders < ActiveRecord::Migration[7.1]
  def change
    create_table :providers do |t|
      t.string  :nombreProveedor
      t.integer :lead_time
      t.float   :z_value
      t.timestamps
    end
  end
end