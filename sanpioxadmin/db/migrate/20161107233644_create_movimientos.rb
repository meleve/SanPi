class CreateMovimientos < ActiveRecord::Migration
  def change
    create_table :movimientos do |t|
      t.integer :cta_cte_id
      t.integer :nro_mov
      t.string :descripcion
      t.integer :importe
      t.boolean :estado

      t.timestamps null: false
    end
    add_foreign_key(:movimientos, :cta_ctes)
  end
end
