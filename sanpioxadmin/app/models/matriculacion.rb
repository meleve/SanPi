class Matriculacion < ActiveRecord::Base
	belongs_to :alumno
	belongs_to :curso

	validates :alumno_id, :curso_id, presence: true

	accepts_nested_attributes_for :alumno, allow_destroy: true
	accepts_nested_attributes_for :curso, allow_destroy: true
end
