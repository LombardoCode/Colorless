extends VBoxContainer

export(String) var escena_target

func _ready():
	# Configuramos el alpha inicial de los labels
	#$Label.modulate = alphas[0]
	#$Label2.modulate = alphas[0]
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_tiempo_agotado")
	timer.wait_time = 8.0
	timer.start()
	

func _tiempo_agotado():
	return get_tree().change_scene(escena_target)
