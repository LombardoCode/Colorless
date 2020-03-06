extends Control

export(String) var escena_target

var b_nivel_1

func _ready():
	self.connect("button_up", self, "_presionado")
	self.connect("mouse_entered", self, "_hover")
	self.connect("mouse_exited", self, "_exited")
	$Timer.connect("timeout", self, "_tiempo_agotado", [escena_target])
	
	# Verificamos si el botón de "Continuar" puede estar activo o no
	if self.is_in_group("btn_continuar"):
		if SavingSystem.existe_archivo_partida():
			# Leemos el estado actual del nivel 1
			b_nivel_1 = SavingSystem.leer_datos().niveles.nivel_1
			# Habilitamos o deshabilitamos el botón de "Continuar"
			self.disabled = false if b_nivel_1 == true else true
	
	set_process(true)

func _process(_delta):
	var tamanio_pantalla = OS.get_window_size()
	self.set_pivot_offset(Vector2(tamanio_pantalla.x / 2, self.rect_size.y / 2))
	
	# Verificamos el estado del nivel 1
	#print("Existe el archivo: " + str(SavingSystem.existe_archivo_partida()))
	

func _presionado():
	get_tree().get_root().get_node("Node/Interfaz/Fade").set_visible(true)
	get_tree().get_root().get_node("Node/Interfaz/Fade/AnimationPlayer").play("fade_in")
	$Timer.start()
	
	# Si el jugador presionó el boton de "Nuevo juego"
	if self.is_in_group("btn_nuevo_juego"):
		# Borramos la partida actual
		if SavingSystem.existe_directorio() and SavingSystem.existe_archivo_partida():
			# Borramos el archivo de la partida actual
			SavingSystem.eliminar_partida()
			
			# Creamos un save fresco
			var datos_partida_frescos = SavingSystem.datos_a_guardar
			
			# Habilitamos el nivel 1 del videojuego
			datos_partida_frescos.niveles.nivel_1 = true
			
			# Guardamos los datos
			SavingSystem.guardar_datos(datos_partida_frescos)
			
	if self.is_in_group("btn_continuar"):
		if !SavingSystem.existe_archivo_partida():
			get_tree().quit()
		

func _hover():
	self.get_node("Tween").interpolate_property(self, "rect_scale", self.get_scale(), Vector2(1.2, 1.2), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	self.get_node("Tween").start()
	
func _exited():
	self.get_node("Tween").interpolate_property(self, "rect_scale", self.get_scale(), Vector2(1, 1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	self.get_node("Tween").start()
	
func _tiempo_agotado(escena_target):
	get_tree().change_scene(escena_target)
