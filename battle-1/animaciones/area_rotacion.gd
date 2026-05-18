# Dentro de AreaRotacion.gd
extends Control

func _gui_input(event):
	var direccion = Vector2.ZERO
	
	if event is InputEventScreenTouch:
		if not event.pressed:
			enviar_al_jugador(Vector2.ZERO)
			
	if event is InputEventScreenDrag:
		# Detectamos hacia dónde arrastras el dedo en la mitad derecha
		direccion = event.relative.normalized()
		enviar_al_jugador(direccion)

func enviar_al_jugador(dir):
	var jugador = get_tree().get_first_node_in_group("jugador")
	if jugador:
		# IMPORTANTE: Aquí mandamos a la variable de ROTACIÓN
		jugador.dir_joystick_rot = dir
