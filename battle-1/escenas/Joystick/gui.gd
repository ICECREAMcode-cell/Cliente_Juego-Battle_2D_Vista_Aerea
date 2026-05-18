extends CanvasLayer

# --- REFERENCIAS ---
# Ajusta estas rutas a los nombres exactos de tus nodos de Joystick
@onready var joystick_izq = $JoistickIzquierdo
@onready var joystick_der = $JoistickDerecho
@onready var btn_correr = $correr

func _ready():
	# --- DETECCIÓN DE PLATAFORMA ---
	# Solo mostramos la GUI si estamos en Android o iOS
	var sistema = OS.get_name()
	if sistema == "Android" or sistema == "iOS":
		self.visible = true
	else:
		# Si quieres probarlo en PC sin que se oculte, comenta la línea de abajo
		self.visible = false

func _process(_delta):
	var jugador = get_tree().get_first_node_in_group("jugadores")
	if not jugador: return

	# 1. RECOLECTAR INFO DE LOS JOYSTICKS
	# Le pasamos la dirección que calculan las áreas al personaje
	jugador.dir_joystick_mov = joystick_izq.direccion
	jugador.dir_joystick_rot = joystick_der.direccion

	# 2. LÓGICA DEL BOTÓN ATRAPADO
	# Si el jugador NO está moviendo la palanca izquierda (está quieto)
	# y el sprint estaba activo, lo soltamos.
	if joystick_izq.direccion == Vector2.ZERO and jugador.esta_corriendo:
		jugador.esta_corriendo = false
		# Opcional: Cambiar el color del botón para avisar que se soltó
		btn_correr.release_focus()


func _on_correr_pressed() -> void:
	var jugador = get_tree().get_first_node_in_group("jugadores")
	if jugador:
		# Activamos las dos llaves para que salga disparado solo
		jugador.auto_movimiento = true
		jugador.esta_corriendo = true
