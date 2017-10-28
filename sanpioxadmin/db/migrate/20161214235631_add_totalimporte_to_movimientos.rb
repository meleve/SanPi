class AddTotalimporteToMovimientos < ActiveRecord::Migration
  def change
    add_column :movimientos, :totalimporte, :integer
    add_index :movimientos, :totalimporte
  end
end
