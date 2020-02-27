extends Node

func _ready():
	# Mandamos a llamar esta función cada se inicie un nuevo nivel
	# Fundamental en el transición de mundos donde la canción es distinta
	SavingSystem.guardar_datos()

