# AreaRotacion.gd (Joystick Derecho)
extends Area2D

@onready var palanca = $Palanca
@onready var shape = $CollisionShape2D.shape

var radio: float
var event_index = -1

func _ready():
	radio = shape.radius

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and event_index == -1:
			if event.position.distance_to(global_position) < radio:
				event_index = event.index
		elif not event.pressed and event.index == event_index:
			event_index = -1
			palanca.position = Vector2.ZERO
			enviar_direccion(Vector2.ZERO)

	if event is InputEventScreenDrag and event.index == event_index:
		var vector = event.position - global_position
		palanca.position = vector.limit_length(radio)
		enviar_direccion(palanca.position.normalized())

func enviar_direccion(dir):
	var jugador = get_tree().get_first_node_in_group("jugador")
	if jugador:
		jugador.dir_joystick_rot = dir
