class CtaCte < ActiveRecord::Base
	belongs_to :matriculacion
	has_many :movimientos
end
