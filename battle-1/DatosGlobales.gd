extends Node

# Datos del jugador que llenaremos al loguear
var usuario_id: int = 0
var nombre_usuario: String = ""
var monedas: int = 0
var vida_max: int = 100
var velocidad_sprint: float = 3.0
var clase_activa_id: int = 1

# Dirección del servidor (Tu IP de la laptop)
var url_api = "http://192.168.0.23:5000/api"