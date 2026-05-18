extends Control

# Esta función se activa cuando presionas el botón que pusiste al centro
func _on_button_pressed() -> void:
	print("Iniciando aventura... Redirigiendo al Login.")
	
	# Según tu captura, 'logindeusuario.tscn' está dentro de la carpeta 'login'
	# Si moviste los archivos, asegúrate de que esta ruta sea exacta:
	var ruta_login = "res://escenas/login/logindeusuario.tscn"
	
	if ResourceLoader.exists(ruta_login):
		get_tree().change_scene_to_file(ruta_login)
	else:
		print("Error: No encontré la escena de login en: ", ruta_login)
