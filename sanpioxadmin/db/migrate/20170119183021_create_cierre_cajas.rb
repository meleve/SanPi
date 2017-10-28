class CreateCierreCajas < ActiveRecord::Migration
  def change
    create_table :cierre_cajas do |t|
      t.integer :usuario_id
      t.datetime :fApertura
      t.datetime :fCierre
      t.integer :apertura
      t.integer :cierre
      t.integer :entrada
      t.integer :salida
      t.boolean :estado

      t.timestamps null: false
    end
  end
end
