class CreateMovCajas < ActiveRecord::Migration
  def change
    create_table :mov_cajas do |t|
      t.integer :caja_id
      t.string :concepto
      t.integer :ingreso
      t.integer :egreso
      t.integer :saldo

      t.timestamps null: false
    end
    add_foreign_key(:mov_cajas, :cajas)
  end
end
