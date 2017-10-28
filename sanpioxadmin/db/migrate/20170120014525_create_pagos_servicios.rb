class CreatePagosServicios < ActiveRecord::Migration
  def change
    create_table :pagos_servicios do |t|
      t.string :servicio
      t.integer :monto

      t.timestamps null: false
    end
  end
end
