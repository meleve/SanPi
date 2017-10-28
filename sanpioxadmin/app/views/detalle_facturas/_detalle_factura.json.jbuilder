json.extract! detalle_factura, :id, :factura_id, :matriculacion_id, :nro_mov, :descripcion, :importe, :created_at, :updated_at
json.url detalle_factura_url(detalle_factura, format: :json)