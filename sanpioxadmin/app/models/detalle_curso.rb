class DetalleCurso < ActiveRecord::Base
	belongs_to :curso

	#validates :curso_id, :cantidad, :descripcion, :vencimiento, :importe, presence: true
end
