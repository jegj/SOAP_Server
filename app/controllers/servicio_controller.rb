class ServicioController < ApplicationController
	include WashOut::SOAP #La libreria para crear el Servicio

	# Crear un servicio
	soap_action "informacion_dispositivo", 
	:args => {:codigo =>:string, :temperatura =>:integer, :presion =>:integer},
	:return => {:mensaje=>{:codigo =>:string, :mensaje_temperatura=>:string, :mensaje_presion=>:string }}

	def informacion_dispositivo 
		codigo=params[:codigo]
		temp=params[:temperatura].to_i
		pre=params[:presion].to_i


		mensaje_temperatura=""
		mensaje_presion=""

		if pre>460
			mensaje_presion="Rojo"
		end

		if pre>400 && pre<460
			mensaje_presion="Amarillo"
		end
		if pre<400
			mensaje_presion="Verde"
		end
		if temp<=5
			mensaje_temperatura="Mucho_Frio"
		end
		if temp>5 && temp<=35
			mensaje_temperatura="Calido"
		end
		if temp>35
			mensaje_temperatura="Mucho_Calor"
		end

		render :soap=> {:mensaje => {:codigo =>codigo, :mensaje_temperatura=>mensaje_temperatura, :mensaje_presion=>mensaje_presion }}
	end
end
