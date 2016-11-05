class Matriculacion < ActiveRecord::Base
	belongs_to :alumno
	
	belongs_to :curso

	validates :alumno_id, :curso_id, presence: true

end
