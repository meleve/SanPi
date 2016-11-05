class Curso < ActiveRecord::Base
	
	has_many :matriculacions
	has_many :detalle_cursos

	validates :curso, :especialidad, :seccion, :year, presence: true

	accepts_nested_attributes_for :detalle_cursos, allow_destroy: true
end
