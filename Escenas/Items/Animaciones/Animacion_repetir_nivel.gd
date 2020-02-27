extends ColorRect

var tamanio_ventana
var tamanio_forma
var tween
var accion = ""


func _ready():
	Global.animacion_nivel = self
	
	# Creamos un Tween
	tween = Tween.new()
	
	# Le asignamos una señal
	tween.connect("tween_all_completed", self, "reiniciar_nivel")
	
	# Lo agregamos al árbol
	add_child(tween)


func _process(delta):
	# Obtenemos el tamaño de ventana
	tamanio_ventana = Global.obtener_tamanio_ventana()
	
	# Obtenemos la forma
	tamanio_forma = self.rect_size
	
	# Posicionamos al color en el centro
	self.rect_position = Vector2((tamanio_ventana.x / 2) - tamanio_forma.x / 2, (tamanio_ventana.y / 2) - tamanio_forma.y / 2)
	
	# Le indicamos su nuevo pivote (al centro de la figura)
	self.rect_pivot_offset = Vector2(tamanio_forma.x / 2, tamanio_forma.y / 2)
	

func crecer():
	tween.interpolate_property(self, "rect_size", Vector2(0, 0), Vector2(2000, 2000), 0.8, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.interpolate_property(self, "rect_rotation", 0, 200, 0.8, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	accion = "reiniciar"


func decrecer():
	tween.interpolate_property(self, "rect_size", Vector2(2000, 2000), Vector2(0, 0), 0.8, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.interpolate_property(self, "rect_rotation", 200, 0, 0.8, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()


func reiniciar_nivel():
	if accion == "reiniciar":
		return get_tree().reload_current_scene()
