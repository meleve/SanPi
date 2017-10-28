class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :curso
      t.string :especialidad
      t.string :seccion
      t.integer :year

      t.timestamps null: false
    end
  end
end
