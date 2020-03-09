extends Label

# Variables exportables
export(String) var escena_target

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
var index = 0

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
onready var fade_out_final = get_node("/root/Node/Interfaz/Fade_out_final")

# Escenario (participantes del escenario)
onready var casa = get_node("/root/Node/Casa")
onready var piso_cesped = get_node("/root/Node/Menu_piso")
onready var piso_madera = get_node("/root/Node/Piso_madera")
onready var cama = get_node("/root/Node/Cama")
onready var entidad_maligna = get_node("/root/Node/Entidad_maligna")
onready var animacion_entidad_maligna = get_node("/root/Node/Entidad_maligna/AnimationPlayer")
onready var camara_entidad_maligna = get_node("/root/Node/Entidad_maligna/Camera2D")

# Escenas a instanciar

func _ready():
	# Aparecemos el fade inicial
	fade.show()
	
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
	
	# Creamos un Tween
	tween = Tween.new()
	add_child(tween)
	

func _process(delta):
	if self.visible:
		if Input.is_action_just_pressed("tecla_enter"):
			self.visible = false
			if texto_dialogo.index < (texto_dialogo.dialogos.size()):
				# Asignamos propiedades espciales para cada mensaje
				if texto_dialogo.index == 0:
					# Le asignamos un tiempo de espera al timer
					timer.wait_time = 10.0
					timer.start()
					
					# Creamos el tween de la carama asignamos unas propiedades especiales
					tween_camera = Tween.new()
					add_child(tween_camera)
					tween_camera.interpolate_property(camara, "zoom", zoom_camara[0], zoom_camara[1], duracion_zoom, camara_tipo_tween, camara_tipo_ease, 1.0)
					tween_camera.start()
					
					# Reproducimos la animación de "fade_in"
					tween.connect("tween_completed", self, "_tween_completado")
					tween.interpolate_property(fadeInOut, "color", fades[0], fades[1], duracion_fade, tipo_tween, tipo_ease, 3.0)
					tween.start()
				
				if texto_dialogo.index == 1:
					# Le asignamos un tiempo de espera al timer
					timer.wait_time = 5.0
					timer.start()
					
					tween.connect("tween_completed", self, "_tween_completado_2")
					tween.interpolate_property(fadeInOut, "color", fades[0], fades[1], duracion_fade, tipo_tween, tipo_ease, 0.5)
					tween.start()
				
				if texto_dialogo.index == 2:
					# Le asignamos un tiempo de espera al timer
					timer.wait_time = 7.5
					timer.start()
					
					# Mostramos la entidad maligna y reproducimos una animación
					entidad_maligna.show()
					animacion_entidad_maligna.play("acercandose_a_casa")
					
					# Movemos la cámara hacia dónde está la entidad maligna
					var timer_espera = Timer.new()
					add_child(timer_espera)
					timer_espera.wait_time = 4.0
					timer_espera.connect("timeout", self, "_apuntar_camara_a_entidad_maligna", [timer_espera])
					timer_espera.start()
				
				if texto_dialogo.index == 3:
					# Le asignamos un tiempo de espera al timer
					timer.wait_time = 8.5 #2.0
					timer.start()
					
					# Reproducimos la animación de "fade_in"
					tween.connect("tween_completed", self, "_tween_completado_3")
					tween.interpolate_property(fadeInOut, "color", fades[0], fades[1], duracion_fade, tipo_tween, tipo_ease, 0.5)
					tween.start()
				
				if texto_dialogo.index == 4:
					tween.connect("tween_completed", self, "_tween_completado_5")
					tween.interpolate_property(fadeInOut, "color", fades[0], fades[1], duracion_fade, tipo_tween, tipo_ease, 2.0)
					tween.interpolate_property(camara, "zoom", zoom_camara[0], zoom_camara[1], duracion_zoom, camara_tipo_tween, camara_tipo_ease, 1.0)
					tween.start()
					
					
				
			if index < (texto_dialogo.dialogos.size()):
				color_rect.cerrar_dialogo()
				index += 1

func _tiempo_fuera():
	if index < (texto_dialogo.dialogos.size()):
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

func _tween_completado_2(object, key):
	if tween.is_connected("tween_completed", self, "_tween_completado_2"):
		tween.disconnect("tween_completed", self, "_tween_completado_2")
		#tween.connect("tween_completed", self, "_tween_completado_3")
		# Escondemos y reaparecemos items de la cinemática
		casa.show()
		piso_cesped.show()
		piso_madera.hide()
		cama.hide()
		tween.interpolate_property(fadeInOut, "color", fades[1], fades[0], duracion_fade, tipo_tween, tipo_ease, 0)
		tween.start()
	
func _tween_completado_3(object, key):
	if tween.is_connected("tween_completed", self, "_tween_completado_3"):
		tween.disconnect("tween_completed", self, "_tween_completado_3")
		# Restablecemos la cámara principal
		camara.current = true
		tween.connect("tween_completed", self, "_tween_completado_4")
		tween.interpolate_property(fadeInOut, "color", fades[1], fades[0], duracion_fade, tipo_tween, tipo_ease, 0)
		tween.start()
	
func _apuntar_camara_a_entidad_maligna(timer_espera):
	camara_entidad_maligna.current = true
	timer_espera.stop()

func _tween_completado_4(object, key):
	animacion_entidad_maligna.play("adentrandose_a_casa")
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_reaparecer_pieles", [timer])
	timer.wait_time = 2.0
	timer.start()

func _reaparecer_pieles(timer):
	timer.stop()
	entidad_maligna.get_node("Pieles").show()

func _tween_completado_5(object, key):
	print("Pre-terminado")
	if tween.is_connected("tween_completed", self, "_tween_completado_5"):
		tween.disconnect("tween_completed", self, "_tween_completado_5")
		tween.connect("tween_completed", self, "_tween_completado_6")
		tween.interpolate_property(fadeInOut, "color", fades[1], fades[0], 2.4, tipo_tween, tipo_ease, 0)
		tween.interpolate_property(camara, "zoom", zoom_camara[1], zoom_camara[0], 6.0, camara_tipo_tween, camara_tipo_ease, 0)
		tween.interpolate_property(camara, "rotation_degrees", camara_rotacion[0], camara_rotacion[1], 8.0, camara_tipo_tween, camara_tipo_ease, 0)
		tween.start()
		
		# Creamos un timer para el fade-out final
		var timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", self, "_tiempo_agotado_fadeout", [timer])
		timer.wait_time = 4.0
		timer.start()
		
		# Desaparecemos y aparecemos items de la cinemática
		casa.hide()
		piso_cesped.hide()
		entidad_maligna.hide()
		piso_madera.show()
		cama.show()

func _tween_completado_6(object, key):
	pass

func _tiempo_agotado_fadeout(timer):
	# Detenemos el timer
	timer.stop()
	
	# Reaparecemos el fade out final
	fade_out_final.get_node("AnimationPlayer").play("fade_out_final")
	
	fade_out_final.get_node("AnimationPlayer").connect("animation_finished", self, "_terminado_el_fade_out_final")

func _terminado_el_fade_out_final(anim_name):
	if anim_name == "fade_out_final":
		# Creamos un save fresco
		var datos_partida_frescos = SavingSystem.datos_a_guardar
		
		# Habilitamos el nivel 1 del videojuego
		datos_partida_frescos.niveles.nivel_1 = true
		
		# Guardamos los datos
		SavingSystem.guardar_datos(datos_partida_frescos)
		
		get_tree().change_scene(escena_target)
