extends Node

var musica
export (String) var nombre_nivel

func _ready():
	# No sé si eliminarlo o no
	Global.reproducir_musica()
	
	# Iniciamos le nivel con una animación de entrada
	Global.animacion_nivel.decrecer()
	
	# Indicador de niveles dentro del GameState
	if get_node("Interfaz").has_node("Indicador_nivel/Texto_nivel"):
		$Interfaz/Indicador_nivel/Texto_nivel.text = nombre_nivel
	pass
