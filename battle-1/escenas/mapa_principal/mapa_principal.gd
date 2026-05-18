extends Node2D

# 1. Precargamos la escena de tu personaje
# Asegúrate de que esta sea la escena del CharacterBody2D y no solo los frames
var escena_jugador = preload("res://animaciones/caminar.tscn")

func _ready():
	# Llamamos a la función de spawn apenas inicia el mapa
	spamear_jugador()

func spamear_jugador():
	# 2. Verificamos que el SpawnPoint exista en la escena
	if has_node("SpawnPoint"):
		var jugador = escena_jugador.instantiate()
		
		# Lo posicionamos exactamente donde está tu Marker2D
		jugador.global_position = $SpawnPoint.global_position
		
		# Lo añadimos como hijo del mapa
		add_child(jugador)
		
		print("¡Jugador spawneado con éxito en el SpawnPoint!")
	else:
		# Si olvidaste poner el Marker2D, esto evita que el juego se rompa
		print("ERROR: No encontré el nodo 'SpawnPoint'. Revisa el nombre en la escena.")
		# Spawn de emergencia en una posición segura
		var jugador_emergencia = escena_jugador.instantiate()
		jugador_emergencia.global_position = Vector2(150, 150)
		add_child(jugador_emergencia)

# Esta función la llamará el Orquestador cuando el servidor diga "YES"
func _on_servidor_partida_lista():
	print("Servidor de C# confirmó: Partida Lista.")
	# Aquí es donde el personaje empezará a recibir los paquetes UDP
