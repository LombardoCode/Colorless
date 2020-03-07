extends ColorRect

# Obtenemos los nodos hijo
#onready var rich_label = $MarginContainer/RichTextLabel

var tamanio_ventana

# Asignamos unas variables dependientes para nuestro Tween
var tween
var tamanio_deseado
var duracion = 1.0
var tipo_tween = Tween.TRANS_SINE
var tipo_ease = Tween.EASE_OUT
var retardo = 2.0

func _ready():
	# Obtenemos el tamaño de ventana
	tamanio_ventana = Global.obtener_tamanio_ventana()
	
	# Obtenemos la forma
	tamanio_deseado = Vector2(500, 500)
	
	# Le reducimos su altura y anchura hasta (0, 0)
	self.rect_size = Vector2(0, 0)
	
	# Creamos un tween y le asignamos unas propiedades
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "rect_size", self.get_size(), tamanio_deseado, duracion, tipo_tween, tipo_ease, retardo)
	tween.start()
	
	set_process(true)

func _process(delta):
	# Posicionamos al color en el centro
	self.rect_position = Vector2((tamanio_ventana.x / 2) - tamanio_deseado.x / 2, (tamanio_ventana.y / 2) - tamanio_deseado.y / 2)
	
	# Le indicamos su nuevo pivote (al centro de la figura)
	#self.rect_pivot_offset = Vector2(tamanio_deseado.x / 2, tamanio_deseado.y / 2)
	
	self.set_rotation_degrees(self.get_rotation_degrees() + 1)
