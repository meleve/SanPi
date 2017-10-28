class CreateDetalleFacturas < ActiveRecord::Migration
  def change
    create_table :detalle_facturas do |t|
      t.integer :factura_id
      t.integer :matriculacion_id
      t.integer :nro_mov
      t.string :descripcion
      t.integer :importe

      t.timestamps null: false
    end
    add_foreign_key(:detalle_facturas, :facturas)
    add_foreign_key(:detalle_facturas, :matriculacions)
  end
end
