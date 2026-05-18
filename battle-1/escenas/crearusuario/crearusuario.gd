extends Control

@onready var http_request = $conexion2
@onready var input_nombre = $inputname2
@onready var input_correo = $inputcorreo2
@onready var input_pass = $inputpasword2

func _on_volverlogin_pressed() -> void:
	# Ajustado a tu estructura de carpetas
	get_tree().change_scene_to_file("res://escenas/login/logindeusuario.tscn")

func validar_datos(n: String, c: String, p: String) -> bool:
	if n.length() < 3:
		print("El nombre es muy corto, che.")
		return false
	
	if not "@" in c or not "." in c:
		print("Ese correo no parece válido.")
		return false
		
	if p.length() < 4:
		print("Poné una clave más difícil, mínimo 4 números.")
		return false
		
	return true

func _on_btcrearusuario_pressed() -> void:
	var n = input_nombre.text
	var c = input_correo.text
	var p = input_pass.text
	
	if validar_datos(n, c, p):
		# Los nombres "Nombre", "Correo" y "Password" coinciden con tu RegistroDTO de C#
		var datos = {
			"Nombre": n,
			"Correo": c,
			"Password": p
		}
		
		var json = JSON.stringify(datos)
		var headers = ["Content-Type: application/json"]
		
		# Usamos la URL base de tu Autoload
		var url = DatosGlobales.url_api + "/registro"
		
		print("Enviando registro al servidor...")
		http_request.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_conexion_2_request_completed(result, response_code, headers, body):
	var body_str = body.get_string_from_utf8()
	var respuesta = JSON.parse_string(body_str)
	
	# Si el servidor responde 200, la transacción de las 6 tablas fue exitosa
	if response_code == 200:
		print("¡Éxito! Usuario y clases iniciales creados.")
		# Volvemos al login para que el nuevo Civil entre
		get_tree().change_scene_to_file("res://escenas/login/logindeusuario.tscn")
	else:
		var mensaje_error = "Error en el servidor"
		if respuesta and respuesta.has("mensaje"):
			mensaje_error = respuesta["mensaje"]
		
		print(mensaje_error + ". Código: ", response_code)
		# Opcional: Redirigir a tu escena de error
		# get_tree().change_scene_to_file("res://escenas/error/error.tscn")
