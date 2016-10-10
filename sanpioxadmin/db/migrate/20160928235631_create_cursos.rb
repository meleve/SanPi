class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :curso
      t.string :especalidad
      t.string :seccion
      t.integer :cuota
      t.integer :matricula
      t.integer :year

      t.timestamps null: false
    end
  end
end
