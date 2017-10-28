class AddMontototalToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :montototal, :integer
    add_index :cursos, :montototal
  end
end
