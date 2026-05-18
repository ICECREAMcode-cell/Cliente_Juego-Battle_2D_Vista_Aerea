extends Control

@onready var http_request = $conexion1
@onready var input_usuario = $inputname
@onready var input_pass = $inputpasword

func _on_btcrearusuario_pressed() -> void:
	# Ruta corregida según tu estructura de carpetas vista anteriormente
	get_tree().change_scene_to_file("res://escenas/crearusuario/crearusuario.tscn")

func _on_btiniciarsecion_pressed() -> void:
	var u = input_usuario.text
	var p = input_pass.text
	
	if u == "" or p == "":
		print("No podés entrar sin datos, che.")
		return
		
	# El servidor C# espera "Nombre" y "Password"
	var datos = {
		"Nombre": u, 
		"Password": p
	}
	
	var json = JSON.stringify(datos)
	var headers = ["Content-Type: application/json"]
	
	# Usamos la URL base de tu Autoload DatosGlobales
	var url = DatosGlobales.url_api + "/login" 
	
	print("Intentando conectar a: ", url)
	http_request.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_conexion_1_request_completed(result, response_code, headers, body):
	var body_str = body.get_string_from_utf8()
	var respuesta = JSON.parse_string(body_str)
	
	# Si el servidor responde 200, los datos son correctos
	if response_code == 200 and respuesta != null:
		print("¡Acceso concedido!")
		
		# IMPORTANTE: Corregimos las llaves a Mayúsculas para que coincidan con SQL/C#
		DatosGlobales.usuario_id = respuesta["UsuarioID"]
		DatosGlobales.nombre_usuario = respuesta["Nombre"]
		DatosGlobales.monedas = respuesta["Monedas"]
		
		# Stats del personaje (Asegúrate que estos nombres coincidan con tu SELECT de C#)
		DatosGlobales.vida_max = respuesta["VidaTotal"]
		DatosGlobales.velocidad_sprint = respuesta["SprintTotal"]
		
		print("Bienvenido ", DatosGlobales.nombre_usuario, ". Monedas: ", DatosGlobales.monedas)
		
		# Redirigir al Lobby
		get_tree().change_scene_to_file("res://escenas/loby/loby.tscn")
			
	else:
		# Si falla (401 o 404), mostramos el error y vamos a la pantalla de error
		print("Error en el login. Código de respuesta: ", response_code)
		if respuesta and respuesta.has("mensaje"):
			print("Motivo: ", respuesta["mensaje"])
			
		get_tree().change_scene_to_file("res://escenas/error/error.tscn")
