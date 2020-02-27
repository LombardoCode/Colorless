extends ParallaxBackground

var screen_size = OS.window_size

func _ready():
	# Lo posicionamos en (0, 0)
	$Fondo.position = Vector2(0, 0)
	
	# Cambiamos su escala
	var tamanio_px = screen_size
	var tamanio_actual = $Fondo.texture.get_size()
	var escala_convertida = tamanio_px / tamanio_actual
	$Fondo.scale = escala_convertida
