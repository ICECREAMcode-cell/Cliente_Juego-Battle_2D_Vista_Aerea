# Dentro de AreaMovimiento.gd
extends Control

var direccion = Vector2.ZERO
var tocando = false

func _gui_input(event):
	if event is InputEventScreenTouch:
		tocando = event.pressed
		if not tocando:
			direccion = Vector2.ZERO
			actualizar_jugador()
			
	if event is InputEventScreenDrag:
		# Calculamos la dirección basándonos en cuánto moviste el dedo
		# desde donde empezaste a tocar
		direccion = event.relative.normalized()
		actualizar_jugador()

func actualizar_jugador():
	var jugador = get_tree().get_first_node_in_group("jugador")
	if jugador:
		jugador.dir_joystick_mov = direccion
