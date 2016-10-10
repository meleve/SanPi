class CreateAlumnos < ActiveRecord::Migration
  def change
    create_table :alumnos do |t|
      t.string :nombre
      t.string :apellido
      t.string :ci
      t.date :fechanac
      t.string :lugarnac
      t.string :domicilio
      t.string :nombrema
      t.string :profesionma
      t.integer :cel
      t.string :nombrepa
      t.string :porfesionpa
      t.integer :celpa

      t.timestamps null: false
    end
  end
end
