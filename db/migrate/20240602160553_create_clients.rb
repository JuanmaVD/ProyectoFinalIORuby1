class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :nombreCliente
      t.string :apellidoCliente
      t.string :mailCliente
      t.integer :telefonoCliente

      t.timestamps
    end
  end
end
