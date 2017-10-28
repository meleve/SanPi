class CreateFacturas < ActiveRecord::Migration
  def change
    create_table :facturas do |t|
      t.integer :usuario_id
      t.integer :alumno_id
      t.integer :nro_fac
      t.integer :total

      t.timestamps null: false
    end
    add_foreign_key(:facturas, :usuarios)
    add_foreign_key(:facturas, :alumnos)
  end
end
