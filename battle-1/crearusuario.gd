extends Control

# Esta función se debe conectar a la señal "pressed" de tu botón principal
func _on_presione_para_iniciar_pressed() -> void:
	print("Iniciando aventura... Redirigiendo al Login.")
	
	# Según tu captura, 'logindeusuario.tscn' está dentro de la carpeta 'login'
	# Si moviste los archivos, asegúrate de que esta ruta sea exacta:
	var ruta_login = "res://escenas/login/logindeusuario.tscn"
	
	if ResourceLoader.exists(ruta_login):
		get_tree().change_scene_to_file(ruta_login)
	else:
		print("Error: No encontré la escena de login en: ", ruta_login)
