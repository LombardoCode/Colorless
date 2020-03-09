extends Node

onready var nodo_arbol = get_node("/root/Node")

func _ready():
	# Mandamos a llamar esta función cada se inicie un nuevo nivel
	# Fundamental en el transición de mundos donde la canción es distinta
	#SavingSystem.guardar_datos(SavingSystem.datos_a_guardar)
	
	if nodo_arbol.is_in_group("cinematica"):
		pass

