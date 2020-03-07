extends Label

onready var nodo_arbol = get_node("/root/Node/")

# FadeInOut
onready var fadeInOut = get_node("/root/Node/Interfaz/FadeInOut")
var fades = [Color(0, 0, 0, 0), Color(0, 0, 0, 1)]
var duracion_fade = 1.0
var tipo_tween = Tween.TRANS_QUINT
var tipo_ease = Tween.EASE_OUT
var tween

# Timer
var timer

# Componentes del dialogo
onready var color_rect = get_node("../../")
onready var texto_dialogo = get_node("../RichTextLabel")

# Camara
onready var camara
var tween_camera
var zoom_camara = [Vector2(1, 1), Vector2(0.6, 0.6)]
var duracion_zoom = 2.0
var camara_tipo_tween = Tween.TRANS_SINE
var camara_tipo_ease = Tween.EASE_OUT
var camara_rotacion = [-60, 0]

# Fade
onready var fade = get_node("/root/Node/Interfaz/Fade")

# Escenario (participantes del escenario)
onready var casa = get_node("/root/Node/Casa")
onready var piso_cesped = get_node("/root/Node/Menu_piso")
onready var piso_madera = get_node("/root/Node/Piso_madera")
onready var cama = get_node("/root/Node/Cama")

# Escenas a instanciar

func _ready():
	print(str(fades[0]) + " " + str(fades[1]))
	# Desaparecemos el anuncio
	self.visible = false
	
	# Creamos un Timer para aparecer de nuevo el mensaje de "[ ENTER ]"
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_tiempo_fuera")
	timer.wait_time = 4.0
	timer.one_shot = false
	timer.start()
	
	# Obtenemos el nodo de la camara
	camara = nodo_arbol.get_node("Camera2D")
	camara.rotating = true

func _process(delta):
	if self.visible:
		if Input.is_action_just_pressed("tecla_enter"):
			self.visible = false
			
			# Asignamos propiedades espciales para cada mensaje
			if texto_dialogo.index == 0:
				# Le asignamos un tiempo de espera al timer
				timer.wait_time = 10.0
				
				# Creamos el tween de la carama asignamos unas propiedades especiales
				tween_camera = Tween.new()
				add_child(tween_camera)
				tween_camera.interpolate_property(camara, "zoom", zoom_camara[0], zoom_camara[1], duracion_zoom, camara_tipo_tween, camara_tipo_ease, 1.0)
				tween_camera.start()
				
				# Reproducimos la animación de "fade_in"
				tween = Tween.new()
				add_child(tween)
				tween.connect("tween_completed", self, "_tween_completado")
				tween.interpolate_property(fadeInOut, "color", fades[0], fades[1], duracion_fade, tipo_tween, tipo_ease, 3.0)
				tween.start()
			
			timer.start()
			color_rect.cerrar_dialogo()

func _tiempo_fuera():
	timer.stop()
	self.visible = true

func _tween_completado(object, key):
	# Desconectamos el tween
	if tween.is_connected("tween_completed", self, "_tween_completado"):
		tween.disconnect("tween_completed", self, "_tween_completado")
		tween.interpolate_property(fadeInOut, "color", fades[1], fades[0], duracion_fade, tipo_tween, tipo_ease, 0)
		tween.start()
	
	# Ocultamos el piso y la piso pero mostramos la cama
	casa.hide()
	piso_cesped.hide()
	cama.show()
	piso_madera.show()
	
	tween_camera.interpolate_property(camara, "zoom", zoom_camara[1], zoom_camara[0], 8.0, camara_tipo_tween, camara_tipo_ease, 0)
	tween_camera.interpolate_property(camara, "rotation_degrees", camara_rotacion[0], camara_rotacion[1], 8.0, camara_tipo_tween, camara_tipo_ease, 0)
	tween_camera.start()
	
	
	print("YAAAAAA")
	
	# Hacemos un efecto de fade_out (transparencia)
	
	
	
	# Desoncetamos este método para que el tween no se vuelva a repetir
	#tween.disconnect("tween_completed", self, "_tween_completado")

