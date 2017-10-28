class CreateCtaCtes < ActiveRecord::Migration
  def change
    create_table :cta_ctes do |t|
      t.integer :matriculacion_id
      t.integer :nro_cta_cte

      t.timestamps null: false
    end
    add_foreign_key(:cta_ctes, :matriculacions) 
  end
end
