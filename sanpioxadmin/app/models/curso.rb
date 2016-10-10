class Curso < ActiveRecord::Base
	belongs_to :alumno

	validates :curso, :especalidad, :seccion, :cuota, :matricula, :year, presence: true
end
