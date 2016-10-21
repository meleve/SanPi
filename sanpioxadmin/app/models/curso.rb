class Curso < ActiveRecord::Base
	has_many :detalle_cursos

	validates :curso, :especialidad, :seccion, :year, presence: true
end
