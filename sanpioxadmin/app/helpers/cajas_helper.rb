module CajasHelper
	 def cajaabierto
	 	@cajaabierto = Caja.where(estado: 0).last
	 end
end