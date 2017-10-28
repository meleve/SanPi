class Factura < ActiveRecord::Base
	has_many :detalle_facturas
	belongs_to :alumno
end
