class CreateDemands < ActiveRecord::Migration[7.1]
  def change
    create_table :demands do |t|
      t.integer :demandaReal
      t.integer :demandaProyectadaPM
      t.float :ErrorDemandaProyectadaPM
      t.integer :demandaProyectadaPMP
      t.float :ErrorDemandaProyectadaPMP
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
