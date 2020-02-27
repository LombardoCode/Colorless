extends AudioStreamPlayer

export(String) var ruta_cancion

func _ready():
	pass

func obtener_stream():
	if self.get_stream() != null:
		return self.get_stream()
	else:
		print("No tiene ningún stream cargado")
	

func esta_reproduciendose():
	return self.is_playing()
