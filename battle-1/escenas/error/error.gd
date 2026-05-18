extends Control

func _ready() -> void:
	# Apenas entre a la pantalla de error, esperamos 2 segundos
	print("Mostrando error... esperando 2 segundos.")
	await get_tree().create_timer(2.0).timeout
	
	# Después de los 2 segundos, lo mandamos a registro
	print("Redirigiendo a crear cuenta.")
	get_tree().change_scene_to_file("res://crearusuario.tscn")
