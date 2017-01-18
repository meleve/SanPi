class Matriculacion < ActiveRecord::Base
	
	belongs_to :alumno
	
	belongs_to :curso
	has_many :cta_cte
	belongs_to :caja

	validates :alumno_id, :curso_id, presence: true

end
