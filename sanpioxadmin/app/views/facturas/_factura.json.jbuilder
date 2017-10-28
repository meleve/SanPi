json.extract! factura, :id, :usuario_id, :alumno_id, :nro_fac, :total, :created_at, :updated_at
json.url factura_url(factura, format: :json)