extends Control
@onready var label_monedas = $LabelMonedas # Asegúrate que el nombre coincida

func _ready():
	actualizar_interfaz_monedas()

func actualizar_interfaz_monedas():
	# Accedemos al valor que guardamos durante el Login
	label_monedas.text = str(DatosGlobales.monedas)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/loby/loby.tscn")
