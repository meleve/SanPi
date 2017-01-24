json.extract! pagos_servicio, :id, :servicio, :monto, :created_at, :updated_at
json.url pagos_servicio_url(pagos_servicio, format: :json)