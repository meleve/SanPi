class CreateDetalleCursos < ActiveRecord::Migration
  def change
    create_table :detalle_cursos do |t|
      t.integer :curso_id
      t.integer :cantidad
      t.string :descripcion
      t.date :vencimiento
      t.integer :importe
      t.integer :totalimporte

      t.timestamps null: false
    end
    add_foreign_key(:detalle_cursos, :cursos)
  end
end
