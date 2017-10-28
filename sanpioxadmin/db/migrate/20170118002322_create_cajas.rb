class CreateCajas < ActiveRecord::Migration
  def change
    create_table :cajas do |t|
      t.integer :usuario_id
      t.datetime :fechaApertura
      t.datetime :fechaCierre
      t.integer :apertura
      t.integer :cierre
      t.integer :entrada
      t.integer :salida
      t.boolean :estado

      t.timestamps null: false
    end
    add_foreign_key(:cajas, :usuarios)
  end
end
