class CreateMatriculacions < ActiveRecord::Migration
  def change
    create_table :matriculacions do |t|
      t.integer :alumno_id
      t.integer :curso_id

      t.timestamps null: false
    end
    add_foreign_key(:matriculacions, :alumnos)
    add_foreign_key(:matriculacions, :cursos)
  end
end
