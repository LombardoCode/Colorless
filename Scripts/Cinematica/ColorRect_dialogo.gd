extends ColorRect

# Obtenemos los nodos hijo
onready var rich_label = $MarginContainer/RichTextLabel

var tamanio_ventana

# Asignamos unas variables dependientes para nuestro Tween
var timer
var tween_abrir
var tween_cerrar
var altura_deseada = 180
var duracion = 0.5
var tipo_tween = Tween.TRANS_CUBIC
var tipo_ease = Tween.EASE_OUT
var retardo = 2.0
var estado_tween = ""
var timer_inicial

func _ready():
	# Obtenemos el tamaño de ventana
	tamanio_ventana = Global.obtener_tamanio_ventana()
	
	# Le reducimos su altura y anchura hasta (0, 0)
	self.rect_size.y = 0
	
	# Creamos un tween y le asignamos unas propiedades
	tween_abrir = Tween.new()
	tween_cerrar = Tween.new()
	add_child(tween_abrir)
	add_child(tween_cerrar)
	tween_abrir.connect("tween_completed", self, "_tween_abrir_completado")
	tween_cerrar.connect("tween_completed", self, "_tween_cerrar_completado")
	
	var timer_inicial = Timer.new()
	add_child(timer_inicial)
	timer_inicial.connect("timeout", self, "_tiempo_agotado_inicial")
	timer_inicial.wait_time = 2.0
	timer_inicial.one_shot = true
	timer_inicial.start()
	
	set_process(true)

func _process(delta):
	pass
	# Posicionamos al color en el centro
	#self.rect_position = Vector2((tamanio_ventana.x / 2) - tamanio_deseado.x / 2, (tamanio_ventana.y / 2) - tamanio_deseado.y / 2)
	
	# Le indicamos su nuevo pivote (al centro de la figura)
	#self.rect_pivot_offset = Vector2(tamanio_deseado.x / 2, tamanio_deseado.y / 2)
	
	#self.set_rotation_degrees(self.get_rotation_degrees() + 1)

func abrir_dialogo():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_tiempo_agotado")
	timer.wait_time = 0.8
	timer.one_shot = false
	timer.start()
	

func cerrar_dialogo():
	tween_cerrar.interpolate_property(self, "rect_size", self.get_size(), Vector2(self.get_size().x, 0), duracion, tipo_tween, tipo_ease, 0)
	tween_cerrar.start()

func _tiempo_agotado():
	timer.stop()
	tween_abrir.interpolate_property(self, "rect_size", self.get_size(), Vector2(self.get_size().x, altura_deseada), duracion, tipo_tween, tipo_ease, 0)
	tween_abrir.start()

func _tiempo_agotado_inicial():
	#timer_inicial.stop()
	abrir_dialogo()

func _tween_abrir_completado(object, key):
	#print(object)
	#print(key)
	pass

func _tween_cerrar_completado(object, key):
	if (rich_label.index + 1) < rich_label.cantidad_dialogos:
		rich_label.index += 1
		
		if rich_label.index == 1:
			timer.wait_time = 7.0
		timer.start()
	#abrir_dialogo()
	
