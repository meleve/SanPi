class Alumno < ActiveRecord::Base
	has_many :cursos
	has_many :matriculacions
	 
	validates :nombre, :apellido, :ci, :fechanac, :lugarnac, :domicilio, presence: true
end
