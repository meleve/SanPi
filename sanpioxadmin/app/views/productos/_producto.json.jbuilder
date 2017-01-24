json.extract! producto, :id, :nombreproduct, :descripcion, :cantidad, :precio, :created_at, :updated_at
json.url producto_url(producto, format: :json)