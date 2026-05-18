extends CharacterBody2D

# --- VARIABLES DE CONTROL ---
var auto_movimiento = false 
var esta_corriendo = false
var dir_joystick_mov = Vector2.ZERO
var dir_joystick_rot = Vector2.ZERO

@onready var anim = $Sprite2D/caminar

func _ready():
	add_to_group("jugadores")

func _physics_process(_delta):
	# 1. ENTRADAS DE PC (Teclado)
	var dir_teclado = Input.get_vector("mover_izquierda", "mover_derecha", "mover_arriba", "mover_abajo")
	
	# 2. ACTIVAR AUTO-RUN (Teclado 'Shift' o Botón Android)
	# Si presionas la tecla de sprint una vez, se activa el auto-movimiento
	if Input.is_action_just_pressed("sprint"):
		auto_movimiento = true
		esta_corriendo = true

	# 3. INTERRUPCIÓN (PC y Android)
	# Si el jugador intenta caminar manualmente, el auto-movimiento se apaga
	if dir_teclado != Vector2.ZERO or dir_joystick_mov != Vector2.ZERO:
		auto_movimiento = false
		# esta_corriendo = false # Opcional: descomenta si quieres que también deje de correr

	# 4. DETERMINAR DIRECCIÓN FINAL
	var direccion_final = Vector2.ZERO
	
	if auto_movimiento:
		# Camina hacia el frente (basado en su rotación actual)
		direccion_final = Vector2.RIGHT.rotated(rotation)
	else:
		# Usa el mando manual
		direccion_final = dir_joystick_mov if dir_joystick_mov != Vector2.ZERO else dir_teclado

	# 5. VELOCIDAD Y FÍSICAS
	var multiplicador = 1.8 if esta_corriendo else 1.0
	var velocidad_final = (DatosGlobales.velocidad_sprint * 100) * multiplicador
	
	if direccion_final != Vector2.ZERO:
		velocity = direccion_final * velocidad_final
	else:
		velocity = velocity.move_toward(Vector2.ZERO, velocidad_final)

	move_and_slide()

	# 6. ROTACIÓN (Dirección del auto-run)
	actualizar_rotacion()
	actualizar_animacion()

func actualizar_rotacion():
	if dir_joystick_rot != Vector2.ZERO:
		# En Android, el joystick derecho guía
		rotation = lerp_angle(rotation, dir_joystick_rot.angle(), 0.15)
	else:
		# --- LA CORRECCIÓN ESTÁ AQUÍ ---
		var mouse_pos = get_global_mouse_position()
		# Calculamos el ángulo DESDE el personaje HACIA el mouse
		var angulo_al_mouse = global_position.angle_to_point(mouse_pos)
		
		# Si el personaje sigue mirando de costado, prueba sumar o restar PI/2 (90°)
		rotation = lerp_angle(rotation, angulo_al_mouse, 0.15)

func actualizar_animacion():
	if anim == null: return
	if velocity.length() > 10:
		anim.speed_scale = 1.8 if esta_corriendo else 1.0
		if not anim.is_playing() or anim.current_animation != "caminar":
			anim.play("caminar")
	else:
		anim.stop()
		if has_node("Sprite2D"): $Sprite2D.frame = 0
