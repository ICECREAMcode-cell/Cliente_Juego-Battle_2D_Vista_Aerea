extends Area2D

# --- NODOS ---
@onready var palanca = $SpritePalanca
@onready var rango = $SpriteRango
@onready var colision = $CollisionShape2D

# --- VARIABLES ---
var radio: float
var event_index = -1
var direccion = Vector2.ZERO # Esta es la variable que leerá la GUI

func _ready():
	# Obtenemos el radio del círculo de colisión para los límites
	if colision and colision.shape is CircleShape2D:
		radio = colision.shape.radius
	else:
		radio = 64 # Valor por defecto si falla la detección

func _input(event):
	# 1. DETECTAR EL TOQUE INICIAL
	if event is InputEventScreenTouch:
		if event.pressed and event_index == -1:
			# Calculamos distancia desde el centro del joystick al toque
			var distancia = event.position.distance_to(global_position)
			if distancia < radio:
				event_index = event.index
				
		elif not event.pressed and event.index == event_index:
			# AL SOLTAR EL DEDO: Reseteamos todo
			event_index = -1
			palanca.position = Vector2.ZERO
			direccion = Vector2.ZERO
	
	# 2. DETECTAR EL MOVIMIENTO (DRAG)
	if event is InputEventScreenDrag and event.index == event_index:
		var vector_movimiento = event.position - global_position
		
		# Limitamos la palanca para que no se salga del SpriteRango
		palanca.position = vector_movimiento.limit_length(radio)
		
		# Calculamos la dirección (valor entre 0 y 1)
		# Dividimos por el radio para que sea proporcional al movimiento
		direccion = palanca.position / radio

# Nota: Ya no actualizamos al jugador aquí directamente. 
# Ahora la escena de GUI leerá la variable 'direccion' cada frame.
