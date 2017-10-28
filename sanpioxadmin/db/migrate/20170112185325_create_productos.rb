class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombreproduct
      t.string :descripcion
      t.integer :cantidad
      t.integer :precio

      t.timestamps null: false
    end
  end
end
