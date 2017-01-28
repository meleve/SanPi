# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Usuario.create!(email:"",password:"",password_confirmation:"")

Alumno.create!(nombre: "Milagros", apellido: "Gomez", ci: "5645667", fechanac: "2016-11-09", lugarnac: "Encarnacion", domicilio: "Santa Maria", nombrema: "Maria", profesionma: "Vendedora", cel: "1234567", nombrepa: "Jose", porfesionpa: "Carpintero", celpa: "0987654")
Alumno.create!(nombre: "JOse", apellido: "Perez", ci: "23345546", fechanac: "2016-11-04", lugarnac: "Encarnacion", domicilio: "San Roque", nombrema: "Josefina", profesionma: "Comerciante", cel: "1234567", nombrepa: "Mariano", porfesionpa: "Carpintero", celpa: "0987654")
Alumno.create!(nombre: "Juan", apellido: "Gimenez", ci: "235465", fechanac: "2016-11-03", lugarnac: "Encarnacion", domicilio: "SAn Pedro", nombrema: "Marta", profesionma: "Cobrador", cel: "1234567", nombrepa: "DiMaria", porfesionpa: "Mecanico", celpa: "0987654")
Alumno.create!(nombre: "Jorge", apellido: "Gomez", ci: "6543245", fechanac: "2016-11-07", lugarnac: "Encarnacion", domicilio: "San Pedro", nombrema: "Merlina", profesionma: "Vendedora", cel: "1234567", nombrepa: "Roque", porfesionpa: "Vendedor", celpa: "0987654")
Alumno.create!(nombre: "Liza", apellido: "Benitez", ci: "23455764", fechanac: "2016-11-09", lugarnac: "Encarnacion", domicilio: "Santa Maria", nombrema: "Claudia", profesionma: "Peluquera", cel: "1234567", nombrepa: "Ruben", porfesionpa: "Carpintero", celpa: "0987654")
Alumno.create!(nombre: "Orlando", apellido: "Cubilla", ci: "875454", fechanac: "2016-11-09", lugarnac: "Encarnacion", domicilio: "Santa Maria", nombrema: "Maria", profesionma: "Vendedora", cel: "1234567", nombrepa: "Jose", porfesionpa: "Cobrador", celpa: "0987654")
Alumno.create!(nombre: "David", apellido: "Lopez", ci: "875454", fechanac: "2016-11-20", lugarnac: "Encarnacion", domicilio: "Santa Maria", nombrema: "Marta", profesionma: "Vendedora", cel: "1234567", nombrepa: "Jose Maria", porfesionpa: "Gerente", celpa: "0987654")
