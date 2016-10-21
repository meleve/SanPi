class CreateMatriculacions < ActiveRecord::Migration
  def change
    create_table :matriculacions do |t|
      t.integer :alumno_id
      t.integer :curso_id

      t.timestamps null: false
    end
  end
end
