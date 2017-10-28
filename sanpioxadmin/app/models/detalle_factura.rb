class DetalleFactura < ActiveRecord::Base
	belongs_to :factura
	belongs_to :matriculacion
end
