extends Control
var socket = PacketPeerUDP.new()

@onready var label_monedas = $LabelMonedas # Asegúrate que el nombre coincida

func _ready():
	actualizar_interfaz_monedas()

func actualizar_interfaz_monedas():
	# Accedemos al valor que guardamos durante el Login
	label_monedas.text = str(DatosGlobales.monedas)
func _on_button_pressed() -> void:
	# 127.0.0.1 es tu misma compu. El puerto 7001 es la Sala 1 de tu C#
	socket.connect_to_host("127.0.0.1", 7001)

	# Enviamos el paquete
	var mensaje = "CONECTAR:Carlos"
	socket.put_packet(mensaje.to_utf8_buffer())

	print("Mensaje enviado al servidor...")

	# Cambiamos a la escena del juego
	get_tree().change_scene_to_file("res://mapa_principal.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/Tienda/Tienda.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/Cambiar_personaje/Cambiar_per.tscn")
